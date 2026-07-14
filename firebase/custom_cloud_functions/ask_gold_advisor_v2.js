const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your codeconst functions = require('firebase-functions');
const admin = require("firebase-admin");

exports.askGoldAdvisorV2 = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "No autenticado");
  }
  return { response: "ok" };
});
