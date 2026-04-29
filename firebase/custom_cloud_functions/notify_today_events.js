const functions = require("firebase-functions");
const admin = require("firebase-admin");

// FlutterFlow initializes admin automatically
// DO NOT call admin.initializeApp()

const TZ = "America/Los_Angeles";

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

/* ===================== LOCAL TIME CHECK ===================== */

function isUserLocalEightAm(instant, timeZone) {
  const parts = new Intl.DateTimeFormat("en-US", {
    timeZone,
    hour12: false,
    hour: "2-digit",
    minute: "2-digit",
  }).formatToParts(instant);

  const hour = Number(parts.find((p) => p.type === "hour").value);
  const minute = Number(parts.find((p) => p.type === "minute").value);

  return hour === 8 && minute === 0;
}

/* ===================== NOTIFICATION TEXT ===================== */

function buildTitle(isIncome, isEvent, isSave, isExpenses) {
  if (isSave === true && isEvent === false) return "Ahorro programado";
  if (isIncome === true && isEvent === false && isSave === false)
    return "Ingreso programado";
  if (isExpenses === true) return "Gasto programado";
  if (isEvent === true && isSave === false) return "Evento financiero";
  return "Recordatorio";
}

function buildBody(docDate, type, description) {
  const parts = [];

  parts.push("Hoy");

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

/* ===================== MAIN FUNCTION ===================== */

exports.notifyTodayEvents = functions.pubsub
  .schedule("0 * * * *") // cada hora
  .timeZone("UTC")
  .onRun(async () => {
    const db = admin.firestore();
    const now = new Date();

    const usersSnap = await db.collection("user").get();
    if (usersSnap.empty) return null;

    for (const u of usersSnap.docs) {
      const userData = u.data() || {};
      const userRef = u.ref;

      const userTz = (userData.timeZone || TZ).toString();

      // 👇 SOLO 8:00 AM local
      if (!isUserLocalEightAm(now, userTz)) continue;

      const { startUtc, endUtc } = getTzDayRangeUtc(now, userTz);

      const { tokens, tokenDocs } = await getUserFcmTokens(userRef);
      if (!tokens.length) continue;

      const docsSnap = await db
        .collection("documents")
        .where("userRef", "==", userRef)
        .where("isNotificationSet", "==", true)
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
            body: buildBody(d.date?.toDate(), d.type, d.description),
          },
          data: {
            documentId: doc.id,
            userId: u.id,
            today: "true",
          },
        };

        const res = await sendToManyTokens(tokens, payload);
        await cleanupInvalidTokens(res, tokenDocs);
      }
    }

    return null;
  });
