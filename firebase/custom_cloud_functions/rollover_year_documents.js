const functions = require("firebase-functions");
const admin = require("firebase-admin");

// FlutterFlow initializes admin automatically
// DO NOT call admin.initializeApp()

/* ===================== MAIN FUNCTION ===================== */

exports.rolloverYearDocuments = functions.pubsub
  .schedule("0 20 31 12 *") // 31 de diciembre, 8:00 PM
  .timeZone("America/Los_Angeles")
  .onRun(async () => {
    const db = admin.firestore();
    const now = new Date();

    const currentYear = now.getFullYear();
    const nextYear = currentYear + 1;

    const startOfDecember = new Date(currentYear, 11, 1, 0, 0, 0);
    const startOfNextYear = new Date(nextYear, 0, 1, 0, 0, 0);

    const usersSnap = await db.collection("user").get();
    if (usersSnap.empty) return null;

    for (const u of usersSnap.docs) {
      const userRef = u.ref;

      // 🔒 Evita duplicados
      const markerId = `${u.id}_${nextYear}`;
      const markerRef = db.collection("year_rollovers").doc(markerId);
      const markerSnap = await markerRef.get();
      if (markerSnap.exists) continue;

      const docsSnap = await db
        .collection("documents")
        .where("userRef", "==", userRef)
        .where(
          "date",
          ">=",
          admin.firestore.Timestamp.fromDate(startOfDecember),
        )
        .where("date", "<", admin.firestore.Timestamp.fromDate(startOfNextYear))
        .get();

      if (docsSnap.empty) continue;

      let batch = db.batch();
      let count = 0;

      for (const doc of docsSnap.docs) {
        const d = doc.data();

        if (d.isRecurrent !== true) continue;

        const baseDate = d.date?.toDate();
        if (!baseDate) continue;

        const frequencyCode = d.frequencyCode || 0;
        if (!frequencyCode) continue;

        const dates = generateDates(baseDate, frequencyCode, nextYear);

        for (const newDate of dates) {
          const newId = `${d.recurrenceId || doc.id}_${newDate.getTime()}`;
          const newRef = db.collection("documents").doc(newId);

          batch.set(newRef, {
            type: d.type ?? "",
            isIncome: d.isIncome === true,
            isExpenses: d.isExpenses === true,
            isSave: d.isSave === true, // ✅ ADDED (recommended)
            description: d.description ?? "",
            date: admin.firestore.Timestamp.fromDate(newDate),
            amount: d.amount ?? 0,
            isRecurrent: true,
            frequency: d.frequency ?? "",
            userRef: userRef,

            isEvent: d.isEvent === true, // ✅ FIXED (was isevent / d.isevent)

            recurrenceId: d.recurrenceId || doc.id,
            occurrenceKey: newId,
            frequencyCode: frequencyCode,

            isNotificationSet: d.isNotificationSet === true,
            isNotificationSent: false,
            notificationSentAt: null,
            notificationHoursBefore: null,
            notificationAt: d.notificationAt ?? null,
          });

          count++;

          if (count >= 450) {
            await batch.commit();
            batch = db.batch();
            count = 0;
          }
        }
      }

      if (count > 0) await batch.commit();

      await markerRef.set({
        userRef,
        nextYear,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }

    return null;
  });

/* ===================== GENERADOR ===================== */

function generateDates(startDate, frequencyCode, targetYear) {
  const out = [];

  let current = new Date(startDate);

  const limit = new Date(targetYear, 11, 31, 23, 59, 59);

  let stepDays = 0;
  let stepMonths = 0;

  // frequencyCode:
  // < 1000 => days step (1 daily, 7 weekly, 14 biweekly)
  // >= 1000 => months step (1001 monthly -> 1, 1003 quarterly -> 3, 1012 yearly -> 12)
  if (frequencyCode < 1000) {
    stepDays = frequencyCode;
  } else {
    stepMonths = frequencyCode - 1000;
  }

  const targetDay = current.getDate();

  while (true) {
    if (stepDays > 0) {
      current = new Date(current.getTime() + stepDays * 86400000);
    } else {
      const totalMonths =
        current.getFullYear() * 12 + current.getMonth() + stepMonths;
      const ny = Math.floor(totalMonths / 12);
      const nm = totalMonths % 12;

      const lastDay = new Date(ny, nm + 1, 0).getDate();
      const safeDay = Math.min(targetDay, lastDay);

      current = new Date(ny, nm, safeDay);
    }

    if (current > limit) break;

    if (current.getFullYear() === targetYear) {
      out.push(new Date(current));
    }
  }

  return out;
}
