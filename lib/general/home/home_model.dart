import '/acciones/ajustes/ajustes_widget.dart';
import '/acciones/conectarcuentas/conectarcuentas_widget.dart';
import '/acciones/reconectarcuentas/reconectarcuentas_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/backend/schema/structs/index.dart';
import '/calendario/calendar_comp/calendar_comp_widget.dart';
import '/components/bokimg_widget.dart';
import '/components/news_views_widget.dart';
import '/components/tarjetade_adds_widget.dart';
import '/components/tarjetadenoticias_widget.dart';
import '/eventos/accion_crear/accion_crear_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/informacion/info_efectivorestante/info_efectivorestante_widget.dart';
import '/informacion/info_flujodeefectivo/info_flujodeefectivo_widget.dart';
import '/metas/goald_creating/goald_creating_widget.dart';
import '/metas/goald_info/goald_info_widget.dart';
import '/tarjetas/bank_acount/bank_acount_widget.dart';
import '/tarjetas/card_bill/card_bill_widget.dart';
import '/tarjetas/card_bill_copy/card_bill_copy_widget.dart';
import '/tarjetas/card_billvencido/card_billvencido_widget.dart';
import '/tarjetas/metascard/metascard_widget.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  Local state fields for this page.

  String? selectedDate;

  String? codigo;

  DocumentReference? userViewedRef;

  String? url;

  int? selectedTab = 0;

  double? valance;

  double? proyectado;

  double? disponible;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - listenPlaidDeepLink] action in Home widget.
  String? itemId;
  bool biometricResult = false;
  // Stores action output result for [Custom Action - getDeviceTimeZone] action in Home widget.
  String? timeZone1;
  // Stores action output result for [Backend Call - API (GetUserLocationByIP)] action in Home widget.
  ApiCallResponse? apiResultthj;
  // Stores action output result for [Firestore Query - Query a collection] action in Home widget.
  List<PlaidItemsRecord>? itemsNeedingRefresh;
  // Stores action output result for [Cloud Function - getAccountBalancesV2] action in Home widget.
  GetAccountBalancesV2CloudFunctionCallResponse? cloudFunction6tx;
  // Stores action output result for [Firestore Query - Query a collection] action in Home widget.
  List<PlaidItemsRecord>? itemsNeedingSync;
  // Stores action output result for [Cloud Function - syncTransactionsV2] action in Home widget.
  SyncTransactionsV2CloudFunctionCallResponse? cloudFunction4x1;
  // Stores action output result for [Cloud Function - goldAdvisorDailyBriefV2] action in Home widget.
  GoldAdvisorDailyBriefV2CloudFunctionCallResponse? welcom;
  // Stores action output result for [Firestore Query - Query a collection] action in Home widget.
  List<DocumentsRecord>? incomes;
  // Stores action output result for [Firestore Query - Query a collection] action in Home widget.
  List<DocumentsRecord>? expense;
  // Stores action output result for [Firestore Query - Query a collection] action in Home widget.
  List<DocumentsRecord>? saves;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Stores action output result for [Cloud Function - goldAdvisorDailyBriefV2] action in Tab widget.
  GoldAdvisorDailyBriefV2CloudFunctionCallResponse? welcome;
  // Stores action output result for [Firestore Query - Query a collection] action in Tab widget.
  List<DocumentsRecord>? incomes1;
  // Stores action output result for [Firestore Query - Query a collection] action in Tab widget.
  List<DocumentsRecord>? expense1;
  // Stores action output result for [Firestore Query - Query a collection] action in Tab widget.
  List<DocumentsRecord>? saves1;
  // Model for cardBill component.
  late CardBillModel cardBillModel1;
  // Models for TarjetadeAdds dynamic component.
  late FlutterFlowDynamicModels<TarjetadeAddsModel> tarjetadeAddsModels;
  // Models for Tarjetadenoticias dynamic component.
  late FlutterFlowDynamicModels<TarjetadenoticiasModel> tarjetadenoticiasModels;
  // Model for CalendarComp component.
  late CalendarCompModel calendarCompModel;
  // Models for cardBillCopy dynamic component.
  late FlutterFlowDynamicModels<CardBillCopyModel> cardBillCopyModels;
  // Models for cardBill dynamic component.
  late FlutterFlowDynamicModels<CardBillModel> cardBillModels2;
  // Models for cardBill dynamic component.
  late FlutterFlowDynamicModels<CardBillModel> cardBillModels3;
  // Models for cardBillvencido dynamic component.
  late FlutterFlowDynamicModels<CardBillvencidoModel> cardBillvencidoModels;
  // Stores action output result for [Cloud Function - goldAdvisorDailyBriefV2] action in Tab widget.
  GoldAdvisorDailyBriefV2CloudFunctionCallResponse? welcomi;
  // Stores action output result for [Firestore Query - Query a collection] action in Tab widget.
  List<DocumentsRecord>? incomes2;
  // Stores action output result for [Firestore Query - Query a collection] action in Tab widget.
  List<DocumentsRecord>? expense2;
  // Stores action output result for [Firestore Query - Query a collection] action in Tab widget.
  List<DocumentsRecord>? saves2;
  // Models for BankAcount dynamic component.
  late FlutterFlowDynamicModels<BankAcountModel> bankAcountModels1;
  // Models for BankAcount dynamic component.
  late FlutterFlowDynamicModels<BankAcountModel> bankAcountModels2;
  // Models for BankAcount dynamic component.
  late FlutterFlowDynamicModels<BankAcountModel> bankAcountModels3;
  // Stores action output result for [Cloud Function - startPlaidLinkWebV2] action in Button widget.
  StartPlaidLinkWebV2CloudFunctionCallResponse? plaidStartResult;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  PlaidLinkSessionsRecord? weburl;
  // Stores action output result for [Cloud Function - startPlaidLinkWebV2] action in Button widget.
  StartPlaidLinkWebV2CloudFunctionCallResponse? plaidStartResult1;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  PlaidLinkSessionsRecord? weburl1;
  // Stores action output result for [Firestore Query - Query a collection] action in Tab widget.
  List<BankAccountsRecord>? accounts;
  // Models for metascard dynamic component.
  late FlutterFlowDynamicModels<MetascardModel> metascardModels;

  @override
  void initState(BuildContext context) {
    cardBillModel1 = createModel(context, () => CardBillModel());
    tarjetadeAddsModels = FlutterFlowDynamicModels(() => TarjetadeAddsModel());
    tarjetadenoticiasModels =
        FlutterFlowDynamicModels(() => TarjetadenoticiasModel());
    calendarCompModel = createModel(context, () => CalendarCompModel());
    cardBillCopyModels = FlutterFlowDynamicModels(() => CardBillCopyModel());
    cardBillModels2 = FlutterFlowDynamicModels(() => CardBillModel());
    cardBillModels3 = FlutterFlowDynamicModels(() => CardBillModel());
    cardBillvencidoModels =
        FlutterFlowDynamicModels(() => CardBillvencidoModel());
    bankAcountModels1 = FlutterFlowDynamicModels(() => BankAcountModel());
    bankAcountModels2 = FlutterFlowDynamicModels(() => BankAcountModel());
    bankAcountModels3 = FlutterFlowDynamicModels(() => BankAcountModel());
    metascardModels = FlutterFlowDynamicModels(() => MetascardModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    cardBillModel1.dispose();
    tarjetadeAddsModels.dispose();
    tarjetadenoticiasModels.dispose();
    calendarCompModel.dispose();
    cardBillCopyModels.dispose();
    cardBillModels2.dispose();
    cardBillModels3.dispose();
    cardBillvencidoModels.dispose();
    bankAcountModels1.dispose();
    bankAcountModels2.dispose();
    bankAcountModels3.dispose();
    metascardModels.dispose();
  }
}
