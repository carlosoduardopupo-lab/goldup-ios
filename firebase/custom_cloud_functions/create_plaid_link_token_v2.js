"use strict";

const admin = require("firebase-admin");
const https = require("https");
const { URL } = require("url");

const { setGlobalOptions } = require("firebase-functions/v2");
const { onCall, HttpsError } = require("firebase-functions/v2/https");
const { defineSecret, defineString } = require("firebase-functions/params");

// ---------- Init Admin (solo una vez) ----------
try {
  admin.app();
} catch (e) {
  admin.initializeApp();
}

// ---------- Global options (Gen2) ----------
setGlobalOptions({
  region: "us-central1",
  maxInstances: 10,
});

// ---------- Params / Secrets (v7 compatible) ----------
const PLAID_CLIENT_ID = defineSecret("PLAID_CLIENT_ID");
const PLAID_SECRET = defineSecret("PLAID_SECRET");
const PLAID_ENV = defineString("PLAID_ENV", { default: "sandbox" }); // sandbox|development|production

// ---------- Helpers ----------
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
          // Recomendado por Plaid
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
            (parsed && parsed.error_message) ||
            (parsed && parsed.error_code) ||
            data ||
            "Error Plaid";

          const err = new Error(msg);
          err.statusCode = res.statusCode;
          err.raw = parsed;
          return reject(err);
        });
      },
    );

    req.on("timeout", () => {
      req.destroy(new Error("Timeout llamando a Plaid"));
    });

    req.on("error", reject);
    req.write(body);
    req.end();
  });
}

// ======================================================
// createPlaidLinkTokenV2
// ======================================================
exports.createPlaidLinkTokenV2 = onCall(
  { secrets: [PLAID_CLIENT_ID, PLAID_SECRET] },
  async (request) => {
    if (!request.auth?.uid) {
      throw new HttpsError("unauthenticated", "Necesitas estar logueado.");
    }

    const clientId = PLAID_CLIENT_ID.value();
    const secret = PLAID_SECRET.value();
    const env = PLAID_ENV.value();
    const host = plaidHost(env);

    try {
      const resp = await postJson(host, "/link/token/create", {
        client_id: clientId,
        secret,
        client_name: "Gold Up",
        language: "es",
        country_codes: ["US"],
        user: { client_user_id: request.auth.uid },
        products: ["transactions"],
      });

      return {
        link_token: resp.link_token,
        expiration: resp.expiration || null,
        request_id: resp.request_id || null,
      };
    } catch (e) {
      console.error("Plaid link/token/create error:", e?.raw || e);
      throw new HttpsError(
        "internal",
        `Plaid error: ${e?.message || "No se pudo crear el link token."}`,
      );
    }
  },
);

// ======================================================
// exchangePublicTokenV2  (request.data.publicToken)
// ======================================================
exports.exchangePublicTokenV2 = onCall(
  { secrets: [PLAID_CLIENT_ID, PLAID_SECRET] },
  async (request) => {
    if (!request.auth?.uid) {
      throw new HttpsError("unauthenticated", "Necesitas estar logueado.");
    }

    const publicToken = request.data?.publicToken;
    if (!publicToken || typeof publicToken !== "string") {
      throw new HttpsError("invalid-argument", "Falta publicToken.");
    }

    const clientId = PLAID_CLIENT_ID.value();
    const secret = PLAID_SECRET.value();
    const env = PLAID_ENV.value();
    const host = plaidHost(env);

    try {
      const resp = await postJson(host, "/item/public_token/exchange", {
        client_id: clientId,
        secret,
        public_token: publicToken,
      });

      // opcional: guardar en Firestore (ajústalo a tu esquema)
      await admin
        .firestore()
        .collection("plaid_items")
        .add({
          userRef: admin.firestore().doc(`users/${request.auth.uid}`),
          publicToken,
          accessToken: resp.access_token,
          itemId: resp.item_id,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });

      return {
        accessToken: resp.access_token,
        itemId: resp.item_id,
        requestId: resp.request_id || null,
      };
    } catch (e) {
      console.error("exchangePublicTokenV2 error:", e?.raw || e);
      throw new HttpsError(
        "internal",
        `Plaid error: ${e?.message || "No se pudo intercambiar el token."}`,
      );
    }
  },
);

// ======================================================
// getAccountBalancesV2  (request.data.accessToken)
// ======================================================
exports.getAccountBalancesV2 = onCall(
  { secrets: [PLAID_CLIENT_ID, PLAID_SECRET] },
  async (request) => {
    if (!request.auth?.uid) {
      throw new HttpsError("unauthenticated", "Necesitas estar logueado.");
    }

    const accessToken = request.data?.accessToken;
    if (!accessToken || typeof accessToken !== "string") {
      throw new HttpsError("invalid-argument", "Falta accessToken.");
    }

    const clientId = PLAID_CLIENT_ID.value();
    const secret = PLAID_SECRET.value();
    const env = PLAID_ENV.value();
    const host = plaidHost(env);

    try {
      const resp = await postJson(host, "/accounts/balance/get", {
        client_id: clientId,
        secret,
        access_token: accessToken,
      });

      return {
        accounts: resp.accounts || [],
        item: resp.item || null,
        request_id: resp.request_id || null,
      };
    } catch (e) {
      console.error("getAccountBalancesV2 error:", e?.raw || e);
      throw new HttpsError(
        "internal",
        `Plaid error: ${e?.message || "No se pudieron obtener balances."}`,
      );
    }
  },
);
