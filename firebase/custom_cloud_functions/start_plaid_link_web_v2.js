const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code

exports.startPlaidLinkWebV2 = functions.https.onCall(async (data, context) => {
  if (!context.auth || !context.auth.uid) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated.",
    );
  }

  return {
    success: true,
    sessionId: "",
    webUrl: "",
  };
});
