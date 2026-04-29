"use strict";

const admin = require("firebase-admin");
const https = require("https");
const { URL } = require("url");

const { setGlobalOptions } = require("firebase-functions/v2");
const { onCall, HttpsError } = require("firebase-functions/v2/https");
const { defineSecret, defineString } = require("firebase-functions/params");

if (!admin.apps.length) {
  admin.initializeApp();
}

setGlobalOptions({
  region: "us-central1",
  maxInstances: 10,
});

// ✅ Secrets/Params (NO process.env)
const PLAID_CLIENT_ID = defineSecret("PLAID_CLIENT_ID");
const PLAID_SECRET = defineSecret("PLAID_SECRET");
const PLAID_ENV = defineString("PLAID_ENV", { default: "sandbox" });

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

// ✅ Gen2 + secrets + nombre V2
exports.getAccountBalancesV2 = onCall(
  { secrets: [PLAID_CLIENT_ID, PLAID_SECRET] },
  async (request) => {
    if (!request.auth?.uid) {
      throw new HttpsError("unauthenticated", "Debes estar logueado.");
    }

    const accessToken = request.data?.accessToken;
    if (!accessToken || typeof accessToken !== "string") {
      throw new HttpsError("invalid-argument", "Falta accessToken.");
    }

    const host = plaidHost(PLAID_ENV.value());

    try {
      const resp = await postJson(host, "/accounts/balance/get", {
        client_id: PLAID_CLIENT_ID.value(),
        secret: PLAID_SECRET.value(),
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
        `Error balances: ${e?.message || "Fallo"}`,
      );
    }
  },
);
