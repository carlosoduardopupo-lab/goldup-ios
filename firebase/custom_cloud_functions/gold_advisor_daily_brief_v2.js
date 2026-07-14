const functions = require("firebase-functions");
const admin = require("firebase-admin");

// FlutterFlow initializes admin automatically
// DO NOT call admin.initializeApp()

exports.goldAdvisorDailyBriefV2 = functions.https.onCall(
  async (data, context) => {
    return null;
  },
);
