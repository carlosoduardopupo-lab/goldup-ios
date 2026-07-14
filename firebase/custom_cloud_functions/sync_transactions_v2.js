const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your codeconst functions = require('firebase-functions');
const functions = require("firebase-functions");
const admin = require("firebase-admin");

// FlutterFlow initializes admin automatically
// DO NOT call admin.initializeApp()

exports.syncTransactionsV2 = functions.https.onCall(async (data, context) => {
  return null;
});
