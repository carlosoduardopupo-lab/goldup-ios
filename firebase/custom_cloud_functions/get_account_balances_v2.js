const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your codeconst functions = require('firebase-functions');
const functions = require("firebase-functions");
const admin = require("firebase-admin");
// Stub — el despliegue real se hace desde la terminal (firebase deploy)
exports.getAccountBalancesV2 = functions.https.onCall((data, context) => {
  return { success: true };
});
