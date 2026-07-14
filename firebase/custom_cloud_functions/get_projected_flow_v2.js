const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code
const functions = require("firebase-functions");
const admin = require("firebase-admin");

exports.getProjectedFlowV2 = functions.https.onCall(async (data, context) => {
  return {
    totalBalance: 0.0,
    chequingTotal: 0.0,
    savingsTotal: 0.0,
    creditTotal: 0.0,
    projectedIncome: 0.0,
    projectedExpenses: 0.0,
    projectedSavings: 0.0,
    internalAdjustment: 0.0,
    projectedFlow: 0.0,
    availableToSpend: 0.0,
    month: 0,
    year: 0,
    currency: "USD",
  };
  s;
});
