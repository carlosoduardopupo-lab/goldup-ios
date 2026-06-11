const admin = require("firebase-admin/app");
admin.initializeApp();

const scheduleCalendarNotifications = require("./schedule_calendar_notifications.js");
exports.scheduleCalendarNotifications =
  scheduleCalendarNotifications.scheduleCalendarNotifications;
const notifyTodayEvents = require("./notify_today_events.js");
exports.notifyTodayEvents = notifyTodayEvents.notifyTodayEvents;
const rolloverYearDocuments = require("./rollover_year_documents.js");
exports.rolloverYearDocuments = rolloverYearDocuments.rolloverYearDocuments;
const createPlaidLinkTokenV2 = require("./create_plaid_link_token_v2.js");
exports.createPlaidLinkTokenV2 = createPlaidLinkTokenV2.createPlaidLinkTokenV2;
const getAccountBalancesV2 = require("./get_account_balances_v2.js");
exports.getAccountBalancesV2 = getAccountBalancesV2.getAccountBalancesV2;
const exchangePublicTokenV2 = require("./exchange_public_token_v2.js");
exports.exchangePublicTokenV2 = exchangePublicTokenV2.exchangePublicTokenV2;
const startPlaidLinkWebV2 = require("./start_plaid_link_web_v2.js");
exports.startPlaidLinkWebV2 = startPlaidLinkWebV2.startPlaidLinkWebV2;
const startPlaidUpdateModeV2 = require("./start_plaid_update_mode_v2.js");
exports.startPlaidUpdateModeV2 = startPlaidUpdateModeV2.startPlaidUpdateModeV2;
