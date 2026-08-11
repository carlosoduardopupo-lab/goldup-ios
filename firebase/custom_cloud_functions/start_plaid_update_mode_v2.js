const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code
const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code

exports.startPlaidUpdateModeV2 = functions
  .region("us-central1")
  .https.onCall(async (data, context) => {
    // ⚠️ PLACEHOLDER — la implementacion REAL vive en el repo:
    //      firebase/functions/plaid/startPlaidUpdateModeV2/index.js
    //    y se despliega con:
    //      firebase deploy --only functions:startPlaidUpdateModeV2
    //
    // Este cuerpo solo existe para que FlutterFlow registre la firma (el
    // parametro itemId) y genere la llamada. NUNCA debe desplegarse desde
    // FlutterFlow: sobrescribiria la funcion real.
    //
    // Lanza a proposito en vez de devolver algo. Si este stub llegara a
    // produccion, el fallo seria inmediato y evidente, en vez de un
    // "reconectar" que abre el navegador con una URL vacia.
    const itemId = (data && data.itemId) || null;

    throw new functions.https.HttpsError(
      "failed-precondition",
      "Placeholder de FlutterFlow: la implementacion real de " +
        "startPlaidUpdateModeV2 esta en el repo y se despliega con " +
        "firebase deploy. Este stub nunca debe estar activo en produccion.",
      { itemId, isPlaceholder: true },
    );
  });
