const functions = require("firebase-functions");
const admin = require("firebase-admin");

// FlutterFlow initializes admin automatically
// DO NOT call admin.initializeApp()

// Default fallback timezone if user doesn't have one
const DEFAULT_TZ = "America/Los_Angeles";

// Allowed hours for notifications (Premium)
const ALLOWED_NOTIFICATION_AT = new Set([24, 48, 72, 96]);

/* ===================== TIMEZONE HELPERS ===================== */

function getTimeZoneOffsetMinutes(timeZone, y, m, d, hh, mm, ss) {
  const utc = new Date(Date.UTC(y, m - 1, d, hh, mm, ss));

  const parts = new Intl.DateTimeFormat("en-US", {
    timeZone,
    hour12: false,
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
    hour: "2-digit",
    minute: "2-digit",
    second: "2-digit",
  }).formatToParts(utc);

  const ly = Number(parts.find((p) => p.type === "year").value);
  const lm = Number(parts.find((p) => p.type === "month").value);
  const ld = Number(parts.find((p) => p.type === "day").value);
  const lH = Number(parts.find((p) => p.type === "hour").value);
  const lM = Number(parts.find((p) => p.type === "minute").value);
  const lS = Number(parts.find((p) => p.type === "second").value);

  const asIfUtcMs = Date.UTC(ly, lm - 1, ld, lH, lM, lS);
  const realUtcMs = utc.getTime();

  return Math.round((asIfUtcMs - realUtcMs) / (60 * 1000));
}

// Given a target instant, return the UTC start/end of that *calendar day* in `timeZone`
function getTzDayRangeUtc(targetInstant, timeZone) {
  const parts = new Intl.DateTimeFormat("en-US", {
    timeZone,
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
  }).formatToParts(targetInstant);

  const y = Number(parts.find((p) => p.type === "year").value);
  const m = Number(parts.find((p) => p.type === "month").value);
  const d = Number(parts.find((p) => p.type === "day").value);

  // Using noon to avoid DST edge-cases
  const offsetMinutes = getTimeZoneOffsetMinutes(timeZone, y, m, d, 12, 0, 0);
  const startUtcMs = Date.UTC(y, m - 1, d, 0, 0, 0) - offsetMinutes * 60000;

  const nextDay = new Date(Date.UTC(y, m - 1, d + 1, 12, 0, 0));
  const nextParts = new Intl.DateTimeFormat("en-US", {
    timeZone,
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
  }).formatToParts(nextDay);

  const ny = Number(nextParts.find((p) => p.type === "year").value);
  const nm = Number(nextParts.find((p) => p.type === "month").value);
  const nd = Number(nextParts.find((p) => p.type === "day").value);

  const nextOffset = getTimeZoneOffsetMinutes(timeZone, ny, nm, nd, 12, 0, 0);
  const endUtcMs = Date.UTC(ny, nm - 1, nd, 0, 0, 0) - nextOffset * 60000;

  return {
    startUtc: new Date(startUtcMs),
    endUtc: new Date(endUtcMs),
  };
}

/* ===================== NOTIFICATION TEXT ===================== */

// ✅ Uses isEvent (schema) + isExpenses
function buildTitle(isIncome, isEvent, isSave, isExpenses) {
  if (isSave === true && isEvent === false) return "Próximo ahorro programado";
  if (isIncome === true && isEvent === false && isSave === false)
    return "Próximo ingreso programado";
  if (isExpenses === true) return "Próximo gasto programado";
  if (isEvent === true && isSave === false) return "Próximo evento financiero";
  return "Recordatorio";
}

// ✅ Format date in the user's timezone
function buildBody(docDate, type, description, userTz) {
  const formattedDate = docDate
    ? new Intl.DateTimeFormat("es-US", {
        timeZone: userTz || DEFAULT_TZ,
        weekday: "long",
        month: "long",
        day: "numeric",
      }).format(docDate)
    : "";

  const parts = [];
  if (formattedDate) parts.push(formattedDate);
  if (type) parts.push(type);
  if (description) parts.push(description);

  return parts.join(" • ") || "Tienes un recordatorio programado.";
}

