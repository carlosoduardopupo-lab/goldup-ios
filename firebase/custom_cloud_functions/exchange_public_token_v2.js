"use strict";

const admin = require("firebase-admin");
const https = require("https");
const { URL } = require("url");

const { setGlobalOptions } = require("firebase-functions/v2");
const { onCall, HttpsError } = require("firebase-functions/v2/https");
const { defineSecret, defineString } = require("firebase-functions/params");

// Init Admin (solo una vez)
if (!admin.apps.length) {
  admin.initializeApp();
}

// Global options (Gen2)
setGlobalOptions({
  region: "us-central1",
  maxInstances: 10,
});

// Params/Secrets (v7 compatible)
const PLAID_CLIENT_ID = defineSecret("PLAID_CLIENT_ID");
const PLAID_SECRET = defineSecret("PLAID_SECRET");
const PLAID_ENV = defineString("PLAID_ENV", { default: "sandbox" });

// Helpers (inline para no depender de ./helpers)
function plaidHost(env) {
  const e = String(env || "").toLowerCase();
  if (e === "production") return "https://production.plaid.com";
  if (e === "development") return "https://development.plaid.com";
  return "https://sandbox.plaid.com";
}

function postJson(host, path, bodyObj) {
  return new Promise((resolve, reject) => {
    const body = JSON.stringify(bodyObj || {});
    const u = new URL(host);

    const req = https.request(
      {
        method: "POST",
        hostname: u.hostname,
        path,
        headers: {
          "Content-Type": "application/json",
          "Content-Length": Buffer.byteLength(body),
          "Plaid-Version": "2020-09-14",
        },
        timeout: 15000,
      },
      (res) => {
        let data = "";
        res.on("data", (chunk) => (data += chunk));
        res.on("end", () => {
          let parsed = {};
          try {
            parsed = JSON.parse(data || "{}");
          } catch (e) {
            return reject(new Error(`Respuesta no JSON: ${data}`));
          }

          if (res.statusCode >= 200 && res.statusCode < 300) {
            return resolve(parsed);
          }

          const msg =
            parsed?.error_message ||
            parsed?.error_code ||
            data ||
            "Error Plaid";

          const err = new Error(msg);
          err.statusCode = res.statusCode;
          err.raw = parsed;
          return reject(err);
        });
      },
    );

    req.on("timeout", () => req.destroy(new Error("Timeout llamando a Plaid")));
    req.on("error", reject);
    req.write(body);
    req.end();
  });
}

// ✅ exchangePublicTokenV2 (Gen2)
exports.exchangePublicTokenV2 = onCall(
  { secrets: [PLAID_CLIENT_ID, PLAID_SECRET] },
  async (request) => {
    if (!request.auth?.uid) {
      throw new HttpsError("unauthenticated", "Debes estar logueado.");
    }

    const uid = request.auth.uid;

    // Recibir publicToken desde FlutterFlow
    const publicToken = request.data?.publicToken;
    if (!publicToken || typeof publicToken !== "string") {
      throw new HttpsError(
        "invalid-argument",
        "Falta publicToken en la llamada.",
      );
    }

    const host = plaidHost(PLAID_ENV.value());

    try {
      const resp = await postJson(host, "/item/public_token/exchange", {
        client_id: PLAID_CLIENT_ID.value(),
        secret: PLAID_SECRET.value(),
        public_token: publicToken,
      });

      // Guardar en users/{uid}
      await admin
        .firestore()
        .collection("users")
        .doc(uid)
        .set(
          {
            publicToken: publicToken, // opcional
            access_token: resp.access_token,
            item_id: resp.item_id,
            request_id: resp.request_id || null,
            plaidLinkedAt: admin.firestore.FieldValue.serverTimestamp(),
          },
          { merge: true },
        );

      // Retornar camelCase pa’ FlutterFlow
      return {
        accessToken: resp.access_token,
        itemId: resp.item_id,
        requestId: resp.request_id || null,
      };
    } catch (e) {
      console.error("exchangePublicTokenV2 error:", e?.raw || e);
      throw new HttpsError(
        "internal",
        `Error exchange token: ${e?.message || "Fallo"}`,
      );
    }
  },
);
