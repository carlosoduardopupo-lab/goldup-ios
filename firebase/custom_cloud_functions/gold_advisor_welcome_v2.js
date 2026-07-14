const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code
exports.goldAdvisorWelcomeV2 = functions
  .region("us-central1")
  .https.onCall(async (data, context) => {
    const uid = context.auth?.uid;

    if (!uid) {
      throw new functions.https.HttpsError("unauthenticated", "No autenticado");
    }

    // Tu código aquí...

    return {
      sent: true,
    };
  });