/* ===================== FCM TOKENS ===================== */

async function getUserFcmTokens(userRef) {
  const snap = await userRef.collection("fcm_tokens").get();
  if (snap.empty) return { tokens: [], tokenDocs: [] };

  const tokens = [];
  const tokenDocs = [];

  snap.docs.forEach((doc) => {
    const t = (doc.data()?.fcm_token || "").toString().trim();
    if (t) {
      tokens.push(t);
      tokenDocs.push(doc);
    }
  });

  return { tokens, tokenDocs };
}

/* ===================== SEND MULTICAST ===================== */

async function sendToManyTokens(tokens, payload) {
  if (!tokens.length) return { responses: [], successCount: 0 };
  return admin.messaging().sendEachForMulticast({ tokens, ...payload });
}

async function cleanupInvalidTokens(res, tokenDocs) {
  if (!res?.responses?.length) return;
  await Promise.allSettled(
    res.responses.map((r, i) => {
      if (!r.success && r.error?.code?.includes("registration-token")) {
        return tokenDocs[i]?.ref.delete();
      }
    }),
  );
}

/* ===================== HOURS HELPERS ===================== */

function normalizeHoursBefore(n, fallback = 72) {
  const v = Number(n);
  return ALLOWED_NOTIFICATION_AT.has(v) ? v : fallback;
}

/* ===================== LOCAL TIME CHECK ===================== */

// Returns true iff `instant` is exactly 09:00 in `timeZone`
function isUserLocalNineAm(instant, timeZone) {
  const parts = new Intl.DateTimeFormat("en-US", {
    timeZone,
    hour12: false,
    hour: "2-digit",
    minute: "2-digit",
  }).formatToParts(instant);

  const hour = Number(parts.find((p) => p.type === "hour").value);
  const minute = Number(parts.find((p) => p.type === "minute").value);

  return hour === 9 && minute === 0;
}

/* ===================== MAIN FUNCTION ===================== */

