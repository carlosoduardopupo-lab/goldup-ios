const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code
exports.startPlaidUpdateModeV2 = onCall(
  {
    region: "us-central1",
    secrets: [PLAID_CLIENT_ID, PLAID_SECRET],
    timeoutSeconds: 60,
    memory: "256MiB",
  },
  async (request) => {
    // ... mismo código ...
  },
);