exports.scheduleCalendarNotifications = functions.pubsub
  .schedule("0 * * * *") // every hour, minute 0
  .timeZone("UTC")
  .onRun(async () => {
    const db = admin.firestore();
    const now = new Date();

    // NOTE: Keep as 'user' because your userRef type is Doc Reference (user)
    const usersSnap = await db.collection("user").get();
    if (usersSnap.empty) return null;

    for (const u of usersSnap.docs) {
      const userData = u.data() || {};
      const userRef = u.ref;

      // ✅ User timezone (stored on user doc)
      const userTz = (userData.timeZone || DEFAULT_TZ).toString();

      // ✅ Only send at 9:00 AM user's local time
      if (!isUserLocalNineAm(now, userTz)) continue;

      const { tokens, tokenDocs } = await getUserFcmTokens(userRef);
      if (!tokens.length) continue;

      const isPremium = userData.isPremium === true;

      // ===================== CASE A: NOT PREMIUM =====================
      if (!isPremium) {
        const hoursBefore = 72;

        const targetInstant = new Date(now.getTime() + hoursBefore * 3600000);
        const { startUtc, endUtc } = getTzDayRangeUtc(targetInstant, userTz);

        const docsSnap = await db
          .collection("documents")
          .where("userRef", "==", userRef)
          .where("isNotificationSet", "==", true)
          .where("isNotificationSent", "==", false)
          .where("date", ">=", admin.firestore.Timestamp.fromDate(startUtc))
          .where("date", "<", admin.firestore.Timestamp.fromDate(endUtc))
          .get();

        if (docsSnap.empty) continue;

        for (const doc of docsSnap.docs) {
          const d = doc.data();

          const payload = {
            notification: {
              title: buildTitle(
                d.isIncome === true,
                d.isEvent === true,
                d.isSave === true,
                d.isExpenses === true,
              ),
              body: buildBody(d.date?.toDate(), d.type, d.description, userTz),
            },
            data: { documentId: doc.id, userId: u.id },
          };

          const res = await sendToManyTokens(tokens, payload);
          await cleanupInvalidTokens(res, tokenDocs);

          if (res.successCount > 0) {
            await doc.ref.update({
              isNotificationSent: true,
              notificationSentAt: admin.firestore.FieldValue.serverTimestamp(),
              notificationHoursBefore: hoursBefore,
            });
          }
        }

        continue;
      }

      // ===================== PREMIUM =====================
      const ajust = Number(userData.notificationAjustValue || 1);

      // ===================== CASE B: PREMIUM, AJUST = 1 (USER LEVEL) =====================
      if (ajust === 1) {
        const hoursBefore = normalizeHoursBefore(userData.notificationAt, 72);

        const targetInstant = new Date(now.getTime() + hoursBefore * 3600000);
        const { startUtc, endUtc } = getTzDayRangeUtc(targetInstant, userTz);

        const docsSnap = await db
          .collection("documents")
          .where("userRef", "==", userRef)
          .where("isNotificationSet", "==", true)
          .where("isNotificationSent", "==", false)
          .where("date", ">=", admin.firestore.Timestamp.fromDate(startUtc))
          .where("date", "<", admin.firestore.Timestamp.fromDate(endUtc))
          .get();

        if (docsSnap.empty) continue;

        for (const doc of docsSnap.docs) {
          const d = doc.data();

          const payload = {
            notification: {
              title: buildTitle(
                d.isIncome === true,
                d.isEvent === true,
                d.isSave === true,
                d.isExpenses === true,
              ),
              body: buildBody(d.date?.toDate(), d.type, d.description, userTz),
            },
            data: { documentId: doc.id, userId: u.id },
          };

          const res = await sendToManyTokens(tokens, payload);
          await cleanupInvalidTokens(res, tokenDocs);

          if (res.successCount > 0) {
            await doc.ref.update({
              isNotificationSent: true,
              notificationSentAt: admin.firestore.FieldValue.serverTimestamp(),
              notificationHoursBefore: hoursBefore,
            });
          }
        }

        continue;
      }

      // ===================== CASE C: PREMIUM, AJUST = 2 (DOCUMENT LEVEL) =====================
      // Group by allowed hours so we don't read tons of docs
      for (const hoursBefore of ALLOWED_NOTIFICATION_AT) {
        const targetInstant = new Date(now.getTime() + hoursBefore * 3600000);
        const { startUtc, endUtc } = getTzDayRangeUtc(targetInstant, userTz);

        const docsSnap = await db
          .collection("documents")
          .where("userRef", "==", userRef)
          .where("isNotificationSet", "==", true)
          .where("isNotificationSent", "==", false)
          .where("notificationAt", "==", hoursBefore) // per document
          .where("date", ">=", admin.firestore.Timestamp.fromDate(startUtc))
          .where("date", "<", admin.firestore.Timestamp.fromDate(endUtc))
          .get();

        if (docsSnap.empty) continue;

        for (const doc of docsSnap.docs) {
          const d = doc.data();

          const payload = {
            notification: {
              title: buildTitle(
                d.isIncome === true,
                d.isEvent === true,
                d.isSave === true,
                d.isExpenses === true,
              ),
              body: buildBody(d.date?.toDate(), d.type, d.description, userTz),
            },
            data: { documentId: doc.id, userId: u.id },
          };

          const res = await sendToManyTokens(tokens, payload);
          await cleanupInvalidTokens(res, tokenDocs);

          if (res.successCount > 0) {
            await doc.ref.update({
              isNotificationSent: true,
              notificationSentAt: admin.firestore.FieldValue.serverTimestamp(),
              notificationHoursBefore: hoursBefore,
            });
          }
        }
      }
    }

    return null;
  });
