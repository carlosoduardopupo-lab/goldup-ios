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
import 'home_model.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  static String routeName = 'Home';
  static String routePath = '/home';

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await authManager.refreshUser();
      if (currentUserEmailVerified == true) {
        if (valueOrDefault<bool>(currentUserDocument?.isPlanSelected, false) ==
            true) {
          _model.itemId = await actions.listenPlaidDeepLink();
          if (_model.itemId != '') {
            safeSetState(() {
              _model.tabBarController!.animateTo(
                3,
                duration: Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            });
          }
          if (FFAppState().isBiometricEnabled == true) {
            FFAppState().isBlokedHome = true;
            safeSetState(() {});
            final _localAuth = LocalAuthentication();
            bool _isBiometricSupported = await _localAuth.isDeviceSupported();

            if (_isBiometricSupported) {
              try {
                _model.biometricResult = await _localAuth.authenticate(
                    localizedReason: FFLocalizations.of(context).getText(
                  '87jgyqnv' /* Por tu seguridad, verifica tu ... */,
                ));
              } on PlatformException {
                _model.biometricResult = false;
              }
              safeSetState(() {});
            }

            if (_model.biometricResult == true) {
              FFAppState().isBlokedHome = false;
              safeSetState(() {});
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Error de autenticación.',
                    style: GoogleFonts.roboto(
                      color: Color(0xFFECF3F9),
                    ),
                  ),
                  duration: Duration(milliseconds: 4000),
                  backgroundColor: FlutterFlowTheme.of(context).secondary,
                ),
              );
            }
          }
          await Future.wait([
            Future(() async {
              _model.selectedDate = functions
                  .normalizeToCalendarDatedateTime(getCurrentTimestamp);
              safeSetState(() {});
              FFAppState().selectedDate = getCurrentTimestamp;
              safeSetState(() {});
              setDarkModeSetting(context, ThemeMode.light);
            }),
            Future(() async {
              _model.timeZone1 = await actions.getDeviceTimeZone();

              await currentUserReference!.update(createUserRecordData(
                timeZone: _model.timeZone1,
              ));
              _model.apiResultthj = await GetUserLocationByIPCall.call();

              if ((_model.apiResultthj?.succeeded ?? true)) {
                await currentUserReference!.update({
                  ...createUserRecordData(
                    country: getJsonField(
                      (_model.apiResultthj?.jsonBody ?? ''),
                      r'''$.country_code2''',
                    ).toString(),
                    state: getJsonField(
                      (_model.apiResultthj?.jsonBody ?? ''),
                      r'''$.state_prov''',
                    ).toString(),
                    city: getJsonField(
                      (_model.apiResultthj?.jsonBody ?? ''),
                      r'''$.city''',
                    ).toString(),
                    zipCode: getJsonField(
                      (_model.apiResultthj?.jsonBody ?? ''),
                      r'''$.zipcode''',
                    ).toString(),
                  ),
                  ...mapToFirestore(
                    {
                      'locationUpdatedAt': FieldValue.serverTimestamp(),
                    },
                  ),
                });
              }
              await actions.saveFcmTokenToFirestore();
            }),
          ]);
          if (valueOrDefault<bool>(currentUserDocument?.isPremium, false) ==
              true) {
            if (valueOrDefault<bool>(
                    currentUserDocument?.isAccountsVinculated, false) ==
                true) {
              if (valueOrDefault<bool>(
                      currentUserDocument?.isTransactionsVerificated, false) ==
                  true) {
                await Future.wait([
                  Future(() async {
                    _model.itemsNeedingRefresh =
                        await queryPlaidItemsRecordOnce(
                      queryBuilder: (plaidItemsRecord) => plaidItemsRecord
                          .where(
                            'userRef',
                            isEqualTo: currentUserReference,
                          )
                          .where(
                            'needsBalanceRefresh',
                            isEqualTo: true,
                          ),
                    );
                    for (int loop1Index = 0;
                        loop1Index < _model.itemsNeedingRefresh!.length;
                        loop1Index++) {
                      final currentLoop1Item =
                          _model.itemsNeedingRefresh![loop1Index];
                      try {
                        final result = await FirebaseFunctions.instance
                            .httpsCallable('getAccountBalancesV2')
                            .call({
                          "itemId": currentLoop1Item.itemId,
                        });
                        _model.cloudFunction6tx =
                            GetAccountBalancesV2CloudFunctionCallResponse(
                          succeeded: true,
                        );
                      } on FirebaseFunctionsException catch (error) {
                        _model.cloudFunction6tx =
                            GetAccountBalancesV2CloudFunctionCallResponse(
                          errorCode: error.code,
                          succeeded: false,
                        );
                      }
                    }
                  }),
                  Future(() async {
                    _model.itemsNeedingSync = await queryPlaidItemsRecordOnce(
                      queryBuilder: (plaidItemsRecord) => plaidItemsRecord
                          .where(
                            'userRef',
                            isEqualTo: currentUserReference,
                          )
                          .where(
                            'needsBalanceRefresh',
                            isEqualTo: true,
                          ),
                    );
                    for (int loop2Index = 0;
                        loop2Index < _model.itemsNeedingSync!.length;
                        loop2Index++) {
                      final currentLoop2Item =
                          _model.itemsNeedingSync![loop2Index];
                      try {
                        final result = await FirebaseFunctions.instance
                            .httpsCallable('syncTransactionsV2')
                            .call({
                          "itemId": currentLoop2Item.itemId,
                        });
                        _model.cloudFunction4x1 =
                            SyncTransactionsV2CloudFunctionCallResponse(
                          succeeded: true,
                        );
                      } on FirebaseFunctionsException catch (error) {
                        _model.cloudFunction4x1 =
                            SyncTransactionsV2CloudFunctionCallResponse(
                          errorCode: error.code,
                          succeeded: false,
                        );
                      }
                    }
                  }),
                ]);
                try {
                  final result =
                      await FirebaseFunctions.instanceFor(region: 'us-central1')
                          .httpsCallable('goldAdvisorDailyBriefV2')
                          .call({
                    "forceRefresh": false,
                  });
                  _model.welcom =
                      GoldAdvisorDailyBriefV2CloudFunctionCallResponse(
                    succeeded: true,
                  );
                } on FirebaseFunctionsException catch (error) {
                  _model.welcom =
                      GoldAdvisorDailyBriefV2CloudFunctionCallResponse(
                    errorCode: error.code,
                    succeeded: false,
                  );
                }
              } else {
                context.pushNamed(RecurrentesWidget.routeName);
              }
            }
          } else {
            await Future.wait([
              Future(() async {
                _model.incomes = await queryDocumentsRecordOnce(
                  queryBuilder: (documentsRecord) => documentsRecord
                      .where(
                        'userRef',
                        isEqualTo: currentUserReference,
                      )
                      .where(
                        'isIncome',
                        isEqualTo: true,
                      )
                      .where(
                        'occurrenceKey',
                        isGreaterThanOrEqualTo: functions
                            .monthBoundaries(getCurrentTimestamp)
                            .firstOrNull,
                      )
                      .where(
                        'occurrenceKey',
                        isLessThanOrEqualTo: functions
                            .monthBoundaries(getCurrentTimestamp)
                            .lastOrNull,
                      ),
                );
              }),
              Future(() async {
                _model.expense = await queryDocumentsRecordOnce(
                  queryBuilder: (documentsRecord) => documentsRecord
                      .where(
                        'userRef',
                        isEqualTo: currentUserReference,
                      )
                      .where(
                        'isExpenses',
                        isEqualTo: true,
                      )
                      .where(
                        'occurrenceKey',
                        isGreaterThanOrEqualTo: functions
                            .monthBoundaries(getCurrentTimestamp)
                            .firstOrNull,
                      )
                      .where(
                        'occurrenceKey',
                        isLessThanOrEqualTo: functions
                            .monthBoundaries(getCurrentTimestamp)
                            .lastOrNull,
                      ),
                );
              }),
              Future(() async {
                _model.saves = await queryDocumentsRecordOnce(
                  queryBuilder: (documentsRecord) => documentsRecord
                      .where(
                        'userRef',
                        isEqualTo: currentUserReference,
                      )
                      .where(
                        'isSave',
                        isEqualTo: true,
                      )
                      .where(
                        'occurrenceKey',
                        isGreaterThanOrEqualTo: functions
                            .monthBoundaries(getCurrentTimestamp)
                            .firstOrNull,
                      )
                      .where(
                        'occurrenceKey',
                        isLessThanOrEqualTo: functions
                            .monthBoundaries(getCurrentTimestamp)
                            .lastOrNull,
                      ),
                );
              }),
            ]);
            FFAppState().sumExpenses = functions
                .sum(_model.expense!.map((e) => e.amount).toList().toList());
            FFAppState().sumIncomes = functions
                .sum(_model.incomes!.map((e) => e.amount).toList().toList());
            FFAppState().sumSave = functions
                .sum(_model.saves!.map((e) => e.amount).toList().toList());
            safeSetState(() {});
          }
        } else {
          context.pushNamed(SuscriptionsWidget.routeName);
        }
      } else {
        context.pushNamed(Auth2Widget.routeName);
      }
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 5,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF073431),
      body: SafeArea(
        top: true,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF11DDD0),
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              alignment: AlignmentDirectional(0.0, 0.0),
              image: Image.asset(
                'assets/images/bnb.png',
              ).image,
            ),
          ),
          child: Stack(
            alignment: AlignmentDirectional(1.0, 0.0),
            children: [
              if (FFAppState().isBlokedHome == false)
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).alternate,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: TabBarView(
                                controller: _model.tabBarController,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0x1F71F9F1),
                                    ),
                                    child: SingleChildScrollView(
                                      primary: false,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          if ((valueOrDefault<bool>(
                                                      currentUserDocument
                                                          ?.isDocumentCreated,
                                                      false) ==
                                                  true) ||
                                              (valueOrDefault<bool>(
                                                      currentUserDocument
                                                          ?.isAccountsVinculated,
                                                      false) ==
                                                  true))
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 1.0, 0.0),
                                              child: AuthUserStreamWidget(
                                                builder: (context) => Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 1.0),
                                                      child: Stack(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 1.0),
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          60.0),
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image: Image
                                                                        .asset(
                                                                      'assets/images/bnb.png',
                                                                    ).image,
                                                                  ),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      blurRadius:
                                                                          4.0,
                                                                      color: Color(
                                                                          0x33000000),
                                                                      offset:
                                                                          Offset(
                                                                        0.0,
                                                                        2.0,
                                                                      ),
                                                                    )
                                                                  ],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            15.0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            15.0),
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20.0,
                                                                          0.0,
                                                                          20.0,
                                                                          0.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              55.0,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Text(
                                                                                      FFLocalizations.of(context).getText(
                                                                                        '54ke7j8j' /* Gold Up  */,
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.roboto(
                                                                                              fontWeight: FontWeight.bold,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                            color: Color(0xFFFBD770),
                                                                                            fontSize: 26.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.bold,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: [
                                                                                    InkWell(
                                                                                      splashColor: Colors.transparent,
                                                                                      focusColor: Colors.transparent,
                                                                                      hoverColor: Colors.transparent,
                                                                                      highlightColor: Colors.transparent,
                                                                                      onTap: () async {
                                                                                        context.pushNamed(SettWidget.routeName);
                                                                                      },
                                                                                      child: Icon(
                                                                                        Icons.menu,
                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        size: 35.0,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            2.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              3.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(0xFF0E9E95),
                                                                            border:
                                                                                Border.all(
                                                                              color: Color(0xFF073431),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            10.0,
                                                                            0.0,
                                                                            10.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children:
                                                                              [
                                                                            if (valueOrDefault<bool>(currentUserDocument?.isPremium, false) ==
                                                                                true)
                                                                              InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  context.pushNamed(ChatIAWidget.routeName);
                                                                                },
                                                                                child: custom_widgets.TypewriterText(
                                                                                  width: double.infinity,
                                                                                  height: 1.0,
                                                                                  text: valueOrDefault<String>(
                                                                                    valueOrDefault(currentUserDocument?.dailyBrief, ''),
                                                                                    'brif',
                                                                                  ),
                                                                                  speed: 15,
                                                                                ),
                                                                              ),
                                                                            Align(
                                                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                                                              child: Container(
                                                                                width: 888.0,
                                                                                decoration: BoxDecoration(),
                                                                                child: Visibility(
                                                                                  visible: valueOrDefault<bool>(currentUserDocument?.isPremium, false) == false,
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'c82j86hl' /* Disponible para gastar: */,
                                                                                          ),
                                                                                          maxLines: 3,
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.roboto(
                                                                                                  fontWeight: FontWeight.normal,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                fontSize: valueOrDefault<bool>(currentUserDocument?.isPremium, false) == true ? 17.0 : 22.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.normal,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          Align(
                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                            child: Text(
                                                                                              valueOrDefault<String>(
                                                                                                functions.calcNetCashflow(FFAppState().sumIncomes, FFAppState().sumExpenses, FFAppState().sumSave)?.toString(),
                                                                                                '0',
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.roboto(
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    color: Color(0xFFFBD770),
                                                                                                    fontSize: valueOrDefault<bool>(currentUserDocument?.isPremium, false) == true ? 25.0 : 35.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      Text(
                                                                                        FFLocalizations.of(context).getText(
                                                                                          'slngdmeg' /* Disponible = Ingresos − (Gasto... */,
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.roboto(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                              fontSize: 12.0,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ].addToEnd(SizedBox(height: 12.0)),
                                                                        ),
                                                                      ),
                                                                    ]
                                                                        .divide(SizedBox(
                                                                            height:
                                                                                0.0))
                                                                        .addToStart(SizedBox(
                                                                            height:
                                                                                0.0))
                                                                        .addToEnd(SizedBox(
                                                                            height:
                                                                                24.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 1.0),
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              height: 85.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10.0),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10.0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10.0),
                                                                ),
                                                              ),
                                                              child: Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        -0.66),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          10.0,
                                                                          0.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            if (valueOrDefault<bool>(currentUserDocument?.isPremium, false) ==
                                                                                true) {
                                                                              safeSetState(() {
                                                                                _model.tabBarController!.animateTo(
                                                                                  3,
                                                                                  duration: Duration(milliseconds: 300),
                                                                                  curve: Curves.ease,
                                                                                );
                                                                              });

                                                                              FFAppState().isSaveSelect = false;
                                                                              FFAppState().isChekSelect = true;
                                                                              FFAppState().isCreditSelect = false;
                                                                              safeSetState(() {});
                                                                            } else {
                                                                              safeSetState(() {
                                                                                _model.tabBarController!.animateTo(
                                                                                  2,
                                                                                  duration: Duration(milliseconds: 300),
                                                                                  curve: Curves.ease,
                                                                                );
                                                                              });
                                                                            }
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xF903F115),
                                                                              borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(10.0),
                                                                                topRight: Radius.circular(10.0),
                                                                                bottomLeft: Radius.circular(10.0),
                                                                                bottomRight: Radius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                              child: Container(
                                                                                width: 105.0,
                                                                                height: 80.0,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                                  boxShadow: [
                                                                                    BoxShadow(
                                                                                      blurRadius: 4.0,
                                                                                      color: Color(0x33000000),
                                                                                      offset: Offset(
                                                                                        0.0,
                                                                                        2.0,
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                  borderRadius: BorderRadius.only(
                                                                                    topLeft: Radius.circular(10.0),
                                                                                    topRight: Radius.circular(10.0),
                                                                                    bottomLeft: Radius.circular(10.0),
                                                                                    bottomRight: Radius.circular(10.0),
                                                                                  ),
                                                                                  shape: BoxShape.rectangle,
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 80.0,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            children: [
                                                                                              if (valueOrDefault<bool>(currentUserDocument?.isPremium, false) == true)
                                                                                                Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'h0g2nfj1' /* Cuentas Corriente */,
                                                                                                  ),
                                                                                                  textAlign: TextAlign.center,
                                                                                                  maxLines: 2,
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.roboto(
                                                                                                          fontWeight: FontWeight.w500,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        color: FlutterFlowTheme.of(context).accent1,
                                                                                                        fontSize: 13.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w500,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              if (valueOrDefault<bool>(currentUserDocument?.isPremium, false) == false)
                                                                                                Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'rf72zmhc' /* Ingresos Totales */,
                                                                                                  ),
                                                                                                  textAlign: TextAlign.center,
                                                                                                  maxLines: 2,
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.roboto(
                                                                                                          fontWeight: FontWeight.w500,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        color: FlutterFlowTheme.of(context).accent1,
                                                                                                        fontSize: 13.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w500,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ].divide(SizedBox(width: 5.0)),
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        if (FFAppState().seeAmounts == true)
                                                                                          StreamBuilder<List<BankAccountsRecord>>(
                                                                                            stream: queryBankAccountsRecord(
                                                                                              queryBuilder: (bankAccountsRecord) => bankAccountsRecord
                                                                                                  .where(
                                                                                                    'userRef',
                                                                                                    isEqualTo: currentUserReference,
                                                                                                  )
                                                                                                  .where(
                                                                                                    'isChequingAccount',
                                                                                                    isEqualTo: true,
                                                                                                  ),
                                                                                            ),
                                                                                            builder: (context, snapshot) {
                                                                                              // Customize what your widget looks like when it's loading.
                                                                                              if (!snapshot.hasData) {
                                                                                                return Center(
                                                                                                  child: SizedBox(
                                                                                                    width: 40.0,
                                                                                                    height: 40.0,
                                                                                                    child: CircularProgressIndicator(
                                                                                                      valueColor: AlwaysStoppedAnimation<Color>(
                                                                                                        FlutterFlowTheme.of(context).primary,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                );
                                                                                              }
                                                                                              List<BankAccountsRecord> textBankAccountsRecordList = snapshot.data!;

                                                                                              return Text(
                                                                                                valueOrDefault<String>(
                                                                                                  valueOrDefault<bool>(currentUserDocument?.isPremium, false) == true
                                                                                                      ? valueOrDefault<String>(
                                                                                                          formatNumber(
                                                                                                            functions.sum(textBankAccountsRecordList.map((e) => e.availableBalance).toList()),
                                                                                                            formatType: FormatType.decimal,
                                                                                                            decimalType: DecimalType.automatic,
                                                                                                            currency: '\$',
                                                                                                          ),
                                                                                                          '0',
                                                                                                        )
                                                                                                      : valueOrDefault<String>(
                                                                                                          formatNumber(
                                                                                                            FFAppState().sumIncomes,
                                                                                                            formatType: FormatType.decimal,
                                                                                                            decimalType: DecimalType.automatic,
                                                                                                            currency: '\$',
                                                                                                          ),
                                                                                                          '0',
                                                                                                        ),
                                                                                                  '0',
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.roboto(
                                                                                                        fontWeight: FontWeight.w500,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                                      fontSize: 18.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.w500,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                              );
                                                                                            },
                                                                                          ),
                                                                                      ].divide(SizedBox(width: 5.0)),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            if (valueOrDefault<bool>(currentUserDocument?.isPremium, false) ==
                                                                                true) {
                                                                              safeSetState(() {
                                                                                _model.tabBarController!.animateTo(
                                                                                  3,
                                                                                  duration: Duration(milliseconds: 300),
                                                                                  curve: Curves.ease,
                                                                                );
                                                                              });

                                                                              FFAppState().isSaveSelect = true;
                                                                              FFAppState().isChekSelect = false;
                                                                              FFAppState().isCreditSelect = false;
                                                                              safeSetState(() {});
                                                                            } else {
                                                                              safeSetState(() {
                                                                                _model.tabBarController!.animateTo(
                                                                                  2,
                                                                                  duration: Duration(milliseconds: 300),
                                                                                  curve: Curves.ease,
                                                                                );
                                                                              });
                                                                            }
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xFFF5EF09),
                                                                              borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(10.0),
                                                                                topRight: Radius.circular(10.0),
                                                                                bottomLeft: Radius.circular(10.0),
                                                                                bottomRight: Radius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                              child: Container(
                                                                                width: 105.0,
                                                                                height: 80.0,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                                  boxShadow: [
                                                                                    BoxShadow(
                                                                                      blurRadius: 4.0,
                                                                                      color: Color(0x33000000),
                                                                                      offset: Offset(
                                                                                        0.0,
                                                                                        2.0,
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                  borderRadius: BorderRadius.only(
                                                                                    topLeft: Radius.circular(10.0),
                                                                                    topRight: Radius.circular(10.0),
                                                                                    bottomLeft: Radius.circular(10.0),
                                                                                    bottomRight: Radius.circular(10.0),
                                                                                  ),
                                                                                  shape: BoxShape.rectangle,
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 80.0,
                                                                                          decoration: BoxDecoration(),
                                                                                          alignment: AlignmentDirectional(0.0, 0.0),
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            children: [
                                                                                              if (valueOrDefault<bool>(currentUserDocument?.isPremium, false) == true)
                                                                                                Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'sbe34dod' /* Cuentas de Ahorro */,
                                                                                                  ),
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.roboto(
                                                                                                          fontWeight: FontWeight.w500,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        color: FlutterFlowTheme.of(context).accent1,
                                                                                                        fontSize: 13.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w500,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              if (valueOrDefault<bool>(currentUserDocument?.isPremium, false) == false)
                                                                                                Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'djw19hzq' /* Ahorros Totales */,
                                                                                                  ),
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.roboto(
                                                                                                          fontWeight: FontWeight.w500,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        color: FlutterFlowTheme.of(context).accent1,
                                                                                                        fontSize: 13.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w500,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ].divide(SizedBox(width: 5.0)),
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        if (FFAppState().seeAmounts == true)
                                                                                          StreamBuilder<List<BankAccountsRecord>>(
                                                                                            stream: queryBankAccountsRecord(
                                                                                              queryBuilder: (bankAccountsRecord) => bankAccountsRecord
                                                                                                  .where(
                                                                                                    'userRef',
                                                                                                    isEqualTo: currentUserReference,
                                                                                                  )
                                                                                                  .where(
                                                                                                    'isSavingAccount',
                                                                                                    isEqualTo: true,
                                                                                                  ),
                                                                                            ),
                                                                                            builder: (context, snapshot) {
                                                                                              // Customize what your widget looks like when it's loading.
                                                                                              if (!snapshot.hasData) {
                                                                                                return Center(
                                                                                                  child: SizedBox(
                                                                                                    width: 40.0,
                                                                                                    height: 40.0,
                                                                                                    child: CircularProgressIndicator(
                                                                                                      valueColor: AlwaysStoppedAnimation<Color>(
                                                                                                        FlutterFlowTheme.of(context).primary,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                );
                                                                                              }
                                                                                              List<BankAccountsRecord> textBankAccountsRecordList = snapshot.data!;

                                                                                              return Text(
                                                                                                valueOrDefault<bool>(currentUserDocument?.isPremium, false) == true
                                                                                                    ? valueOrDefault<String>(
                                                                                                        formatNumber(
                                                                                                          functions.sum(textBankAccountsRecordList.map((e) => e.availableBalance).toList()),
                                                                                                          formatType: FormatType.decimal,
                                                                                                          decimalType: DecimalType.automatic,
                                                                                                          currency: '\$',
                                                                                                        ),
                                                                                                        '0',
                                                                                                      )
                                                                                                    : valueOrDefault<String>(
                                                                                                        formatNumber(
                                                                                                          FFAppState().sumSave,
                                                                                                          formatType: FormatType.decimal,
                                                                                                          decimalType: DecimalType.automatic,
                                                                                                          currency: '\$',
                                                                                                        ),
                                                                                                        '0',
                                                                                                      ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.roboto(
                                                                                                        fontWeight: FontWeight.w500,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                                      fontSize: 18.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.w500,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                              );
                                                                                            },
                                                                                          ),
                                                                                      ].divide(SizedBox(width: 5.0)),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            if (valueOrDefault<bool>(currentUserDocument?.isPremium, false) ==
                                                                                true) {
                                                                              safeSetState(() {
                                                                                _model.tabBarController!.animateTo(
                                                                                  3,
                                                                                  duration: Duration(milliseconds: 300),
                                                                                  curve: Curves.ease,
                                                                                );
                                                                              });

                                                                              FFAppState().isSaveSelect = false;
                                                                              FFAppState().isChekSelect = false;
                                                                              FFAppState().isCreditSelect = true;
                                                                              safeSetState(() {});
                                                                            } else {
                                                                              safeSetState(() {
                                                                                _model.tabBarController!.animateTo(
                                                                                  2,
                                                                                  duration: Duration(milliseconds: 300),
                                                                                  curve: Curves.ease,
                                                                                );
                                                                              });
                                                                            }
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xFFE22E2E),
                                                                              borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(10.0),
                                                                                topRight: Radius.circular(10.0),
                                                                                bottomLeft: Radius.circular(10.0),
                                                                                bottomRight: Radius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                              child: Container(
                                                                                width: 105.0,
                                                                                height: 80.0,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                                  boxShadow: [
                                                                                    BoxShadow(
                                                                                      blurRadius: 4.0,
                                                                                      color: Color(0x33000000),
                                                                                      offset: Offset(
                                                                                        0.0,
                                                                                        2.0,
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                  borderRadius: BorderRadius.only(
                                                                                    topLeft: Radius.circular(10.0),
                                                                                    topRight: Radius.circular(10.0),
                                                                                    bottomLeft: Radius.circular(10.0),
                                                                                    bottomRight: Radius.circular(10.0),
                                                                                  ),
                                                                                  shape: BoxShape.rectangle,
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 80.0,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            children: [
                                                                                              if (valueOrDefault<bool>(currentUserDocument?.isPremium, false) == true)
                                                                                                Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    '5rsb3dyq' /* Tarjetas de Crédito */,
                                                                                                  ),
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.roboto(
                                                                                                          fontWeight: FontWeight.w500,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        color: FlutterFlowTheme.of(context).accent1,
                                                                                                        fontSize: 13.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w500,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              if (valueOrDefault<bool>(currentUserDocument?.isPremium, false) == false)
                                                                                                Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'znwcc57a' /* Gastos Totales */,
                                                                                                  ),
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.roboto(
                                                                                                          fontWeight: FontWeight.w500,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        color: FlutterFlowTheme.of(context).accent1,
                                                                                                        fontSize: 13.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w500,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ].divide(SizedBox(width: 5.0)),
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        if (valueOrDefault<bool>(currentUserDocument?.isPremium, false) == true)
                                                                                          Text(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              '8nct2kf2' /* - */,
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.roboto(
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                                  fontSize: 20.0,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                          ),
                                                                                        if (FFAppState().seeAmounts == true)
                                                                                          StreamBuilder<List<BankAccountsRecord>>(
                                                                                            stream: queryBankAccountsRecord(
                                                                                              queryBuilder: (bankAccountsRecord) => bankAccountsRecord
                                                                                                  .where(
                                                                                                    'userRef',
                                                                                                    isEqualTo: currentUserReference,
                                                                                                  )
                                                                                                  .where(
                                                                                                    'isCreditAccount',
                                                                                                    isEqualTo: true,
                                                                                                  ),
                                                                                            ),
                                                                                            builder: (context, snapshot) {
                                                                                              // Customize what your widget looks like when it's loading.
                                                                                              if (!snapshot.hasData) {
                                                                                                return Center(
                                                                                                  child: SizedBox(
                                                                                                    width: 40.0,
                                                                                                    height: 40.0,
                                                                                                    child: CircularProgressIndicator(
                                                                                                      valueColor: AlwaysStoppedAnimation<Color>(
                                                                                                        FlutterFlowTheme.of(context).primary,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                );
                                                                                              }
                                                                                              List<BankAccountsRecord> textBankAccountsRecordList = snapshot.data!;

                                                                                              return Text(
                                                                                                valueOrDefault<bool>(currentUserDocument?.isPremium, false) == true
                                                                                                    ? valueOrDefault<String>(
                                                                                                        formatNumber(
                                                                                                          functions.sum(textBankAccountsRecordList.map((e) => e.currentBalance).toList()),
                                                                                                          formatType: FormatType.decimal,
                                                                                                          decimalType: DecimalType.automatic,
                                                                                                          currency: '\$',
                                                                                                        ),
                                                                                                        '0',
                                                                                                      )
                                                                                                    : valueOrDefault<String>(
                                                                                                        formatNumber(
                                                                                                          FFAppState().sumExpenses,
                                                                                                          formatType: FormatType.decimal,
                                                                                                          decimalType: DecimalType.automatic,
                                                                                                          currency: '\$',
                                                                                                        ),
                                                                                                        '0',
                                                                                                      ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.roboto(
                                                                                                        fontWeight: FontWeight.w500,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                                      fontSize: 18.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.w500,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                              );
                                                                                            },
                                                                                          ),
                                                                                      ].divide(SizedBox(width: 5.0)),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            10.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    if ((valueOrDefault<bool>(
                                                                currentUserDocument
                                                                    ?.isPremium,
                                                                false) ==
                                                            true) &&
                                                        (valueOrDefault<bool>(
                                                                currentUserDocument
                                                                    ?.isBasic,
                                                                false) ==
                                                            false) &&
                                                        (valueOrDefault<bool>(
                                                                currentUserDocument
                                                                    ?.isBasicWhitAnunces,
                                                                false) ==
                                                            false) &&
                                                        (valueOrDefault<bool>(
                                                                currentUserDocument
                                                                    ?.isGoalCreated,
                                                                false) ==
                                                            true))
                                                      InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          safeSetState(() {
                                                            _model
                                                                .tabBarController!
                                                                .animateTo(
                                                              5,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      300),
                                                              curve:
                                                                  Curves.ease,
                                                            );
                                                          });
                                                        },
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 75.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                blurRadius: 4.0,
                                                                color: Color(
                                                                    0x33000000),
                                                                offset: Offset(
                                                                  0.0,
                                                                  2.0,
                                                                ),
                                                              )
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      10.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      10.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      10.0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        0.0,
                                                                        10.0,
                                                                        0.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          10.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          '069ew9s9' /* Metas Financieras */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.roboto(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              fontSize: 15.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'qqp7ecc2' /* 50% */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.roboto(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            fontSize:
                                                                                16.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(5.0),
                                                                        topRight:
                                                                            Radius.circular(5.0),
                                                                        bottomLeft:
                                                                            Radius.circular(5.0),
                                                                        bottomRight:
                                                                            Radius.circular(5.0),
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          6.0,
                                                                          0.0,
                                                                          7.0,
                                                                          0.0),
                                                                      child:
                                                                          LinearPercentIndicator(
                                                                        percent:
                                                                            0.5,
                                                                        lineHeight:
                                                                            20.0,
                                                                        animation:
                                                                            true,
                                                                        animateFromLastPercent:
                                                                            true,
                                                                        progressColor:
                                                                            Color(0xFF016F17),
                                                                        backgroundColor:
                                                                            FlutterFlowTheme.of(context).secondaryText,
                                                                        padding:
                                                                            EdgeInsets.zero,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]
                                                                  .divide(SizedBox(
                                                                      height:
                                                                          5.0))
                                                                  .addToStart(
                                                                      SizedBox(
                                                                          height:
                                                                              5.0))
                                                                  .addToEnd(SizedBox(
                                                                      height:
                                                                          5.0)),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    if ((valueOrDefault<bool>(
                                                                currentUserDocument
                                                                    ?.isExpensesCreated,
                                                                false) ==
                                                            true) ||
                                                        (valueOrDefault<bool>(
                                                                currentUserDocument
                                                                    ?.isAccountsVinculated,
                                                                false) ==
                                                            true))
                                                      InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          safeSetState(() {
                                                            _model
                                                                .tabBarController!
                                                                .animateTo(
                                                              1,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      300),
                                                              curve:
                                                                  Curves.ease,
                                                            );
                                                          });

                                                          FFAppState()
                                                                  .isCalendarSet =
                                                              true;
                                                          FFAppState()
                                                                  .isBillListSet =
                                                              false;
                                                          safeSetState(() {});
                                                        },
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      10.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      10.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      10.0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    if ((valueOrDefault<bool>(
                                                                currentUserDocument
                                                                    ?.isExpensesCreated,
                                                                false) ==
                                                            true) ||
                                                        (valueOrDefault<bool>(
                                                                currentUserDocument
                                                                    ?.isAccountsVinculated,
                                                                false) ==
                                                            true))
                                                      InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          safeSetState(() {
                                                            _model
                                                                .tabBarController!
                                                                .animateTo(
                                                              1,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      300),
                                                              curve:
                                                                  Curves.ease,
                                                            );
                                                          });

                                                          FFAppState()
                                                                  .isCalendarSet =
                                                              true;
                                                          FFAppState()
                                                                  .isBillListSet =
                                                              false;
                                                          safeSetState(() {});
                                                        },
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      10.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      10.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      10.0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        20.0,
                                                                        0.0,
                                                                        20.0,
                                                                        0.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      '3uavtxm0' /* Próximo Gasto Importante Progr... */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.roboto(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              15.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                StreamBuilder<
                                                                    List<
                                                                        DocumentsRecord>>(
                                                                  stream:
                                                                      queryDocumentsRecord(
                                                                    queryBuilder: (documentsRecord) => documentsRecord
                                                                        .where(
                                                                          'userRef',
                                                                          isEqualTo:
                                                                              currentUserReference,
                                                                        )
                                                                        .where(
                                                                          'isExpenses',
                                                                          isEqualTo:
                                                                              true,
                                                                        )
                                                                        .where(
                                                                          'date',
                                                                          isGreaterThan:
                                                                              getCurrentTimestamp.toString(),
                                                                        )
                                                                        .orderBy('date'),
                                                                    singleRecord:
                                                                        true,
                                                                  ),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    // Customize what your widget looks like when it's loading.
                                                                    if (!snapshot
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              40.0,
                                                                          height:
                                                                              40.0,
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            valueColor:
                                                                                AlwaysStoppedAnimation<Color>(
                                                                              FlutterFlowTheme.of(context).primary,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                    List<DocumentsRecord>
                                                                        listViewDocumentsRecordList =
                                                                        snapshot
                                                                            .data!;
                                                                    // Return an empty Container when the item does not exist.
                                                                    if (snapshot
                                                                        .data!
                                                                        .isEmpty) {
                                                                      return Container();
                                                                    }
                                                                    final listViewDocumentsRecord = listViewDocumentsRecordList
                                                                            .isNotEmpty
                                                                        ? listViewDocumentsRecordList
                                                                            .first
                                                                        : null;

                                                                    return ListView(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      primary:
                                                                          false,
                                                                      shrinkWrap:
                                                                          true,
                                                                      scrollDirection:
                                                                          Axis.vertical,
                                                                      children:
                                                                          [
                                                                        wrapWithModel(
                                                                          model:
                                                                              _model.cardBillModel1,
                                                                          updateCallback: () =>
                                                                              safeSetState(() {}),
                                                                          child:
                                                                              CardBillWidget(
                                                                            docDocument:
                                                                                listViewDocumentsRecord!,
                                                                          ),
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              height: 10.0)),
                                                                    );
                                                                  },
                                                                ),
                                                              ]
                                                                  .divide(SizedBox(
                                                                      height:
                                                                          5.0))
                                                                  .addToStart(
                                                                      SizedBox(
                                                                          height:
                                                                              5.0))
                                                                  .addToEnd(SizedBox(
                                                                      height:
                                                                          5.0)),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    if ((valueOrDefault<bool>(
                                                                currentUserDocument
                                                                    ?.isExpensesCreated,
                                                                false) ==
                                                            true) ||
                                                        (valueOrDefault<bool>(
                                                                currentUserDocument
                                                                    ?.isAccountsVinculated,
                                                                false) ==
                                                            true))
                                                      InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          safeSetState(() {
                                                            _model
                                                                .tabBarController!
                                                                .animateTo(
                                                              1,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      300),
                                                              curve:
                                                                  Curves.ease,
                                                            );
                                                          });

                                                          FFAppState()
                                                                  .isCalendarSet =
                                                              false;
                                                          FFAppState()
                                                                  .isBillListSet =
                                                              true;
                                                          safeSetState(() {});
                                                        },
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      10.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      10.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      10.0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        20.0,
                                                                        0.0,
                                                                        20.0,
                                                                        0.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          10.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          '122mqjz8' /* Facturas y Gastos del Mes  */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.roboto(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              fontSize: 15.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '${dateTimeFormat(
                                                                        "MMMM",
                                                                        dateTimeFromSecondsSinceEpoch(
                                                                            valueOrDefault<int>(
                                                                          getCurrentTimestamp
                                                                              .secondsSinceEpoch,
                                                                          0,
                                                                        )),
                                                                        locale:
                                                                            FFLocalizations.of(context).languageCode,
                                                                      )} ${dateTimeFormat(
                                                                        "y",
                                                                        getCurrentTimestamp,
                                                                        locale:
                                                                            FFLocalizations.of(context).languageCode,
                                                                      )}',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.roboto(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            decoration:
                                                                                TextDecoration.underline,
                                                                          ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              10.0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              10.0),
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              10.0),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              10.0),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            5.0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                155.0,
                                                                            height:
                                                                                80.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xFFF3EFD0),
                                                                              boxShadow: [
                                                                                BoxShadow(
                                                                                  blurRadius: 4.0,
                                                                                  color: Color(0x33000000),
                                                                                  offset: Offset(
                                                                                    0.0,
                                                                                    2.0,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                              borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(10.0),
                                                                                topRight: Radius.circular(10.0),
                                                                                bottomLeft: Radius.circular(10.0),
                                                                                bottomRight: Radius.circular(10.0),
                                                                              ),
                                                                              shape: BoxShape.rectangle,
                                                                              border: Border.all(
                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Align(
                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'tekzrh36' /* Pendientes */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.roboto(
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w500,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ].divide(SizedBox(width: 5.0)),
                                                                                  ),
                                                                                ),
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                                      child: Text(
                                                                                        FFLocalizations.of(context).getText(
                                                                                          'en4oos86' /* Total a pagar: */,
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.roboto(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ].divide(SizedBox(width: 5.0)),
                                                                                ),
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    StreamBuilder<List<DocumentsRecord>>(
                                                                                      stream: queryDocumentsRecord(
                                                                                        queryBuilder: (documentsRecord) => documentsRecord
                                                                                            .where(
                                                                                              'userRef',
                                                                                              isEqualTo: currentUserReference,
                                                                                            )
                                                                                            .where(
                                                                                              'isExpenses',
                                                                                              isEqualTo: true,
                                                                                            )
                                                                                            .where(
                                                                                              'isPending',
                                                                                              isEqualTo: true,
                                                                                            )
                                                                                            .where(
                                                                                              'occurrenceKey',
                                                                                              isGreaterThanOrEqualTo: functions.monthBoundaries(getCurrentTimestamp).firstOrNull,
                                                                                            )
                                                                                            .where(
                                                                                              'occurrenceKey',
                                                                                              isLessThanOrEqualTo: functions.monthBoundaries(getCurrentTimestamp).lastOrNull,
                                                                                            )
                                                                                            .orderBy('occurrenceKey'),
                                                                                      ),
                                                                                      builder: (context, snapshot) {
                                                                                        // Customize what your widget looks like when it's loading.
                                                                                        if (!snapshot.hasData) {
                                                                                          return Center(
                                                                                            child: SizedBox(
                                                                                              width: 40.0,
                                                                                              height: 40.0,
                                                                                              child: CircularProgressIndicator(
                                                                                                valueColor: AlwaysStoppedAnimation<Color>(
                                                                                                  FlutterFlowTheme.of(context).primary,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        }
                                                                                        List<DocumentsRecord> textDocumentsRecordList = snapshot.data!;

                                                                                        return Text(
                                                                                          valueOrDefault<String>(
                                                                                            formatNumber(
                                                                                              functions.sumexpenses(textDocumentsRecordList.map((e) => e.amount).toList()),
                                                                                              formatType: FormatType.decimal,
                                                                                              decimalType: DecimalType.automatic,
                                                                                              currency: '\$',
                                                                                            ),
                                                                                            '0',
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.roboto(
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                fontSize: 20.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        );
                                                                                      },
                                                                                    ),
                                                                                  ].divide(SizedBox(width: 5.0)),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                155.0,
                                                                            height:
                                                                                80.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xFFF3EFD0),
                                                                              boxShadow: [
                                                                                BoxShadow(
                                                                                  blurRadius: 4.0,
                                                                                  color: Color(0x33000000),
                                                                                  offset: Offset(
                                                                                    0.0,
                                                                                    2.0,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                              borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(10.0),
                                                                                topRight: Radius.circular(10.0),
                                                                                bottomLeft: Radius.circular(10.0),
                                                                                bottomRight: Radius.circular(10.0),
                                                                              ),
                                                                              border: Border.all(
                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(
                                                                                        FFLocalizations.of(context).getText(
                                                                                          'um1c0wur' /* Vencidas */,
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.roboto(
                                                                                                fontWeight: FontWeight.w500,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ].divide(SizedBox(width: 5.0)),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(
                                                                                        FFLocalizations.of(context).getText(
                                                                                          '01wlanm9' /* Total Saldado: */,
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.roboto(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ].divide(SizedBox(width: 5.0)),
                                                                                  ),
                                                                                ),
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    StreamBuilder<List<DocumentsRecord>>(
                                                                                      stream: queryDocumentsRecord(
                                                                                        queryBuilder: (documentsRecord) => documentsRecord
                                                                                            .where(
                                                                                              'userRef',
                                                                                              isEqualTo: currentUserReference,
                                                                                            )
                                                                                            .where(
                                                                                              'isExpenses',
                                                                                              isEqualTo: true,
                                                                                            )
                                                                                            .where(
                                                                                              'isPending',
                                                                                              isEqualTo: false,
                                                                                            )
                                                                                            .where(
                                                                                              'occurrenceKey',
                                                                                              isGreaterThanOrEqualTo: functions.monthBoundaries(getCurrentTimestamp).firstOrNull,
                                                                                            )
                                                                                            .where(
                                                                                              'occurrenceKey',
                                                                                              isLessThanOrEqualTo: functions.monthBoundaries(getCurrentTimestamp).lastOrNull,
                                                                                            )
                                                                                            .orderBy('occurrenceKey'),
                                                                                      ),
                                                                                      builder: (context, snapshot) {
                                                                                        // Customize what your widget looks like when it's loading.
                                                                                        if (!snapshot.hasData) {
                                                                                          return Center(
                                                                                            child: SizedBox(
                                                                                              width: 40.0,
                                                                                              height: 40.0,
                                                                                              child: CircularProgressIndicator(
                                                                                                valueColor: AlwaysStoppedAnimation<Color>(
                                                                                                  FlutterFlowTheme.of(context).primary,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        }
                                                                                        List<DocumentsRecord> textDocumentsRecordList = snapshot.data!;

                                                                                        return Text(
                                                                                          valueOrDefault<String>(
                                                                                            formatNumber(
                                                                                              functions.sumexpenses(textDocumentsRecordList.map((e) => e.amount).toList()),
                                                                                              formatType: FormatType.decimal,
                                                                                              decimalType: DecimalType.automatic,
                                                                                              currency: '\$',
                                                                                            ),
                                                                                            '0',
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.roboto(
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                fontSize: 20.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        );
                                                                                      },
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]
                                                                  .divide(SizedBox(
                                                                      height:
                                                                          5.0))
                                                                  .addToStart(
                                                                      SizedBox(
                                                                          height:
                                                                              5.0))
                                                                  .addToEnd(SizedBox(
                                                                      height:
                                                                          5.0)),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    if (valueOrDefault<bool>(
                                                            currentUserDocument
                                                                ?.isBasicWhitAnunces,
                                                            false) ==
                                                        true)
                                                      Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    10.0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10.0),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      20.0,
                                                                      0.0,
                                                                      20.0,
                                                                      0.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                child: Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'ytcrcd16' /* Contenido patrocinado */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .roboto(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        fontSize:
                                                                            15.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ]
                                                                .divide(SizedBox(
                                                                    height:
                                                                        10.0))
                                                                .addToStart(
                                                                    SizedBox(
                                                                        height:
                                                                            5.0))
                                                                .addToEnd(
                                                                    SizedBox(
                                                                        height:
                                                                            5.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    if ((valueOrDefault<bool>(
                                                                currentUserDocument
                                                                    ?.isPremium,
                                                                false) ==
                                                            true) &&
                                                        (valueOrDefault<bool>(
                                                                currentUserDocument
                                                                    ?.isBasic,
                                                                false) ==
                                                            false) &&
                                                        (valueOrDefault<bool>(
                                                                currentUserDocument
                                                                    ?.isBasicWhitAnunces,
                                                                false) ==
                                                            false) &&
                                                        (valueOrDefault<bool>(
                                                                currentUserDocument
                                                                    ?.isCreditScoreSet,
                                                                false) ==
                                                            true))
                                                      Container(
                                                        width: double.infinity,
                                                        height: 100.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 4.0,
                                                              color: Color(
                                                                  0x33000000),
                                                              offset: Offset(
                                                                0.0,
                                                                2.0,
                                                              ),
                                                            )
                                                          ],
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    10.0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10.0),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      10.0,
                                                                      0.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'u7njiwu8' /* Credit Score */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.roboto(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            fontSize:
                                                                                15.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Container(
                                                                height: 50.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10.0),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10.0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            10.0),
                                                                  ),
                                                                ),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'ii0m6920' /* 0 */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.roboto(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            fontSize:
                                                                                16.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: <Widget>[].divide(SizedBox(
                                                                          width:
                                                                              5.0)),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ]
                                                                .divide(SizedBox(
                                                                    height:
                                                                        10.0))
                                                                .addToStart(
                                                                    SizedBox(
                                                                        height:
                                                                            5.0))
                                                                .addToEnd(
                                                                    SizedBox(
                                                                        height:
                                                                            5.0)),
                                                          ),
                                                        ),
                                                      ),
                                                  ].divide(
                                                      SizedBox(height: 10.0)),
                                                ),
                                              ),
                                            ),
                                          if (((valueOrDefault<bool>(
                                                          currentUserDocument
                                                              ?.isDocumentCreated,
                                                          false) ==
                                                      true) ||
                                                  (valueOrDefault<bool>(
                                                          currentUserDocument
                                                              ?.isAccountsVinculated,
                                                          false) ==
                                                      true)) &&
                                              ((valueOrDefault(
                                                          currentUserDocument
                                                              ?.country,
                                                          '') ==
                                                      'US') ||
                                                  (valueOrDefault(
                                                          currentUserDocument
                                                              ?.country,
                                                          '') ==
                                                      'MX') ||
                                                  (valueOrDefault(
                                                          currentUserDocument
                                                              ?.country,
                                                          '') ==
                                                      'ES')))
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 0.0, 10.0, 0.0),
                                              child: AuthUserStreamWidget(
                                                builder: (context) => Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  10.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10.0),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    0.0,
                                                                    10.0,
                                                                    0.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      -1.0,
                                                                      0.0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'c0llrypx' /* Novedades */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .roboto(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        fontSize:
                                                                            15.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          5.0,
                                                                          0.0),
                                                              child: StreamBuilder<
                                                                  List<
                                                                      FeedItemsRecord>>(
                                                                stream:
                                                                    queryFeedItemsRecord(
                                                                  queryBuilder: (feedItemsRecord) =>
                                                                      feedItemsRecord
                                                                          .where(
                                                                            'isActive',
                                                                            isEqualTo:
                                                                                true,
                                                                          )
                                                                          .where(
                                                                            'profile',
                                                                            isEqualTo:
                                                                                functions.buildProfileCode(valueOrDefault(currentUserDocument?.country, ''), valueOrDefault(currentUserDocument?.language, '')),
                                                                          )
                                                                          .orderBy(
                                                                              'position'),
                                                                ),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  // Customize what your widget looks like when it's loading.
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            40.0,
                                                                        height:
                                                                            40.0,
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          valueColor:
                                                                              AlwaysStoppedAnimation<Color>(
                                                                            FlutterFlowTheme.of(context).primary,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  List<FeedItemsRecord>
                                                                      rowFeedItemsRecordList =
                                                                      snapshot
                                                                          .data!;

                                                                  return SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: List.generate(
                                                                          rowFeedItemsRecordList
                                                                              .length,
                                                                          (rowIndex) {
                                                                        final rowFeedItemsRecord =
                                                                            rowFeedItemsRecordList[rowIndex];
                                                                        return Builder(
                                                                          builder:
                                                                              (context) {
                                                                            if (rowFeedItemsRecord.adRef !=
                                                                                null) {
                                                                              return wrapWithModel(
                                                                                model: _model.tarjetadeAddsModels.getModel(
                                                                                  rowFeedItemsRecord.adRef!.id,
                                                                                  rowIndex,
                                                                                ),
                                                                                updateCallback: () => safeSetState(() {}),
                                                                                child: TarjetadeAddsWidget(
                                                                                  key: Key(
                                                                                    'Keyiud_${rowFeedItemsRecord.adRef!.id}',
                                                                                  ),
                                                                                  adRef: rowFeedItemsRecord.adRef!,
                                                                                ),
                                                                              );
                                                                            } else {
                                                                              return InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  await showModalBottomSheet(
                                                                                    isScrollControlled: true,
                                                                                    backgroundColor: Colors.transparent,
                                                                                    enableDrag: false,
                                                                                    context: context,
                                                                                    builder: (context) {
                                                                                      return Padding(
                                                                                        padding: MediaQuery.viewInsetsOf(context),
                                                                                        child: NewsViewsWidget(
                                                                                          newRef: rowFeedItemsRecord.newsRef!,
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  ).then((value) => safeSetState(() {}));
                                                                                },
                                                                                child: wrapWithModel(
                                                                                  model: _model.tarjetadenoticiasModels.getModel(
                                                                                    rowFeedItemsRecord.newsRef!.id,
                                                                                    rowIndex,
                                                                                  ),
                                                                                  updateCallback: () => safeSetState(() {}),
                                                                                  child: TarjetadenoticiasWidget(
                                                                                    key: Key(
                                                                                      'Key1zm_${rowFeedItemsRecord.newsRef!.id}',
                                                                                    ),
                                                                                    newsRef: rowFeedItemsRecord.newsRef!,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }
                                                                          },
                                                                        );
                                                                      }).divide(SizedBox(
                                                                          width:
                                                                              5.0)),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ]
                                                              .divide(SizedBox(
                                                                  height: 5.0))
                                                              .addToStart(
                                                                  SizedBox(
                                                                      height:
                                                                          5.0))
                                                              .addToEnd(
                                                                  SizedBox(
                                                                      height:
                                                                          5.0)),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if ((valueOrDefault<bool>(
                                                      currentUserDocument
                                                          ?.isDocumentCreated,
                                                      false) ==
                                                  false) &&
                                              (valueOrDefault<bool>(
                                                      currentUserDocument
                                                          ?.isAccountsVinculated,
                                                      false) ==
                                                  false))
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 20.0, 0.0),
                                              child: AuthUserStreamWidget(
                                                builder: (context) => Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/ChatGPT_Image_22_feb_2026,_12_44_08_a.m..png',
                                                      width: 307.1,
                                                      height: 200.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'fd5mhk1b' /* BIENVENIDO */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .roboto(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            fontSize: 30.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'ka162cxw' /* AÚN NO HAY DATOS QUE MOSTRAR */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .roboto(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'awhath0m' /* Para comenzar... */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .roboto(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16.0,
                                                                  0.0,
                                                                  16.0,
                                                                  0.0),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          FFAppState()
                                                                  .isCalendarSet =
                                                              true;
                                                          FFAppState()
                                                                  .isBillListSet =
                                                              false;
                                                          safeSetState(() {});
                                                          safeSetState(() {
                                                            _model
                                                                .tabBarController!
                                                                .animateTo(
                                                              1,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      300),
                                                              curve:
                                                                  Curves.ease,
                                                            );
                                                          });
                                                        },
                                                        text:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                          'ej7xfkfw' /* Crea un evento en el calendari... */,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          width:
                                                              double.infinity,
                                                          height: 50.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      16.0,
                                                                      0.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color:
                                                              Color(0xFF01654D),
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .roboto(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Colors
                                                                        .white,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                          elevation: 0.0,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ]
                                                      .divide(SizedBox(
                                                          height: 23.0))
                                                      .addToStart(SizedBox(
                                                          height: 20.0))
                                                      .addToEnd(SizedBox(
                                                          height: 20.0)),
                                                ),
                                              ),
                                            ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'nyv2wh1q' /* © 2026 Gold Up Group LLC. 
All... */
                                                ,
                                              ),
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: Color(0xFF076257),
                                                    fontSize: 10.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                        ]
                                            .divide(SizedBox(height: 10.0))
                                            .addToEnd(SizedBox(height: 20.0)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0x1F71F9F1),
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20.0, 0.0, 20.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Text(
                                                    FFAppState().isBillListSet ==
                                                            true
                                                        ? 'Facturas y Gastos'
                                                        : 'Calendario',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .roboto(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 22.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        FFAppState()
                                                                .isCalendarSet =
                                                            true;
                                                        FFAppState()
                                                                .isBillListSet =
                                                            false;
                                                        safeSetState(() {});
                                                      },
                                                      child: Icon(
                                                        Icons.calendar_month,
                                                        color: FFAppState()
                                                                    .isCalendarSet ==
                                                                true
                                                            ? Color(0xFF014836)
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .accent1,
                                                        size: 25.0,
                                                      ),
                                                    ),
                                                    InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        FFAppState()
                                                                .isCalendarSet =
                                                            false;
                                                        FFAppState()
                                                                .isBillListSet =
                                                            true;
                                                        safeSetState(() {});
                                                      },
                                                      child: Icon(
                                                        Icons.list_alt,
                                                        color: FFAppState()
                                                                    .isBillListSet ==
                                                                true
                                                            ? Color(0xFF014836)
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .accent1,
                                                        size: 25.0,
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 15.0)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if ((FFAppState().isCalendarSet ==
                                                  true) &&
                                              (FFAppState().isBillListSet ==
                                                  false))
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        20.0, 0.0, 20.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    StreamBuilder<
                                                        List<DocumentsRecord>>(
                                                      stream:
                                                          queryDocumentsRecord(
                                                        queryBuilder:
                                                            (documentsRecord) =>
                                                                documentsRecord
                                                                    .where(
                                                                      'userRef',
                                                                      isEqualTo:
                                                                          currentUserReference,
                                                                    )
                                                                    .orderBy(
                                                                        'date')
                                                                    .orderBy(
                                                                        'occurrenceKey'),
                                                      ),
                                                      builder:
                                                          (context, snapshot) {
                                                        // Customize what your widget looks like when it's loading.
                                                        if (!snapshot.hasData) {
                                                          return Center(
                                                            child: SizedBox(
                                                              width: 40.0,
                                                              height: 40.0,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                valueColor:
                                                                    AlwaysStoppedAnimation<
                                                                        Color>(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        List<DocumentsRecord>
                                                            calendarCompDocumentsRecordList =
                                                            snapshot.data!;

                                                        return wrapWithModel(
                                                          model: _model
                                                              .calendarCompModel,
                                                          updateCallback: () =>
                                                              safeSetState(
                                                                  () {}),
                                                          child:
                                                              CalendarCompWidget(
                                                            inputDate:
                                                                getCurrentTimestamp,
                                                            initialSelectedDate:
                                                                getCurrentTimestamp,
                                                            documents:
                                                                calendarCompDocumentsRecordList,
                                                            onSelectDateAction:
                                                                (selectedDate) async {
                                                              _model.selectedDate =
                                                                  selectedDate
                                                                      ?.toString();
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  2.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Container(
                                                                    width: 6.0,
                                                                    height: 6.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFFC7D700),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              24.0),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      'ea1vwpg2' /* Ahorros */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.roboto(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    width:
                                                                        2.0)),
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Container(
                                                                    width: 6.0,
                                                                    height: 6.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFF05B01F),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              24.0),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      '8szmn3ym' /* Ingresos */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.roboto(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    width:
                                                                        2.0)),
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Container(
                                                                    width: 6.0,
                                                                    height: 6.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFFF5080D),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              24.0),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      '9b2s27o9' /* Gastos */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.roboto(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    width:
                                                                        2.0)),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 0.0)),
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Container(
                                                                width: 6.0,
                                                                height: 6.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xFF045EBC),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              24.0),
                                                                ),
                                                              ),
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'rjvocdm1' /* Eventos Financieros */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .roboto(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 2.0)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    if (_model.selectedDate !=
                                                            null &&
                                                        _model.selectedDate !=
                                                            '')
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      6.0),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12.0,
                                                                      7.0,
                                                                      12.0,
                                                                      7.0),
                                                          child: Text(
                                                            dateTimeFormat(
                                                              "MMMMEEEEd",
                                                              FFAppState()
                                                                  .selectedDate,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    Container(
                                                      width: 52.0,
                                                      height: 52.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFF01654D),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          await showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            enableDrag: false,
                                                            context: context,
                                                            builder: (context) {
                                                              return Padding(
                                                                padding: MediaQuery
                                                                    .viewInsetsOf(
                                                                        context),
                                                                child:
                                                                    AccionCrearWidget(),
                                                              );
                                                            },
                                                          ).then((value) =>
                                                              safeSetState(
                                                                  () {}));

                                                          await actions
                                                              .saveFcmTokenToFirestore();
                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          size: 39.0,
                                                        ),
                                                      ),
                                                    ),
                                                    StreamBuilder<
                                                        List<DocumentsRecord>>(
                                                      stream:
                                                          queryDocumentsRecord(
                                                        queryBuilder:
                                                            (documentsRecord) =>
                                                                documentsRecord
                                                                    .where(
                                                                      'date',
                                                                      isEqualTo:
                                                                          functions
                                                                              .normalizeToCalendarDatedateTime(FFAppState().selectedDate!),
                                                                    )
                                                                    .where(
                                                                      'userRef',
                                                                      isEqualTo:
                                                                          currentUserReference,
                                                                    )
                                                                    .where(
                                                                      'isInternalTransfer',
                                                                      isEqualTo:
                                                                          false,
                                                                    ),
                                                      ),
                                                      builder:
                                                          (context, snapshot) {
                                                        // Customize what your widget looks like when it's loading.
                                                        if (!snapshot.hasData) {
                                                          return Center(
                                                            child: SizedBox(
                                                              width: 40.0,
                                                              height: 40.0,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                valueColor:
                                                                    AlwaysStoppedAnimation<
                                                                        Color>(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        List<DocumentsRecord>
                                                            columnDocumentsRecordList =
                                                            snapshot.data!;

                                                        return Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: List.generate(
                                                                  columnDocumentsRecordList
                                                                      .length,
                                                                  (columnIndex) {
                                                            final columnDocumentsRecord =
                                                                columnDocumentsRecordList[
                                                                    columnIndex];
                                                            return InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  enableDrag:
                                                                      false,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return Padding(
                                                                      padding: MediaQuery
                                                                          .viewInsetsOf(
                                                                              context),
                                                                      child:
                                                                          AjustesWidget(
                                                                        docDocument:
                                                                            columnDocumentsRecord,
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then((value) =>
                                                                    safeSetState(
                                                                        () {}));
                                                              },
                                                              child:
                                                                  wrapWithModel(
                                                                model: _model
                                                                    .cardBillCopyModels
                                                                    .getModel(
                                                                  columnDocumentsRecord
                                                                      .reference
                                                                      .id,
                                                                  columnIndex,
                                                                ),
                                                                updateCallback: () =>
                                                                    safeSetState(
                                                                        () {}),
                                                                child:
                                                                    CardBillCopyWidget(
                                                                  key: Key(
                                                                    'Keylco_${columnDocumentsRecord.reference.id}',
                                                                  ),
                                                                  docDocument:
                                                                      columnDocumentsRecord,
                                                                ),
                                                              ),
                                                            );
                                                          })
                                                              .divide(SizedBox(
                                                                  height: 10.0))
                                                              .addToEnd(SizedBox(
                                                                  height:
                                                                      20.0)),
                                                        );
                                                      },
                                                    ),
                                                  ]
                                                      .divide(SizedBox(
                                                          height: 10.0))
                                                      .addToEnd(SizedBox(
                                                          height: 20.0)),
                                                ),
                                              ),
                                            ),
                                          if ((FFAppState().isCalendarSet ==
                                                  false) &&
                                              (FFAppState().isBillListSet ==
                                                  true))
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 20.0, 0.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'euaw6srv' /* Pendientes */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .roboto(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      StreamBuilder<
                                                          List<
                                                              DocumentsRecord>>(
                                                        stream:
                                                            queryDocumentsRecord(
                                                          queryBuilder:
                                                              (documentsRecord) =>
                                                                  documentsRecord
                                                                      .where(
                                                                        'userRef',
                                                                        isEqualTo:
                                                                            currentUserReference,
                                                                      )
                                                                      .where(
                                                                        'isExpenses',
                                                                        isEqualTo:
                                                                            true,
                                                                      )
                                                                      .where(
                                                                        'isPending',
                                                                        isEqualTo:
                                                                            true,
                                                                      )
                                                                      .where(
                                                                        'occurrenceKey',
                                                                        isGreaterThanOrEqualTo: functions
                                                                            .monthBoundaries(getCurrentTimestamp)
                                                                            .firstOrNull,
                                                                      )
                                                                      .where(
                                                                        'occurrenceKey',
                                                                        isLessThanOrEqualTo: functions
                                                                            .monthBoundaries(getCurrentTimestamp)
                                                                            .lastOrNull,
                                                                      )
                                                                      .where(
                                                                        'isRealTransaction',
                                                                        isEqualTo:
                                                                            false,
                                                                      )
                                                                      .orderBy(
                                                                          'occurrenceKey'),
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 40.0,
                                                                height: 40.0,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  valueColor:
                                                                      AlwaysStoppedAnimation<
                                                                          Color>(
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<DocumentsRecord>
                                                              textDocumentsRecordList =
                                                              snapshot.data!;

                                                          return Text(
                                                            valueOrDefault<
                                                                String>(
                                                              formatNumber(
                                                                functions.sumexpenses(
                                                                    textDocumentsRecordList
                                                                        .map((e) =>
                                                                            e.amount)
                                                                        .toList()),
                                                                formatType:
                                                                    FormatType
                                                                        .decimal,
                                                                decimalType:
                                                                    DecimalType
                                                                        .automatic,
                                                                currency: '\$',
                                                              ),
                                                              '0',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      22.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          );
                                                        },
                                                      ),
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'h60n2v3o' /* a pagar  */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 4.0)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 15.0),
                                                    child: StreamBuilder<
                                                        List<DocumentsRecord>>(
                                                      stream:
                                                          queryDocumentsRecord(
                                                        queryBuilder:
                                                            (documentsRecord) =>
                                                                documentsRecord
                                                                    .where(
                                                                      'userRef',
                                                                      isEqualTo:
                                                                          currentUserReference,
                                                                    )
                                                                    .where(
                                                                      'isExpenses',
                                                                      isEqualTo:
                                                                          true,
                                                                    )
                                                                    .where(
                                                                      'isPending',
                                                                      isEqualTo:
                                                                          true,
                                                                    )
                                                                    .where(
                                                                      'occurrenceKey',
                                                                      isGreaterThanOrEqualTo: functions
                                                                          .monthBoundaries(
                                                                              getCurrentTimestamp)
                                                                          .firstOrNull,
                                                                    )
                                                                    .where(
                                                                      'occurrenceKey',
                                                                      isLessThanOrEqualTo: functions
                                                                          .monthBoundaries(
                                                                              getCurrentTimestamp)
                                                                          .lastOrNull,
                                                                    )
                                                                    .where(
                                                                      'isRealTransaction',
                                                                      isEqualTo:
                                                                          false,
                                                                    )
                                                                    .orderBy(
                                                                        'occurrenceKey'),
                                                      ),
                                                      builder:
                                                          (context, snapshot) {
                                                        // Customize what your widget looks like when it's loading.
                                                        if (!snapshot.hasData) {
                                                          return Center(
                                                            child: SizedBox(
                                                              width: 40.0,
                                                              height: 40.0,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                valueColor:
                                                                    AlwaysStoppedAnimation<
                                                                        Color>(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        List<DocumentsRecord>
                                                            columnDocumentsRecordList =
                                                            snapshot.data!;

                                                        return Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: List.generate(
                                                              columnDocumentsRecordList
                                                                  .length,
                                                              (columnIndex) {
                                                            final columnDocumentsRecord =
                                                                columnDocumentsRecordList[
                                                                    columnIndex];
                                                            return InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  enableDrag:
                                                                      false,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return Padding(
                                                                      padding: MediaQuery
                                                                          .viewInsetsOf(
                                                                              context),
                                                                      child:
                                                                          AjustesWidget(
                                                                        docDocument:
                                                                            columnDocumentsRecord,
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then((value) =>
                                                                    safeSetState(
                                                                        () {}));
                                                              },
                                                              child:
                                                                  wrapWithModel(
                                                                model: _model
                                                                    .cardBillModels2
                                                                    .getModel(
                                                                  columnDocumentsRecord
                                                                      .reference
                                                                      .id,
                                                                  columnIndex,
                                                                ),
                                                                updateCallback: () =>
                                                                    safeSetState(
                                                                        () {}),
                                                                child:
                                                                    CardBillWidget(
                                                                  key: Key(
                                                                    'Key2zj_${columnDocumentsRecord.reference.id}',
                                                                  ),
                                                                  docDocument:
                                                                      columnDocumentsRecord,
                                                                ),
                                                              ),
                                                            );
                                                          }).divide(SizedBox(
                                                              height: 10.0)),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'uohywtg2' /* Inicializadas */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .roboto(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      StreamBuilder<
                                                          List<
                                                              DocumentsRecord>>(
                                                        stream:
                                                            queryDocumentsRecord(
                                                          queryBuilder:
                                                              (documentsRecord) =>
                                                                  documentsRecord
                                                                      .where(
                                                                        'userRef',
                                                                        isEqualTo:
                                                                            currentUserReference,
                                                                      )
                                                                      .where(
                                                                        'isExpenses',
                                                                        isEqualTo:
                                                                            true,
                                                                      )
                                                                      .where(
                                                                        'isPending',
                                                                        isEqualTo:
                                                                            true,
                                                                      )
                                                                      .where(
                                                                        'occurrenceKey',
                                                                        isGreaterThanOrEqualTo: functions
                                                                            .monthBoundaries(getCurrentTimestamp)
                                                                            .firstOrNull,
                                                                      )
                                                                      .where(
                                                                        'occurrenceKey',
                                                                        isLessThanOrEqualTo: functions
                                                                            .monthBoundaries(getCurrentTimestamp)
                                                                            .lastOrNull,
                                                                      )
                                                                      .where(
                                                                        'isRealTransaction',
                                                                        isEqualTo:
                                                                            true,
                                                                      )
                                                                      .orderBy(
                                                                          'occurrenceKey'),
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 40.0,
                                                                height: 40.0,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  valueColor:
                                                                      AlwaysStoppedAnimation<
                                                                          Color>(
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<DocumentsRecord>
                                                              textDocumentsRecordList =
                                                              snapshot.data!;

                                                          return Text(
                                                            valueOrDefault<
                                                                String>(
                                                              formatNumber(
                                                                functions.sumexpenses(
                                                                    textDocumentsRecordList
                                                                        .map((e) =>
                                                                            e.amount)
                                                                        .toList()),
                                                                formatType:
                                                                    FormatType
                                                                        .decimal,
                                                                decimalType:
                                                                    DecimalType
                                                                        .automatic,
                                                                currency: '\$',
                                                              ),
                                                              '0',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      22.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          );
                                                        },
                                                      ),
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'njfnwiyl' /* procesando  */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 4.0)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 15.0),
                                                    child: StreamBuilder<
                                                        List<DocumentsRecord>>(
                                                      stream:
                                                          queryDocumentsRecord(
                                                        queryBuilder:
                                                            (documentsRecord) =>
                                                                documentsRecord
                                                                    .where(
                                                                      'userRef',
                                                                      isEqualTo:
                                                                          currentUserReference,
                                                                    )
                                                                    .where(
                                                                      'isExpenses',
                                                                      isEqualTo:
                                                                          true,
                                                                    )
                                                                    .where(
                                                                      'isPending',
                                                                      isEqualTo:
                                                                          true,
                                                                    )
                                                                    .where(
                                                                      'occurrenceKey',
                                                                      isGreaterThanOrEqualTo: functions
                                                                          .monthBoundaries(
                                                                              getCurrentTimestamp)
                                                                          .firstOrNull,
                                                                    )
                                                                    .where(
                                                                      'occurrenceKey',
                                                                      isLessThanOrEqualTo: functions
                                                                          .monthBoundaries(
                                                                              getCurrentTimestamp)
                                                                          .lastOrNull,
                                                                    )
                                                                    .where(
                                                                      'isRealTransaction',
                                                                      isEqualTo:
                                                                          true,
                                                                    )
                                                                    .orderBy(
                                                                        'occurrenceKey'),
                                                      ),
                                                      builder:
                                                          (context, snapshot) {
                                                        // Customize what your widget looks like when it's loading.
                                                        if (!snapshot.hasData) {
                                                          return Center(
                                                            child: SizedBox(
                                                              width: 40.0,
                                                              height: 40.0,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                valueColor:
                                                                    AlwaysStoppedAnimation<
                                                                        Color>(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        List<DocumentsRecord>
                                                            columnDocumentsRecordList =
                                                            snapshot.data!;

                                                        return Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: List.generate(
                                                              columnDocumentsRecordList
                                                                  .length,
                                                              (columnIndex) {
                                                            final columnDocumentsRecord =
                                                                columnDocumentsRecordList[
                                                                    columnIndex];
                                                            return InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  enableDrag:
                                                                      false,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return Padding(
                                                                      padding: MediaQuery
                                                                          .viewInsetsOf(
                                                                              context),
                                                                      child:
                                                                          AjustesWidget(
                                                                        docDocument:
                                                                            columnDocumentsRecord,
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then((value) =>
                                                                    safeSetState(
                                                                        () {}));
                                                              },
                                                              child:
                                                                  wrapWithModel(
                                                                model: _model
                                                                    .cardBillModels3
                                                                    .getModel(
                                                                  columnDocumentsRecord
                                                                      .reference
                                                                      .id,
                                                                  columnIndex,
                                                                ),
                                                                updateCallback: () =>
                                                                    safeSetState(
                                                                        () {}),
                                                                child:
                                                                    CardBillWidget(
                                                                  key: Key(
                                                                    'Keyl8t_${columnDocumentsRecord.reference.id}',
                                                                  ),
                                                                  docDocument:
                                                                      columnDocumentsRecord,
                                                                ),
                                                              ),
                                                            );
                                                          }).divide(SizedBox(
                                                              height: 10.0)),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'lyakqr5h' /* Vencidas */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .roboto(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      StreamBuilder<
                                                          List<
                                                              DocumentsRecord>>(
                                                        stream:
                                                            queryDocumentsRecord(
                                                          queryBuilder:
                                                              (documentsRecord) =>
                                                                  documentsRecord
                                                                      .where(
                                                                        'userRef',
                                                                        isEqualTo:
                                                                            currentUserReference,
                                                                      )
                                                                      .where(
                                                                        'isExpenses',
                                                                        isEqualTo:
                                                                            true,
                                                                      )
                                                                      .where(
                                                                        'isPending',
                                                                        isEqualTo:
                                                                            false,
                                                                      )
                                                                      .where(
                                                                        'occurrenceKey',
                                                                        isGreaterThanOrEqualTo: functions
                                                                            .monthBoundaries(getCurrentTimestamp)
                                                                            .firstOrNull,
                                                                      )
                                                                      .where(
                                                                        'occurrenceKey',
                                                                        isLessThanOrEqualTo: functions
                                                                            .monthBoundaries(getCurrentTimestamp)
                                                                            .lastOrNull,
                                                                      )
                                                                      .orderBy(
                                                                          'occurrenceKey'),
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 40.0,
                                                                height: 40.0,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  valueColor:
                                                                      AlwaysStoppedAnimation<
                                                                          Color>(
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<DocumentsRecord>
                                                              textDocumentsRecordList =
                                                              snapshot.data!;

                                                          return Text(
                                                            valueOrDefault<
                                                                String>(
                                                              formatNumber(
                                                                functions.sumexpenses(
                                                                    textDocumentsRecordList
                                                                        .map((e) =>
                                                                            e.amount)
                                                                        .toList()),
                                                                formatType:
                                                                    FormatType
                                                                        .decimal,
                                                                decimalType:
                                                                    DecimalType
                                                                        .automatic,
                                                                currency: '\$',
                                                              ),
                                                              '0',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      22.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          );
                                                        },
                                                      ),
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'n8n8c2g2' /* posteado */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 4.0)),
                                                  ),
                                                  StreamBuilder<
                                                      List<DocumentsRecord>>(
                                                    stream:
                                                        queryDocumentsRecord(
                                                      queryBuilder:
                                                          (documentsRecord) =>
                                                              documentsRecord
                                                                  .where(
                                                                    'userRef',
                                                                    isEqualTo:
                                                                        currentUserReference,
                                                                  )
                                                                  .where(
                                                                    'isExpenses',
                                                                    isEqualTo:
                                                                        true,
                                                                  )
                                                                  .where(
                                                                    'isPending',
                                                                    isEqualTo:
                                                                        false,
                                                                  )
                                                                  .where(
                                                                    'occurrenceKey',
                                                                    isGreaterThanOrEqualTo: functions
                                                                        .monthBoundaries(
                                                                            getCurrentTimestamp)
                                                                        .firstOrNull,
                                                                  )
                                                                  .where(
                                                                    'occurrenceKey',
                                                                    isLessThanOrEqualTo: functions
                                                                        .monthBoundaries(
                                                                            getCurrentTimestamp)
                                                                        .lastOrNull,
                                                                  )
                                                                  .orderBy(
                                                                      'occurrenceKey'),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                          child: SizedBox(
                                                            width: 40.0,
                                                            height: 40.0,
                                                            child:
                                                                CircularProgressIndicator(
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                      Color>(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      List<DocumentsRecord>
                                                          columnDocumentsRecordList =
                                                          snapshot.data!;

                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: List.generate(
                                                            columnDocumentsRecordList
                                                                .length,
                                                            (columnIndex) {
                                                          final columnDocumentsRecord =
                                                              columnDocumentsRecordList[
                                                                  columnIndex];
                                                          return InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              await showModalBottomSheet(
                                                                isScrollControlled:
                                                                    true,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                enableDrag:
                                                                    false,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Padding(
                                                                    padding: MediaQuery
                                                                        .viewInsetsOf(
                                                                            context),
                                                                    child:
                                                                        AjustesWidget(
                                                                      docDocument:
                                                                          columnDocumentsRecord,
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) =>
                                                                  safeSetState(
                                                                      () {}));
                                                            },
                                                            child:
                                                                wrapWithModel(
                                                              model: _model
                                                                  .cardBillvencidoModels
                                                                  .getModel(
                                                                columnDocumentsRecord
                                                                    .reference
                                                                    .id,
                                                                columnIndex,
                                                              ),
                                                              updateCallback: () =>
                                                                  safeSetState(
                                                                      () {}),
                                                              child:
                                                                  CardBillvencidoWidget(
                                                                key: Key(
                                                                  'Keye94_${columnDocumentsRecord.reference.id}',
                                                                ),
                                                                docDocumen:
                                                                    columnDocumentsRecord,
                                                              ),
                                                            ),
                                                          );
                                                        }).divide(SizedBox(
                                                            height: 10.0)),
                                                      );
                                                    },
                                                  ),
                                                ]
                                                    .divide(
                                                        SizedBox(height: 10.0))
                                                    .addToStart(
                                                        SizedBox(height: 20.0))
                                                    .addToEnd(
                                                        SizedBox(height: 20.0)),
                                              ),
                                            ),
                                        ]
                                            .divide(SizedBox(height: 10.0))
                                            .addToStart(SizedBox(height: 20.0)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0x1F71F9F1),
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'fu26ssxg' /* Finanzas */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      fontSize: 22.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20.0, 0.0, 20.0, 0.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 4.0,
                                                    color: Color(0x33000000),
                                                    offset: Offset(
                                                      0.0,
                                                      2.0,
                                                    ),
                                                  )
                                                ],
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(10.0),
                                                  topRight:
                                                      Radius.circular(10.0),
                                                  bottomLeft:
                                                      Radius.circular(10.0),
                                                  bottomRight:
                                                      Radius.circular(10.0),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'b829oa14' /* Mes Actual: */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        '${dateTimeFormat(
                                                          "MMMM",
                                                          dateTimeFromSecondsSinceEpoch(
                                                              valueOrDefault<
                                                                  int>(
                                                            getCurrentTimestamp
                                                                .secondsSinceEpoch,
                                                            0,
                                                          )),
                                                          locale:
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .languageCode,
                                                        )} ${dateTimeFormat(
                                                          "y",
                                                          getCurrentTimestamp,
                                                          locale:
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .languageCode,
                                                        )}',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 10.0)),
                                                  ),
                                                  if (valueOrDefault<bool>(
                                                          currentUserDocument
                                                              ?.isPremium,
                                                          false) ==
                                                      true)
                                                    AuthUserStreamWidget(
                                                      builder: (context) =>
                                                          Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    10.0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10.0),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'ufdykbvu' /* Balance Total Entre Cuentas */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.roboto(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    width:
                                                                        6.0)),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  formatNumber(
                                                                    valueOrDefault(
                                                                        currentUserDocument
                                                                            ?.totalBalance,
                                                                        0.0),
                                                                    formatType:
                                                                        FormatType
                                                                            .decimal,
                                                                    decimalType:
                                                                        DecimalType
                                                                            .automatic,
                                                                    currency:
                                                                        '\$',
                                                                  ),
                                                                  '0',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .roboto(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FFAppState().sumBankBalan >
                                                                              0.0
                                                                          ? Color(
                                                                              0xFF109D06)
                                                                          : Color(
                                                                              0xFFE00606),
                                                                      fontSize:
                                                                          22.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20.0,
                                                                          0.0,
                                                                          20.0,
                                                                          0.0),
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                height: 2.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                ),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 5.0)),
                                                        ),
                                                      ),
                                                    ),
                                                  if (valueOrDefault<bool>(
                                                          currentUserDocument
                                                              ?.isPremium,
                                                          false) ==
                                                      true)
                                                    AuthUserStreamWidget(
                                                      builder: (context) =>
                                                          Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    10.0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10.0),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'joxvxg3e' /* Monto Total de Transacciones P... */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.roboto(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    width:
                                                                        6.0)),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  formatNumber(
                                                                    valueOrDefault(
                                                                        currentUserDocument
                                                                            ?.internalAdjustment,
                                                                        0.0),
                                                                    formatType:
                                                                        FormatType
                                                                            .decimal,
                                                                    decimalType:
                                                                        DecimalType
                                                                            .automatic,
                                                                    currency:
                                                                        '\$',
                                                                  ),
                                                                  '0',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .roboto(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FFAppState().sumInternalPendings >
                                                                              0.0
                                                                          ? Color(
                                                                              0xFF109D06)
                                                                          : Color(
                                                                              0xFFE00606),
                                                                      fontSize:
                                                                          22.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20.0,
                                                                          0.0,
                                                                          20.0,
                                                                          0.0),
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                height: 2.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                ),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 5.0)),
                                                        ),
                                                      ),
                                                    ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                10.0),
                                                        topRight:
                                                            Radius.circular(
                                                                10.0),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                10.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                10.0),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      20.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'z4vqmbl0' /* Ingreso Total Mensual Proyecta... */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .roboto(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        fontSize:
                                                                            14.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 6.0)),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child:
                                                              AuthUserStreamWidget(
                                                            builder:
                                                                (context) =>
                                                                    Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                formatNumber(
                                                                  valueOrDefault<bool>(
                                                                              currentUserDocument
                                                                                  ?.isPremium,
                                                                              false) ==
                                                                          true
                                                                      ? valueOrDefault(
                                                                          currentUserDocument
                                                                              ?.projectedIncome,
                                                                          0.0)
                                                                      : valueOrDefault<
                                                                          double>(
                                                                          FFAppState()
                                                                              .sumIncomes,
                                                                          0.0,
                                                                        ),
                                                                  formatType:
                                                                      FormatType
                                                                          .decimal,
                                                                  decimalType:
                                                                      DecimalType
                                                                          .automatic,
                                                                  currency:
                                                                      '\$',
                                                                ),
                                                                '0',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .roboto(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: () {
                                                                      if (FFAppState()
                                                                              .sumIncomes >
                                                                          0.0) {
                                                                        return Color(
                                                                            0xFF109D06);
                                                                      } else if (FFAppState()
                                                                              .sumIncomPending >
                                                                          0.0) {
                                                                        return Color(
                                                                            0xFF109D06);
                                                                      } else {
                                                                        return Color(
                                                                            0x00000000);
                                                                      }
                                                                    }(),
                                                                    fontSize:
                                                                        22.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      20.0,
                                                                      0.0,
                                                                      20.0,
                                                                      0.0),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height: 2.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                            ),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 5.0)),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                10.0),
                                                        topRight:
                                                            Radius.circular(
                                                                10.0),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                10.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                10.0),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      20.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'vso6qbm7' /* Gasto Total Mensual Proyectado */,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  maxLines: 2,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .roboto(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        fontSize:
                                                                            14.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 6.0)),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child:
                                                              AuthUserStreamWidget(
                                                            builder:
                                                                (context) =>
                                                                    Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                formatNumber(
                                                                  valueOrDefault<bool>(
                                                                              currentUserDocument
                                                                                  ?.isPremium,
                                                                              false) ==
                                                                          true
                                                                      ? valueOrDefault(
                                                                          currentUserDocument
                                                                              ?.projectedExpenses,
                                                                          0.0)
                                                                      : FFAppState()
                                                                          .sumExpenses,
                                                                  formatType:
                                                                      FormatType
                                                                          .decimal,
                                                                  decimalType:
                                                                      DecimalType
                                                                          .automatic,
                                                                  currency:
                                                                      '\$',
                                                                ),
                                                                '0',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .roboto(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Color(
                                                                        0xFFF5080D),
                                                                    fontSize:
                                                                        22.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      20.0,
                                                                      0.0,
                                                                      20.0,
                                                                      0.0),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height: 2.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                            ),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 5.0)),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                10.0),
                                                        topRight:
                                                            Radius.circular(
                                                                10.0),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                10.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                10.0),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      20.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  await showModalBottomSheet(
                                                                    isScrollControlled:
                                                                        true,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    enableDrag:
                                                                        false,
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return Padding(
                                                                        padding:
                                                                            MediaQuery.viewInsetsOf(context),
                                                                        child:
                                                                            InfoFlujodeefectivoWidget(),
                                                                      );
                                                                    },
                                                                  ).then((value) =>
                                                                      safeSetState(
                                                                          () {}));
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .info_outline,
                                                                  color: Color(
                                                                      0xFF003326),
                                                                  size: 20.0,
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'pu03qkui' /* Flujo de Efectivo Mensual Proy... */,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  maxLines: 2,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .roboto(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        fontSize:
                                                                            14.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 6.0)),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child:
                                                              AuthUserStreamWidget(
                                                            builder:
                                                                (context) =>
                                                                    Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                formatNumber(
                                                                  valueOrDefault<bool>(
                                                                              currentUserDocument
                                                                                  ?.isPremium,
                                                                              false) ==
                                                                          true
                                                                      ? valueOrDefault(
                                                                          currentUserDocument
                                                                              ?.projectedFlow,
                                                                          0.0)
                                                                      : valueOrDefault<
                                                                          double>(
                                                                          functions.calcNetCashflow(
                                                                              FFAppState().sumIncomes,
                                                                              FFAppState().sumExpenses,
                                                                              0.0),
                                                                          0.0,
                                                                        ),
                                                                  formatType:
                                                                      FormatType
                                                                          .decimal,
                                                                  decimalType:
                                                                      DecimalType
                                                                          .automatic,
                                                                  currency:
                                                                      '\$',
                                                                ),
                                                                '0',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .roboto(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FFAppState().cashFlowProyected >
                                                                            0.0
                                                                        ? Color(
                                                                            0xFF109D06)
                                                                        : Color(
                                                                            0xFFE00606),
                                                                    fontSize:
                                                                        28.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 5.0)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(20.0, 0.0,
                                                                20.0, 0.0),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 2.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                10.0),
                                                        topRight:
                                                            Radius.circular(
                                                                10.0),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                10.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                10.0),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      20.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'pd64did4' /* Ahorros Totales Proyectado */,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  maxLines: 2,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .roboto(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        fontSize:
                                                                            14.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 6.0)),
                                                          ),
                                                        ),
                                                        AuthUserStreamWidget(
                                                          builder: (context) =>
                                                              Text(
                                                            valueOrDefault<
                                                                String>(
                                                              formatNumber(
                                                                valueOrDefault<bool>(
                                                                            currentUserDocument
                                                                                ?.isPremium,
                                                                            false) ==
                                                                        true
                                                                    ? FFAppState()
                                                                        .sumSavePending
                                                                    : FFAppState()
                                                                        .sumSave,
                                                                formatType:
                                                                    FormatType
                                                                        .decimal,
                                                                decimalType:
                                                                    DecimalType
                                                                        .automatic,
                                                                currency: '\$',
                                                              ),
                                                              '0',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FFAppState()
                                                                              .sumSave >
                                                                          0.0
                                                                      ? Color(
                                                                          0xFFCDC404)
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                  fontSize:
                                                                      22.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      20.0,
                                                                      0.0,
                                                                      20.0,
                                                                      0.0),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height: 2.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                            ),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 5.0)),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                10.0),
                                                        topRight:
                                                            Radius.circular(
                                                                10.0),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                10.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                10.0),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      20.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  await showModalBottomSheet(
                                                                    isScrollControlled:
                                                                        true,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    enableDrag:
                                                                        false,
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return Padding(
                                                                        padding:
                                                                            MediaQuery.viewInsetsOf(context),
                                                                        child:
                                                                            InfoEfectivorestanteWidget(),
                                                                      );
                                                                    },
                                                                  ).then((value) =>
                                                                      safeSetState(
                                                                          () {}));
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .info_outlined,
                                                                  color: Color(
                                                                      0xFF003326),
                                                                  size: 20.0,
                                                                ),
                                                              ),
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'qgu1xblp' /* Disponible Para Gastar Proyect... */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .roboto(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 6.0)),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child:
                                                              AuthUserStreamWidget(
                                                            builder:
                                                                (context) =>
                                                                    Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                formatNumber(
                                                                  valueOrDefault<bool>(
                                                                              currentUserDocument
                                                                                  ?.isPremium,
                                                                              false) ==
                                                                          true
                                                                      ? valueOrDefault(
                                                                          currentUserDocument
                                                                              ?.availableToSpend,
                                                                          0.0)
                                                                      : valueOrDefault<
                                                                          double>(
                                                                          functions.calcNetCashflow(
                                                                              FFAppState().sumIncomes,
                                                                              FFAppState().sumExpenses,
                                                                              FFAppState().sumSave),
                                                                          0.0,
                                                                        ),
                                                                  formatType:
                                                                      FormatType
                                                                          .decimal,
                                                                  decimalType:
                                                                      DecimalType
                                                                          .automatic,
                                                                  currency:
                                                                      '\$',
                                                                ),
                                                                '0',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .roboto(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: () {
                                                                      if (valueOrDefault<
                                                                              double>(
                                                                            functions.calcNetCashflow(
                                                                                FFAppState().sumIncomes,
                                                                                FFAppState().sumExpenses,
                                                                                FFAppState().sumSave),
                                                                            0.0,
                                                                          ) >
                                                                          0.0) {
                                                                        return Color(
                                                                            0xFF109D06);
                                                                      } else if ((FFAppState().cashFlowProyected -
                                                                              FFAppState().sumSaveAccount -
                                                                              FFAppState().sumSavePending) >
                                                                          0.0) {
                                                                        return Color(
                                                                            0xFF109D06);
                                                                      } else {
                                                                        return Color(
                                                                            0xFFEF0202);
                                                                      }
                                                                    }(),
                                                                    fontSize:
                                                                        28.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 5.0)),
                                                    ),
                                                  ),
                                                ]
                                                    .divide(
                                                        SizedBox(height: 10.0))
                                                    .addToStart(
                                                        SizedBox(height: 20.0))
                                                    .addToEnd(
                                                        SizedBox(height: 20.0)),
                                              ),
                                            ),
                                          ),
                                          if ((valueOrDefault<bool>(
                                                      currentUserDocument
                                                          ?.isPremium,
                                                      false) ==
                                                  true) &&
                                              (valueOrDefault<bool>(
                                                      currentUserDocument
                                                          ?.isBasic,
                                                      false) ==
                                                  false) &&
                                              (valueOrDefault<bool>(
                                                      currentUserDocument
                                                          ?.isBasicWhitAnunces,
                                                      false) ==
                                                  false))
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 20.0, 0.0),
                                              child: AuthUserStreamWidget(
                                                builder: (context) => Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 4.0,
                                                        color:
                                                            Color(0x33000000),
                                                        offset: Offset(
                                                          0.0,
                                                          2.0,
                                                        ),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10.0),
                                                      topRight:
                                                          Radius.circular(10.0),
                                                      bottomLeft:
                                                          Radius.circular(10.0),
                                                      bottomRight:
                                                          Radius.circular(10.0),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .only(),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'axn33hnv' /* Ingreso Total Anual Proyectado */,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      maxLines:
                                                                          2,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.roboto(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    width:
                                                                        6.0)),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  formatNumber(
                                                                    FFAppState()
                                                                        .anualIncome,
                                                                    formatType:
                                                                        FormatType
                                                                            .decimal,
                                                                    decimalType:
                                                                        DecimalType
                                                                            .automatic,
                                                                    currency:
                                                                        '\$',
                                                                  ),
                                                                  '0',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .roboto(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .accent1,
                                                                      fontSize:
                                                                          22.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20.0,
                                                                          0.0,
                                                                          20.0,
                                                                          0.0),
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                height: 2.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                ),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 5.0)),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .only(),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'dxk4bljk' /* Gasto Total Anual Proyectado */,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      maxLines:
                                                                          2,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.roboto(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    width:
                                                                        6.0)),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  formatNumber(
                                                                    FFAppState()
                                                                        .anualExpenses,
                                                                    formatType:
                                                                        FormatType
                                                                            .decimal,
                                                                    decimalType:
                                                                        DecimalType
                                                                            .automatic,
                                                                    currency:
                                                                        '\$',
                                                                  ),
                                                                  '0',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .roboto(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .accent1,
                                                                      fontSize:
                                                                          22.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20.0,
                                                                          0.0,
                                                                          20.0,
                                                                          0.0),
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                height: 2.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                ),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 5.0)),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .only(),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'wq0lfkq3' /* Flujo de Efectivo Total Anual ... */,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      maxLines:
                                                                          2,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.roboto(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    width:
                                                                        6.0)),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  formatNumber(
                                                                    FFAppState()
                                                                        .anualCashFlow,
                                                                    formatType:
                                                                        FormatType
                                                                            .decimal,
                                                                    decimalType:
                                                                        DecimalType
                                                                            .automatic,
                                                                    currency:
                                                                        '\$',
                                                                  ),
                                                                  '0',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .roboto(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: functions
                                                                          .cashFlowColor(
                                                                              valueOrDefault<double>(
                                                                        FFAppState()
                                                                            .anualCashFlow,
                                                                        0.0,
                                                                      )),
                                                                      fontSize:
                                                                          22.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20.0,
                                                                          0.0,
                                                                          20.0,
                                                                          0.0),
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                height: 2.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                ),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 5.0)),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .only(),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        '6o0abik0' /* Ahorro Total Anual Proyectado */,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      maxLines:
                                                                          2,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.roboto(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    width:
                                                                        6.0)),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  formatNumber(
                                                                    FFAppState()
                                                                        .anualSaves,
                                                                    formatType:
                                                                        FormatType
                                                                            .decimal,
                                                                    decimalType:
                                                                        DecimalType
                                                                            .automatic,
                                                                    currency:
                                                                        '\$',
                                                                  ),
                                                                  '0',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .roboto(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .accent1,
                                                                      fontSize:
                                                                          22.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 5.0)),
                                                        ),
                                                      ),
                                                    ]
                                                        .divide(SizedBox(
                                                            height: 10.0))
                                                        .addToStart(SizedBox(
                                                            height: 20.0))
                                                        .addToEnd(SizedBox(
                                                            height: 20.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if (valueOrDefault(
                                                  currentUserDocument?.language,
                                                  '') ==
                                              'es')
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 20.0, 0.0),
                                              child: AuthUserStreamWidget(
                                                builder: (context) => InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    await showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      enableDrag: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return Padding(
                                                          padding: MediaQuery
                                                              .viewInsetsOf(
                                                                  context),
                                                          child: BokimgWidget(),
                                                        );
                                                      },
                                                    ).then((value) =>
                                                        safeSetState(() {}));
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 278.63,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 4.0,
                                                          color:
                                                              Color(0x33000000),
                                                          offset: Offset(
                                                            0.0,
                                                            2.0,
                                                          ),
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                10.0),
                                                        topRight:
                                                            Radius.circular(
                                                                10.0),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                10.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                10.0),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  14.0),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4.0),
                                                            child: Image.asset(
                                                              'assets/images/1000167958.jpg',
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          10.0,
                                                                          10.0,
                                                                          14.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      'epbluwwz' /* YA CUALQUIERA
 ES MILLONARIO */
                                                                      ,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    maxLines: 2,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.roboto(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              14.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                  Container(
                                                                    width:
                                                                        173.4,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child: Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'zjwfxnul' /* Una guía clara y directa para ... */,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.roboto(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            fontSize:
                                                                                13.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ]
                                            .divide(SizedBox(height: 10.0))
                                            .addToStart(SizedBox(height: 20.0))
                                            .addToEnd(SizedBox(height: 20.0)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0x1F71F9F1),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 0.0, 20.0, 0.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'xx1hb2zh' /* Cuentas  */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      fontSize: 24.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ),
                                            if ((valueOrDefault<bool>(
                                                        currentUserDocument
                                                            ?.isPremium,
                                                        false) ==
                                                    true) &&
                                                (valueOrDefault<bool>(
                                                        currentUserDocument
                                                            ?.isAccountsVinculated,
                                                        false) ==
                                                    true))
                                              AuthUserStreamWidget(
                                                builder: (context) => Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        FFButtonWidget(
                                                          onPressed: () async {
                                                            FFAppState()
                                                                    .isSaveSelect =
                                                                false;
                                                            FFAppState()
                                                                    .isChekSelect =
                                                                true;
                                                            FFAppState()
                                                                    .isCreditSelect =
                                                                false;
                                                            safeSetState(() {});
                                                          },
                                                          text: FFLocalizations
                                                                  .of(context)
                                                              .getText(
                                                            'dxt9kb3c' /* Cheques */,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            height: 25.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: (FFAppState().isChekSelect == true) &&
                                                                    (FFAppState()
                                                                            .isSaveSelect ==
                                                                        false) &&
                                                                    (FFAppState()
                                                                            .isCreditSelect ==
                                                                        false)
                                                                ? Color(
                                                                    0xFF01654D)
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .roboto(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: (FFAppState().isChekSelect == true) &&
                                                                              (FFAppState().isSaveSelect ==
                                                                                  false) &&
                                                                              (FFAppState().isCreditSelect ==
                                                                                  false)
                                                                          ? FlutterFlowTheme.of(context)
                                                                              .alternate
                                                                          : FlutterFlowTheme.of(context)
                                                                              .primary,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontStyle,
                                                                    ),
                                                            elevation: 0.0,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                        ),
                                                        FFButtonWidget(
                                                          onPressed: () async {
                                                            FFAppState()
                                                                    .isSaveSelect =
                                                                true;
                                                            FFAppState()
                                                                    .isChekSelect =
                                                                false;
                                                            FFAppState()
                                                                    .isCreditSelect =
                                                                false;
                                                            safeSetState(() {});
                                                          },
                                                          text: FFLocalizations
                                                                  .of(context)
                                                              .getText(
                                                            'cxfwph7h' /* Ahorros */,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            height: 25.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: (FFAppState().isChekSelect == false) &&
                                                                    (FFAppState()
                                                                            .isSaveSelect ==
                                                                        true) &&
                                                                    (FFAppState()
                                                                            .isCreditSelect ==
                                                                        false)
                                                                ? Color(
                                                                    0xFF01654D)
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .roboto(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: (FFAppState().isChekSelect == false) &&
                                                                              (FFAppState().isSaveSelect ==
                                                                                  true) &&
                                                                              (FFAppState().isCreditSelect ==
                                                                                  false)
                                                                          ? FlutterFlowTheme.of(context)
                                                                              .alternate
                                                                          : FlutterFlowTheme.of(context)
                                                                              .primary,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontStyle,
                                                                    ),
                                                            elevation: 0.0,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                        ),
                                                        FFButtonWidget(
                                                          onPressed: () async {
                                                            FFAppState()
                                                                    .isSaveSelect =
                                                                false;
                                                            FFAppState()
                                                                    .isChekSelect =
                                                                false;
                                                            FFAppState()
                                                                    .isCreditSelect =
                                                                true;
                                                            safeSetState(() {});
                                                          },
                                                          text: FFLocalizations
                                                                  .of(context)
                                                              .getText(
                                                            'cdchq82q' /* Créditos */,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            height: 25.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: (FFAppState().isChekSelect == false) &&
                                                                    (FFAppState()
                                                                            .isSaveSelect ==
                                                                        false) &&
                                                                    (FFAppState()
                                                                            .isCreditSelect ==
                                                                        true)
                                                                ? Color(
                                                                    0xFF01654D)
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .roboto(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: (FFAppState().isChekSelect == false) &&
                                                                              (FFAppState().isSaveSelect ==
                                                                                  false) &&
                                                                              (FFAppState().isCreditSelect ==
                                                                                  true)
                                                                          ? FlutterFlowTheme.of(context)
                                                                              .alternate
                                                                          : FlutterFlowTheme.of(context)
                                                                              .primary,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontStyle,
                                                                    ),
                                                            elevation: 0.0,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Builder(
                                                      builder: (context) {
                                                        if (FFAppState()
                                                                .isSaveSelect ==
                                                            true) {
                                                          return Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      'guxo3dh0' /* Total Ahorrado: */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.roboto(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                  StreamBuilder<
                                                                      List<
                                                                          BankAccountsRecord>>(
                                                                    stream:
                                                                        queryBankAccountsRecord(
                                                                      queryBuilder: (bankAccountsRecord) => bankAccountsRecord
                                                                          .where(
                                                                            'userRef',
                                                                            isEqualTo:
                                                                                currentUserReference,
                                                                          )
                                                                          .where(
                                                                            'isSavingAccount',
                                                                            isEqualTo:
                                                                                true,
                                                                          ),
                                                                    ),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      // Customize what your widget looks like when it's loading.
                                                                      if (!snapshot
                                                                          .hasData) {
                                                                        return Center(
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                40.0,
                                                                            height:
                                                                                40.0,
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                                                FlutterFlowTheme.of(context).primary,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                      List<BankAccountsRecord>
                                                                          textBankAccountsRecordList =
                                                                          snapshot
                                                                              .data!;

                                                                      return Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          formatNumber(
                                                                            functions.sum(textBankAccountsRecordList.map((e) => e.availableBalance).toList()),
                                                                            formatType:
                                                                                FormatType.decimal,
                                                                            decimalType:
                                                                                DecimalType.automatic,
                                                                            currency:
                                                                                '\$',
                                                                          ),
                                                                          '0',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.roboto(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              fontSize: 18.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            10.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: StreamBuilder<
                                                                    List<
                                                                        BankAccountsRecord>>(
                                                                  stream:
                                                                      queryBankAccountsRecord(
                                                                    queryBuilder: (bankAccountsRecord) =>
                                                                        bankAccountsRecord
                                                                            .where(
                                                                              'userRef',
                                                                              isEqualTo: currentUserReference,
                                                                            )
                                                                            .where(
                                                                              'isSavingAccount',
                                                                              isEqualTo: true,
                                                                            ),
                                                                  ),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    // Customize what your widget looks like when it's loading.
                                                                    if (!snapshot
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              40.0,
                                                                          height:
                                                                              40.0,
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            valueColor:
                                                                                AlwaysStoppedAnimation<Color>(
                                                                              FlutterFlowTheme.of(context).primary,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                    List<BankAccountsRecord>
                                                                        listSaveBankAccountsRecordList =
                                                                        snapshot
                                                                            .data!;

                                                                    return Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: List.generate(
                                                                          listSaveBankAccountsRecordList
                                                                              .length,
                                                                          (listSaveIndex) {
                                                                        final listSaveBankAccountsRecord =
                                                                            listSaveBankAccountsRecordList[listSaveIndex];
                                                                        return StreamBuilder<
                                                                            List<PlaidItemsRecord>>(
                                                                          stream:
                                                                              queryPlaidItemsRecord(
                                                                            queryBuilder: (plaidItemsRecord) => plaidItemsRecord
                                                                                .where(
                                                                                  'userRef',
                                                                                  isEqualTo: currentUserReference,
                                                                                )
                                                                                .where(
                                                                                  'itemId',
                                                                                  isEqualTo: listSaveBankAccountsRecord.itemId,
                                                                                ),
                                                                            singleRecord:
                                                                                true,
                                                                          ),
                                                                          builder:
                                                                              (context, snapshot) {
                                                                            // Customize what your widget looks like when it's loading.
                                                                            if (!snapshot.hasData) {
                                                                              return Center(
                                                                                child: SizedBox(
                                                                                  width: 40.0,
                                                                                  height: 40.0,
                                                                                  child: CircularProgressIndicator(
                                                                                    valueColor: AlwaysStoppedAnimation<Color>(
                                                                                      FlutterFlowTheme.of(context).primary,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }
                                                                            List<PlaidItemsRecord>
                                                                                bankAcountPlaidItemsRecordList =
                                                                                snapshot.data!;
                                                                            // Return an empty Container when the item does not exist.
                                                                            if (snapshot.data!.isEmpty) {
                                                                              return Container();
                                                                            }
                                                                            final bankAcountPlaidItemsRecord = bankAcountPlaidItemsRecordList.isNotEmpty
                                                                                ? bankAcountPlaidItemsRecordList.first
                                                                                : null;

                                                                            return InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                if (bankAcountPlaidItemsRecord?.needsAttention == true) {
                                                                                  await showModalBottomSheet(
                                                                                    isScrollControlled: true,
                                                                                    backgroundColor: Colors.transparent,
                                                                                    enableDrag: false,
                                                                                    context: context,
                                                                                    builder: (context) {
                                                                                      return Padding(
                                                                                        padding: MediaQuery.viewInsetsOf(context),
                                                                                        child: ReconectarcuentasWidget(),
                                                                                      );
                                                                                    },
                                                                                  ).then((value) => safeSetState(() {}));
                                                                                } else {
                                                                                  context.pushNamed(
                                                                                    OperationsWidget.routeName,
                                                                                    queryParameters: {
                                                                                      'plaidAccountId': serializeParam(
                                                                                        listSaveBankAccountsRecord.plaidAccountId,
                                                                                        ParamType.String,
                                                                                      ),
                                                                                      'acountDocument': serializeParam(
                                                                                        listSaveBankAccountsRecord,
                                                                                        ParamType.Document,
                                                                                      ),
                                                                                    }.withoutNulls,
                                                                                    extra: <String, dynamic>{
                                                                                      'acountDocument': listSaveBankAccountsRecord,
                                                                                    },
                                                                                  );
                                                                                }
                                                                              },
                                                                              child: wrapWithModel(
                                                                                model: _model.bankAcountModels1.getModel(
                                                                                  listSaveBankAccountsRecord.reference.id,
                                                                                  listSaveIndex,
                                                                                ),
                                                                                updateCallback: () => safeSetState(() {}),
                                                                                child: BankAcountWidget(
                                                                                  key: Key(
                                                                                    'Keyoo8_${listSaveBankAccountsRecord.reference.id}',
                                                                                  ),
                                                                                  bankAcountDocument: listSaveBankAccountsRecord,
                                                                                  needsAttention: bankAcountPlaidItemsRecord!.needsAttention,
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        );
                                                                      }).divide(SizedBox(
                                                                          height:
                                                                              10.0)),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                height: 10.0)),
                                                          );
                                                        } else if (FFAppState()
                                                                .isChekSelect ==
                                                            true) {
                                                          return Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'x7mn2xlv' /* Total Disponible: */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.roboto(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                      StreamBuilder<
                                                                          List<
                                                                              BankAccountsRecord>>(
                                                                        stream:
                                                                            queryBankAccountsRecord(
                                                                          queryBuilder: (bankAccountsRecord) => bankAccountsRecord
                                                                              .where(
                                                                                'userRef',
                                                                                isEqualTo: currentUserReference,
                                                                              )
                                                                              .where(
                                                                                'isChequingAccount',
                                                                                isEqualTo: true,
                                                                              ),
                                                                        ),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          // Customize what your widget looks like when it's loading.
                                                                          if (!snapshot
                                                                              .hasData) {
                                                                            return Center(
                                                                              child: SizedBox(
                                                                                width: 40.0,
                                                                                height: 40.0,
                                                                                child: CircularProgressIndicator(
                                                                                  valueColor: AlwaysStoppedAnimation<Color>(
                                                                                    FlutterFlowTheme.of(context).primary,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }
                                                                          List<BankAccountsRecord>
                                                                              textBankAccountsRecordList =
                                                                              snapshot.data!;

                                                                          return Text(
                                                                            valueOrDefault<String>(
                                                                              formatNumber(
                                                                                functions.sum(textBankAccountsRecordList.map((e) => e.availableBalance).toList()),
                                                                                formatType: FormatType.decimal,
                                                                                decimalType: DecimalType.automatic,
                                                                                currency: '\$',
                                                                              ),
                                                                              '0',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.roboto(
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  fontSize: 18.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            10.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: StreamBuilder<
                                                                    List<
                                                                        BankAccountsRecord>>(
                                                                  stream:
                                                                      queryBankAccountsRecord(
                                                                    queryBuilder: (bankAccountsRecord) =>
                                                                        bankAccountsRecord
                                                                            .where(
                                                                              'userRef',
                                                                              isEqualTo: currentUserReference,
                                                                            )
                                                                            .where(
                                                                              'isChequingAccount',
                                                                              isEqualTo: true,
                                                                            ),
                                                                  ),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    // Customize what your widget looks like when it's loading.
                                                                    if (!snapshot
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              40.0,
                                                                          height:
                                                                              40.0,
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            valueColor:
                                                                                AlwaysStoppedAnimation<Color>(
                                                                              FlutterFlowTheme.of(context).primary,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                    List<BankAccountsRecord>
                                                                        listCheqBankAccountsRecordList =
                                                                        snapshot
                                                                            .data!;

                                                                    return Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: List.generate(
                                                                          listCheqBankAccountsRecordList
                                                                              .length,
                                                                          (listCheqIndex) {
                                                                        final listCheqBankAccountsRecord =
                                                                            listCheqBankAccountsRecordList[listCheqIndex];
                                                                        return StreamBuilder<
                                                                            List<PlaidItemsRecord>>(
                                                                          stream:
                                                                              queryPlaidItemsRecord(
                                                                            queryBuilder: (plaidItemsRecord) => plaidItemsRecord
                                                                                .where(
                                                                                  'userRef',
                                                                                  isEqualTo: currentUserReference,
                                                                                )
                                                                                .where(
                                                                                  'itemId',
                                                                                  isEqualTo: listCheqBankAccountsRecord.itemId,
                                                                                ),
                                                                            singleRecord:
                                                                                true,
                                                                          ),
                                                                          builder:
                                                                              (context, snapshot) {
                                                                            // Customize what your widget looks like when it's loading.
                                                                            if (!snapshot.hasData) {
                                                                              return Center(
                                                                                child: SizedBox(
                                                                                  width: 40.0,
                                                                                  height: 40.0,
                                                                                  child: CircularProgressIndicator(
                                                                                    valueColor: AlwaysStoppedAnimation<Color>(
                                                                                      FlutterFlowTheme.of(context).primary,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }
                                                                            List<PlaidItemsRecord>
                                                                                bankAcountPlaidItemsRecordList =
                                                                                snapshot.data!;
                                                                            // Return an empty Container when the item does not exist.
                                                                            if (snapshot.data!.isEmpty) {
                                                                              return Container();
                                                                            }
                                                                            final bankAcountPlaidItemsRecord = bankAcountPlaidItemsRecordList.isNotEmpty
                                                                                ? bankAcountPlaidItemsRecordList.first
                                                                                : null;

                                                                            return InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                if (bankAcountPlaidItemsRecord?.needsAttention == true) {
                                                                                  await showModalBottomSheet(
                                                                                    isScrollControlled: true,
                                                                                    backgroundColor: Colors.transparent,
                                                                                    enableDrag: false,
                                                                                    context: context,
                                                                                    builder: (context) {
                                                                                      return Padding(
                                                                                        padding: MediaQuery.viewInsetsOf(context),
                                                                                        child: ReconectarcuentasWidget(),
                                                                                      );
                                                                                    },
                                                                                  ).then((value) => safeSetState(() {}));
                                                                                } else {
                                                                                  context.pushNamed(
                                                                                    OperationsWidget.routeName,
                                                                                    queryParameters: {
                                                                                      'plaidAccountId': serializeParam(
                                                                                        listCheqBankAccountsRecord.plaidAccountId,
                                                                                        ParamType.String,
                                                                                      ),
                                                                                      'acountDocument': serializeParam(
                                                                                        listCheqBankAccountsRecord,
                                                                                        ParamType.Document,
                                                                                      ),
                                                                                    }.withoutNulls,
                                                                                    extra: <String, dynamic>{
                                                                                      'acountDocument': listCheqBankAccountsRecord,
                                                                                    },
                                                                                  );
                                                                                }
                                                                              },
                                                                              child: wrapWithModel(
                                                                                model: _model.bankAcountModels2.getModel(
                                                                                  listCheqBankAccountsRecord.reference.id,
                                                                                  listCheqIndex,
                                                                                ),
                                                                                updateCallback: () => safeSetState(() {}),
                                                                                child: BankAcountWidget(
                                                                                  key: Key(
                                                                                    'Keyfug_${listCheqBankAccountsRecord.reference.id}',
                                                                                  ),
                                                                                  bankAcountDocument: listCheqBankAccountsRecord,
                                                                                  needsAttention: bankAcountPlaidItemsRecord!.needsAttention,
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        );
                                                                      }).divide(SizedBox(
                                                                          height:
                                                                              10.0)),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                height: 10.0)),
                                                          );
                                                        } else {
                                                          return Visibility(
                                                            visible: FFAppState()
                                                                    .isCreditSelect ==
                                                                true,
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            '4kwa4224' /* Total Utilizado: */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.roboto(
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                        StreamBuilder<
                                                                            List<BankAccountsRecord>>(
                                                                          stream:
                                                                              queryBankAccountsRecord(
                                                                            queryBuilder: (bankAccountsRecord) => bankAccountsRecord
                                                                                .where(
                                                                                  'userRef',
                                                                                  isEqualTo: currentUserReference,
                                                                                )
                                                                                .where(
                                                                                  'isCreditAccount',
                                                                                  isEqualTo: true,
                                                                                ),
                                                                          ),
                                                                          builder:
                                                                              (context, snapshot) {
                                                                            // Customize what your widget looks like when it's loading.
                                                                            if (!snapshot.hasData) {
                                                                              return Center(
                                                                                child: SizedBox(
                                                                                  width: 40.0,
                                                                                  height: 40.0,
                                                                                  child: CircularProgressIndicator(
                                                                                    valueColor: AlwaysStoppedAnimation<Color>(
                                                                                      FlutterFlowTheme.of(context).primary,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }
                                                                            List<BankAccountsRecord>
                                                                                textBankAccountsRecordList =
                                                                                snapshot.data!;

                                                                            return Text(
                                                                              valueOrDefault<String>(
                                                                                formatNumber(
                                                                                  functions.sum(textBankAccountsRecordList.map((e) => e.currentBalance).toList()),
                                                                                  formatType: FormatType.decimal,
                                                                                  decimalType: DecimalType.automatic,
                                                                                  currency: '\$',
                                                                                ),
                                                                                '0',
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.roboto(
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                    fontSize: 18.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          10.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: StreamBuilder<
                                                                      List<
                                                                          BankAccountsRecord>>(
                                                                    stream:
                                                                        queryBankAccountsRecord(
                                                                      queryBuilder: (bankAccountsRecord) => bankAccountsRecord
                                                                          .where(
                                                                            'userRef',
                                                                            isEqualTo:
                                                                                currentUserReference,
                                                                          )
                                                                          .where(
                                                                            'isCreditAccount',
                                                                            isEqualTo:
                                                                                true,
                                                                          ),
                                                                    ),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      // Customize what your widget looks like when it's loading.
                                                                      if (!snapshot
                                                                          .hasData) {
                                                                        return Center(
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                40.0,
                                                                            height:
                                                                                40.0,
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                                                FlutterFlowTheme.of(context).primary,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                      List<BankAccountsRecord>
                                                                          listcreditBankAccountsRecordList =
                                                                          snapshot
                                                                              .data!;

                                                                      return Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: List.generate(
                                                                            listcreditBankAccountsRecordList.length,
                                                                            (listcreditIndex) {
                                                                          final listcreditBankAccountsRecord =
                                                                              listcreditBankAccountsRecordList[listcreditIndex];
                                                                          return StreamBuilder<
                                                                              List<PlaidItemsRecord>>(
                                                                            stream:
                                                                                queryPlaidItemsRecord(
                                                                              queryBuilder: (plaidItemsRecord) => plaidItemsRecord
                                                                                  .where(
                                                                                    'userRef',
                                                                                    isEqualTo: currentUserReference,
                                                                                  )
                                                                                  .where(
                                                                                    'itemId',
                                                                                    isEqualTo: listcreditBankAccountsRecord.itemId,
                                                                                  ),
                                                                              singleRecord: true,
                                                                            ),
                                                                            builder:
                                                                                (context, snapshot) {
                                                                              // Customize what your widget looks like when it's loading.
                                                                              if (!snapshot.hasData) {
                                                                                return Center(
                                                                                  child: SizedBox(
                                                                                    width: 40.0,
                                                                                    height: 40.0,
                                                                                    child: CircularProgressIndicator(
                                                                                      valueColor: AlwaysStoppedAnimation<Color>(
                                                                                        FlutterFlowTheme.of(context).primary,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              }
                                                                              List<PlaidItemsRecord> bankAcountPlaidItemsRecordList = snapshot.data!;
                                                                              // Return an empty Container when the item does not exist.
                                                                              if (snapshot.data!.isEmpty) {
                                                                                return Container();
                                                                              }
                                                                              final bankAcountPlaidItemsRecord = bankAcountPlaidItemsRecordList.isNotEmpty ? bankAcountPlaidItemsRecordList.first : null;

                                                                              return InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  if (bankAcountPlaidItemsRecord?.needsAttention == true) {
                                                                                    await showModalBottomSheet(
                                                                                      isScrollControlled: true,
                                                                                      backgroundColor: Colors.transparent,
                                                                                      enableDrag: false,
                                                                                      context: context,
                                                                                      builder: (context) {
                                                                                        return Padding(
                                                                                          padding: MediaQuery.viewInsetsOf(context),
                                                                                          child: ReconectarcuentasWidget(),
                                                                                        );
                                                                                      },
                                                                                    ).then((value) => safeSetState(() {}));
                                                                                  } else {
                                                                                    context.pushNamed(
                                                                                      OperationsWidget.routeName,
                                                                                      queryParameters: {
                                                                                        'plaidAccountId': serializeParam(
                                                                                          listcreditBankAccountsRecord.plaidAccountId,
                                                                                          ParamType.String,
                                                                                        ),
                                                                                        'acountDocument': serializeParam(
                                                                                          listcreditBankAccountsRecord,
                                                                                          ParamType.Document,
                                                                                        ),
                                                                                      }.withoutNulls,
                                                                                      extra: <String, dynamic>{
                                                                                        'acountDocument': listcreditBankAccountsRecord,
                                                                                      },
                                                                                    );
                                                                                  }
                                                                                },
                                                                                child: wrapWithModel(
                                                                                  model: _model.bankAcountModels3.getModel(
                                                                                    listcreditBankAccountsRecord.reference.id,
                                                                                    listcreditIndex,
                                                                                  ),
                                                                                  updateCallback: () => safeSetState(() {}),
                                                                                  child: BankAcountWidget(
                                                                                    key: Key(
                                                                                      'Keyqye_${listcreditBankAccountsRecord.reference.id}',
                                                                                    ),
                                                                                    bankAcountDocument: listcreditBankAccountsRecord,
                                                                                    needsAttention: bankAcountPlaidItemsRecord!.needsAttention,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          );
                                                                        }).divide(SizedBox(
                                                                            height:
                                                                                10.0)),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  height:
                                                                      10.0)),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 20.0)),
                                                ),
                                              ),
                                            if (valueOrDefault<bool>(
                                                    currentUserDocument
                                                        ?.isPremium,
                                                    false) ==
                                                true)
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                child: AuthUserStreamWidget(
                                                  builder: (context) =>
                                                      FFButtonWidget(
                                                    onPressed: (valueOrDefault<
                                                                    bool>(
                                                                currentUserDocument
                                                                    ?.isPremium,
                                                                false) ==
                                                            false)
                                                        ? null
                                                        : () async {
                                                            if (valueOrDefault<
                                                                        bool>(
                                                                    currentUserDocument
                                                                        ?.isAccountsVinculated,
                                                                    false) ==
                                                                true) {
                                                              try {
                                                                final result =
                                                                    await FirebaseFunctions
                                                                        .instance
                                                                        .httpsCallable(
                                                                            'startPlaidLinkWebV2')
                                                                        .call(
                                                                            {});
                                                                _model.plaidStartResult =
                                                                    StartPlaidLinkWebV2CloudFunctionCallResponse(
                                                                  succeeded:
                                                                      true,
                                                                );
                                                              } on FirebaseFunctionsException catch (error) {
                                                                _model.plaidStartResult =
                                                                    StartPlaidLinkWebV2CloudFunctionCallResponse(
                                                                  errorCode:
                                                                      error
                                                                          .code,
                                                                  succeeded:
                                                                      false,
                                                                );
                                                              }

                                                              if (_model
                                                                  .plaidStartResult!
                                                                  .succeeded!) {
                                                                _model.weburl =
                                                                    await queryPlaidLinkSessionsRecordOnce(
                                                                  queryBuilder:
                                                                      (plaidLinkSessionsRecord) =>
                                                                          plaidLinkSessionsRecord
                                                                              .where(
                                                                    'userRef',
                                                                    isEqualTo:
                                                                        currentUserReference,
                                                                  ),
                                                                  singleRecord:
                                                                      true,
                                                                ).then((s) => s
                                                                        .firstOrNull);
                                                                _model.url =
                                                                    _model
                                                                        .weburl
                                                                        ?.webUrl;
                                                                safeSetState(
                                                                    () {});
                                                                await launchURL(
                                                                    _model
                                                                        .weburl!
                                                                        .webUrl);

                                                                await currentUserReference!
                                                                    .update(
                                                                        createUserRecordData(
                                                                  isAccountsVinculated:
                                                                      true,
                                                                ));
                                                                await _model
                                                                    .weburl!
                                                                    .reference
                                                                    .delete();
                                                              }
                                                            } else {
                                                              if (valueOrDefault<
                                                                          bool>(
                                                                      currentUserDocument
                                                                          ?.isDocumentCreated,
                                                                      false) ==
                                                                  true) {
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  enableDrag:
                                                                      false,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return Padding(
                                                                      padding: MediaQuery
                                                                          .viewInsetsOf(
                                                                              context),
                                                                      child:
                                                                          ConectarcuentasWidget(),
                                                                    );
                                                                  },
                                                                ).then((value) =>
                                                                    safeSetState(
                                                                        () {}));
                                                              } else {
                                                                try {
                                                                  final result = await FirebaseFunctions
                                                                      .instance
                                                                      .httpsCallable(
                                                                          'startPlaidLinkWebV2')
                                                                      .call({});
                                                                  _model.plaidStartResult1 =
                                                                      StartPlaidLinkWebV2CloudFunctionCallResponse(
                                                                    succeeded:
                                                                        true,
                                                                  );
                                                                } on FirebaseFunctionsException catch (error) {
                                                                  _model.plaidStartResult1 =
                                                                      StartPlaidLinkWebV2CloudFunctionCallResponse(
                                                                    errorCode:
                                                                        error
                                                                            .code,
                                                                    succeeded:
                                                                        false,
                                                                  );
                                                                }

                                                                if (_model
                                                                    .plaidStartResult1!
                                                                    .succeeded!) {
                                                                  _model.weburl1 =
                                                                      await queryPlaidLinkSessionsRecordOnce(
                                                                    queryBuilder:
                                                                        (plaidLinkSessionsRecord) =>
                                                                            plaidLinkSessionsRecord.where(
                                                                      'userRef',
                                                                      isEqualTo:
                                                                          currentUserReference,
                                                                    ),
                                                                    singleRecord:
                                                                        true,
                                                                  ).then((s) =>
                                                                          s.firstOrNull);
                                                                  _model.url = _model
                                                                      .weburl1
                                                                      ?.webUrl;
                                                                  safeSetState(
                                                                      () {});
                                                                  await launchURL(_model
                                                                      .weburl1!
                                                                      .webUrl);

                                                                  await currentUserReference!
                                                                      .update(
                                                                          createUserRecordData(
                                                                    isAccountsVinculated:
                                                                        true,
                                                                  ));
                                                                  await _model
                                                                      .weburl1!
                                                                      .reference
                                                                      .delete();
                                                                }
                                                              }
                                                            }

                                                            safeSetState(() {});
                                                          },
                                                    text: FFLocalizations.of(
                                                            context)
                                                        .getText(
                                                      'n0hd9vvq' /* Añadir Cuentas  */,
                                                    ),
                                                    options: FFButtonOptions(
                                                      width: double.infinity,
                                                      height: 50.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16.0,
                                                                  0.0,
                                                                  16.0,
                                                                  0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color: Color(0xFF01654D),
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .roboto(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                              ),
                                                      elevation: 0.0,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            if ((valueOrDefault<bool>(
                                                        currentUserDocument
                                                            ?.isBasicWhitAnunces,
                                                        false) ==
                                                    true) ||
                                                (valueOrDefault<bool>(
                                                        currentUserDocument
                                                            ?.isBasic,
                                                        false) ==
                                                    true))
                                              AuthUserStreamWidget(
                                                builder: (context) => Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    RichText(
                                                      textScaler:
                                                          MediaQuery.of(context)
                                                              .textScaler,
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              'k0vslz1b' /* Estás utilizando la versión  b... */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                          TextSpan(
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              't4slncj6' /* Cuentas Bancarias  */,
                                                            ),
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              'arq1y8hp' /* está disponible en la versión  */,
                                                            ),
                                                            style: TextStyle(),
                                                          ),
                                                          TextSpan(
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              '765kgzuj' /* Premium

 */
                                                              ,
                                                            ),
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              '2ean90tj' /* Considera actualizar tu plan a... */,
                                                            ),
                                                            style: TextStyle(),
                                                          ),
                                                          TextSpan(
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              '5l42ihgf' /* ¿Qué funciones trae esta herra... */,
                                                            ),
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14.0,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              'tnvafbcw' /* 1️⃣ 🔗 Todas tus cuentas en un... */,
                                                            ),
                                                            style: TextStyle(),
                                                          ),
                                                          TextSpan(
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              'guhd99at' /* * Funciones Premium */,
                                                            ),
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          )
                                                        ],
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16.0,
                                                                  0.0,
                                                                  16.0,
                                                                  0.0),
                                                      child: FFButtonWidget(
                                                        onPressed: (valueOrDefault<
                                                                        bool>(
                                                                    currentUserDocument
                                                                        ?.isPremium,
                                                                    false) ==
                                                                false)
                                                            ? null
                                                            : () async {
                                                                context.pushNamed(
                                                                    SuscriptionsWidget
                                                                        .routeName);
                                                              },
                                                        text:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                          'dk91l396' /* Actualizar Plan */,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          width:
                                                              double.infinity,
                                                          height: 50.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      16.0,
                                                                      0.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color:
                                                              Color(0xFF01654D),
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .roboto(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Colors
                                                                        .white,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                          elevation: 0.0,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 25.0)),
                                                ),
                                              ),
                                          ]
                                              .divide(SizedBox(height: 15.0))
                                              .addToStart(
                                                  SizedBox(height: 20.0))
                                              .addToEnd(SizedBox(height: 20.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0x1F71F9F1),
                                    ),
                                    child: SingleChildScrollView(
                                      primary: false,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'zwz9eivi' /* Gestión automática  */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      fontSize: 24.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          if ((valueOrDefault<bool>(
                                                      currentUserDocument
                                                          ?.isPremium,
                                                      false) ==
                                                  true) &&
                                              (valueOrDefault<bool>(
                                                      currentUserDocument
                                                          ?.isBasic,
                                                      false) ==
                                                  false) &&
                                              (valueOrDefault<bool>(
                                                      currentUserDocument
                                                          ?.isBasicWhitAnunces,
                                                      false) ==
                                                  false) &&
                                              (valueOrDefault<bool>(
                                                      currentUserDocument
                                                          ?.isPilotoTest,
                                                      false) ==
                                                  false))
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 20.0, 0.0),
                                              child: AuthUserStreamWidget(
                                                builder: (context) =>
                                                    StreamBuilder<
                                                        List<GoaldsRecord>>(
                                                  stream: queryGoaldsRecord(
                                                    queryBuilder:
                                                        (goaldsRecord) =>
                                                            goaldsRecord.where(
                                                      'userRef',
                                                      isEqualTo:
                                                          currentUserReference,
                                                    ),
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 40.0,
                                                          height: 40.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<GoaldsRecord>
                                                        listViewGoaldsRecordList =
                                                        snapshot.data!;

                                                    return ListView.separated(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                        0,
                                                        0,
                                                        0,
                                                        20.0,
                                                      ),
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount:
                                                          listViewGoaldsRecordList
                                                              .length,
                                                      separatorBuilder:
                                                          (_, __) => SizedBox(
                                                              height: 10.0),
                                                      itemBuilder: (context,
                                                          listViewIndex) {
                                                        final listViewGoaldsRecord =
                                                            listViewGoaldsRecordList[
                                                                listViewIndex];
                                                        return InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            await showModalBottomSheet(
                                                              isScrollControlled:
                                                                  true,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              enableDrag: false,
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return Padding(
                                                                  padding: MediaQuery
                                                                      .viewInsetsOf(
                                                                          context),
                                                                  child:
                                                                      GoaldInfoWidget(
                                                                    docDocument:
                                                                        listViewGoaldsRecord,
                                                                  ),
                                                                );
                                                              },
                                                            ).then((value) =>
                                                                safeSetState(
                                                                    () {}));
                                                          },
                                                          child: wrapWithModel(
                                                            model: _model
                                                                .metascardModels
                                                                .getModel(
                                                              listViewGoaldsRecord
                                                                  .reference.id,
                                                              listViewIndex,
                                                            ),
                                                            updateCallback: () =>
                                                                safeSetState(
                                                                    () {}),
                                                            child:
                                                                MetascardWidget(
                                                              key: Key(
                                                                'Keydf6_${listViewGoaldsRecord.reference.id}',
                                                              ),
                                                              goalsDocument:
                                                                  listViewGoaldsRecord,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          if ((valueOrDefault<bool>(
                                                      currentUserDocument
                                                          ?.isPremium,
                                                      false) ==
                                                  true) &&
                                              (valueOrDefault<bool>(
                                                      currentUserDocument
                                                          ?.isBasic,
                                                      false) ==
                                                  false) &&
                                              (valueOrDefault<bool>(
                                                      currentUserDocument
                                                          ?.isBasicWhitAnunces,
                                                      false) ==
                                                  false) &&
                                              (valueOrDefault<bool>(
                                                      currentUserDocument
                                                          ?.isPilotoTest,
                                                      false) ==
                                                  false))
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 0.0),
                                              child: AuthUserStreamWidget(
                                                builder: (context) =>
                                                    FFButtonWidget(
                                                  onPressed: ((valueOrDefault<
                                                                      bool>(
                                                                  currentUserDocument
                                                                      ?.isPremium,
                                                                  false) ==
                                                              false) &&
                                                          ((_model.accounts !=
                                                                      null &&
                                                                  (_model.accounts)!
                                                                      .isNotEmpty) ==
                                                              false))
                                                      ? null
                                                      : () async {
                                                          await showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            enableDrag: false,
                                                            context: context,
                                                            builder: (context) {
                                                              return Padding(
                                                                padding: MediaQuery
                                                                    .viewInsetsOf(
                                                                        context),
                                                                child:
                                                                    GoaldCreatingWidget(),
                                                              );
                                                            },
                                                          ).then((value) =>
                                                              safeSetState(
                                                                  () {}));
                                                        },
                                                  text: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    't0dm9swd' /* Añadir Nueva Meta Financiera */,
                                                  ),
                                                  options: FFButtonOptions(
                                                    width: double.infinity,
                                                    height: 50.0,
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 0.0,
                                                                16.0, 0.0),
                                                    iconPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    color: Color(0xFF01654D),
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .titleSmall
                                                        .override(
                                                          font: GoogleFonts
                                                              .roboto(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                          ),
                                                          color: Colors.white,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontStyle,
                                                        ),
                                                    elevation: 0.0,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if ((valueOrDefault<bool>(
                                                      currentUserDocument
                                                          ?.isBasicWhitAnunces,
                                                      false) ==
                                                  true) ||
                                              (valueOrDefault<bool>(
                                                      currentUserDocument
                                                          ?.isBasic,
                                                      false) ==
                                                  true))
                                            AuthUserStreamWidget(
                                              builder: (context) => Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  if (valueOrDefault<bool>(
                                                          currentUserDocument
                                                              ?.isPilotoTest,
                                                          false) ==
                                                      true)
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  20.0,
                                                                  0.0,
                                                                  20.0,
                                                                  0.0),
                                                      child: RichText(
                                                        textScaler:
                                                            MediaQuery.of(
                                                                    context)
                                                                .textScaler,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: FFLocalizations
                                                                      .of(context)
                                                                  .getText(
                                                                'ge0r1rw8' /* Función en desarrollo

 */
                                                                ,
                                                              ),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 22.0,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: FFLocalizations
                                                                      .of(context)
                                                                  .getText(
                                                                'g15ea4ig' /* La Gestión automática  */,
                                                              ),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: FFLocalizations
                                                                      .of(context)
                                                                  .getText(
                                                                'vtu887va' /* estará disponible  en la versi... */,
                                                              ),
                                                              style:
                                                                  TextStyle(),
                                                            ),
                                                            TextSpan(
                                                              text: FFLocalizations
                                                                      .of(context)
                                                                  .getText(
                                                                'p9i0qvcg' /* Considera actualizar tu plan a... */,
                                                              ),
                                                              style:
                                                                  TextStyle(),
                                                            ),
                                                            TextSpan(
                                                              text: FFLocalizations
                                                                      .of(context)
                                                                  .getText(
                                                                'ra2f2yu2' /* ¿Qué aporta esta erramienta?

 */
                                                                ,
                                                              ),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14.0,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: FFLocalizations
                                                                      .of(context)
                                                                  .getText(
                                                                'b4ts9m8c' /* 1️⃣ 🎯 Dirección clara del din... */,
                                                              ),
                                                              style:
                                                                  TextStyle(),
                                                            ),
                                                            TextSpan(
                                                              text: FFLocalizations
                                                                      .of(context)
                                                                  .getText(
                                                                '4lc9672a' /* ¿Cómo funciona?

 */
                                                                ,
                                                              ),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16.0,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: FFLocalizations
                                                                      .of(context)
                                                                  .getText(
                                                                '21hk7x9d' /* 1️⃣ Creas una meta
Ej: carro, ... */
                                                                ,
                                                              ),
                                                              style:
                                                                  TextStyle(),
                                                            ),
                                                            TextSpan(
                                                              text: FFLocalizations
                                                                      .of(context)
                                                                  .getText(
                                                                'eivdta2n' /* * Funciones Premium */,
                                                              ),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            )
                                                          ],
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .roboto(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                ].divide(
                                                    SizedBox(height: 20.0)),
                                              ),
                                            ),
                                        ]
                                            .divide(SizedBox(height: 10.0))
                                            .addToStart(SizedBox(height: 20.0))
                                            .addToEnd(SizedBox(height: 20.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment(0.0, 0),
                              child: TabBar(
                                labelColor: Color(0xFF01654D),
                                unselectedLabelColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                                labelStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                unselectedLabelStyle: FlutterFlowTheme.of(
                                        context)
                                    .titleMedium
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                indicatorColor: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                tabs: [
                                  Tab(
                                    icon: Icon(
                                      Icons.account_balance,
                                      size: 30.0,
                                    ),
                                  ),
                                  Tab(
                                    icon: Icon(
                                      Icons.calendar_month,
                                      size: 30.0,
                                    ),
                                  ),
                                  Tab(
                                    icon: Icon(
                                      Icons.monetization_on,
                                      size: 30.0,
                                    ),
                                  ),
                                  Tab(
                                    icon: Icon(
                                      Icons.account_balance_wallet_rounded,
                                      size: 30.0,
                                    ),
                                  ),
                                  Tab(
                                    icon: Icon(
                                      Icons.done_all,
                                      size: 30.0,
                                    ),
                                  ),
                                ],
                                controller: _model.tabBarController,
                                onTap: (i) async {
                                  [
                                    () async {
                                      if (valueOrDefault<bool>(
                                              currentUserDocument?.isPremium,
                                              false) ==
                                          true) {
                                        unawaited(
                                          () async {
                                            try {
                                              final result = await FirebaseFunctions
                                                      .instanceFor(
                                                          region: 'us-central1')
                                                  .httpsCallable(
                                                      'goldAdvisorDailyBriefV2')
                                                  .call({
                                                "forceRefresh": false,
                                              });
                                              _model.welcome =
                                                  GoldAdvisorDailyBriefV2CloudFunctionCallResponse(
                                                succeeded: true,
                                              );
                                            } on FirebaseFunctionsException catch (error) {
                                              _model.welcome =
                                                  GoldAdvisorDailyBriefV2CloudFunctionCallResponse(
                                                errorCode: error.code,
                                                succeeded: false,
                                              );
                                            }
                                          }(),
                                        );
                                      } else {
                                        await Future.wait([
                                          Future(() async {
                                            _model.incomes1 =
                                                await queryDocumentsRecordOnce(
                                              queryBuilder: (documentsRecord) =>
                                                  documentsRecord
                                                      .where(
                                                        'userRef',
                                                        isEqualTo:
                                                            currentUserReference,
                                                      )
                                                      .where(
                                                        'isIncome',
                                                        isEqualTo: true,
                                                      )
                                                      .where(
                                                        'occurrenceKey',
                                                        isGreaterThanOrEqualTo:
                                                            functions
                                                                .monthBoundaries(
                                                                    getCurrentTimestamp)
                                                                .firstOrNull,
                                                      )
                                                      .where(
                                                        'occurrenceKey',
                                                        isLessThanOrEqualTo:
                                                            functions
                                                                .monthBoundaries(
                                                                    getCurrentTimestamp)
                                                                .lastOrNull,
                                                      ),
                                            );
                                          }),
                                          Future(() async {
                                            _model.expense1 =
                                                await queryDocumentsRecordOnce(
                                              queryBuilder: (documentsRecord) =>
                                                  documentsRecord
                                                      .where(
                                                        'userRef',
                                                        isEqualTo:
                                                            currentUserReference,
                                                      )
                                                      .where(
                                                        'isExpenses',
                                                        isEqualTo: true,
                                                      )
                                                      .where(
                                                        'occurrenceKey',
                                                        isGreaterThanOrEqualTo:
                                                            functions
                                                                .monthBoundaries(
                                                                    getCurrentTimestamp)
                                                                .firstOrNull,
                                                      )
                                                      .where(
                                                        'occurrenceKey',
                                                        isLessThanOrEqualTo:
                                                            functions
                                                                .monthBoundaries(
                                                                    getCurrentTimestamp)
                                                                .lastOrNull,
                                                      ),
                                            );
                                          }),
                                          Future(() async {
                                            _model.saves1 =
                                                await queryDocumentsRecordOnce(
                                              queryBuilder: (documentsRecord) =>
                                                  documentsRecord
                                                      .where(
                                                        'userRef',
                                                        isEqualTo:
                                                            currentUserReference,
                                                      )
                                                      .where(
                                                        'isSave',
                                                        isEqualTo: true,
                                                      )
                                                      .where(
                                                        'occurrenceKey',
                                                        isGreaterThanOrEqualTo:
                                                            functions
                                                                .monthBoundaries(
                                                                    getCurrentTimestamp)
                                                                .firstOrNull,
                                                      )
                                                      .where(
                                                        'occurrenceKey',
                                                        isLessThanOrEqualTo:
                                                            functions
                                                                .monthBoundaries(
                                                                    getCurrentTimestamp)
                                                                .lastOrNull,
                                                      ),
                                            );
                                          }),
                                        ]);
                                        FFAppState().sumExpenses =
                                            functions.sum(_model.expense1!
                                                .map((e) => e.amount)
                                                .toList());
                                        FFAppState().sumIncomes = functions.sum(
                                            _model.incomes1!
                                                .map((e) => e.amount)
                                                .toList());
                                        FFAppState().sumSave = functions.sum(
                                            _model.saves1!
                                                .map((e) => e.amount)
                                                .toList());
                                        safeSetState(() {});
                                      }

                                      safeSetState(() {});
                                    },
                                    () async {
                                      FFAppState().selectedDate =
                                          getCurrentTimestamp;
                                      safeSetState(() {});
                                      _model.selectedDate = functions
                                          .normalizeToCalendarDatedateTime(
                                              getCurrentTimestamp);
                                      safeSetState(() {});
                                    },
                                    () async {
                                      if (valueOrDefault<bool>(
                                              currentUserDocument?.isPremium,
                                              false) ==
                                          true) {
                                        unawaited(
                                          () async {
                                            try {
                                              final result = await FirebaseFunctions
                                                      .instanceFor(
                                                          region: 'us-central1')
                                                  .httpsCallable(
                                                      'goldAdvisorDailyBriefV2')
                                                  .call({
                                                "forceRefresh": false,
                                              });
                                              _model.welcomi =
                                                  GoldAdvisorDailyBriefV2CloudFunctionCallResponse(
                                                succeeded: true,
                                              );
                                            } on FirebaseFunctionsException catch (error) {
                                              _model.welcomi =
                                                  GoldAdvisorDailyBriefV2CloudFunctionCallResponse(
                                                errorCode: error.code,
                                                succeeded: false,
                                              );
                                            }
                                          }(),
                                        );
                                      } else {
                                        await Future.wait([
                                          Future(() async {
                                            _model.incomes2 =
                                                await queryDocumentsRecordOnce(
                                              queryBuilder: (documentsRecord) =>
                                                  documentsRecord
                                                      .where(
                                                        'userRef',
                                                        isEqualTo:
                                                            currentUserReference,
                                                      )
                                                      .where(
                                                        'isIncome',
                                                        isEqualTo: true,
                                                      )
                                                      .where(
                                                        'occurrenceKey',
                                                        isGreaterThanOrEqualTo:
                                                            functions
                                                                .monthBoundaries(
                                                                    getCurrentTimestamp)
                                                                .firstOrNull,
                                                      )
                                                      .where(
                                                        'occurrenceKey',
                                                        isLessThanOrEqualTo:
                                                            functions
                                                                .monthBoundaries(
                                                                    getCurrentTimestamp)
                                                                .lastOrNull,
                                                      ),
                                            );
                                          }),
                                          Future(() async {
                                            _model.expense2 =
                                                await queryDocumentsRecordOnce(
                                              queryBuilder: (documentsRecord) =>
                                                  documentsRecord
                                                      .where(
                                                        'userRef',
                                                        isEqualTo:
                                                            currentUserReference,
                                                      )
                                                      .where(
                                                        'isExpenses',
                                                        isEqualTo: true,
                                                      )
                                                      .where(
                                                        'occurrenceKey',
                                                        isGreaterThanOrEqualTo:
                                                            functions
                                                                .monthBoundaries(
                                                                    getCurrentTimestamp)
                                                                .firstOrNull,
                                                      )
                                                      .where(
                                                        'occurrenceKey',
                                                        isLessThanOrEqualTo:
                                                            functions
                                                                .monthBoundaries(
                                                                    getCurrentTimestamp)
                                                                .lastOrNull,
                                                      ),
                                            );
                                          }),
                                          Future(() async {
                                            _model.saves2 =
                                                await queryDocumentsRecordOnce(
                                              queryBuilder: (documentsRecord) =>
                                                  documentsRecord
                                                      .where(
                                                        'userRef',
                                                        isEqualTo:
                                                            currentUserReference,
                                                      )
                                                      .where(
                                                        'isSave',
                                                        isEqualTo: true,
                                                      )
                                                      .where(
                                                        'occurrenceKey',
                                                        isGreaterThanOrEqualTo:
                                                            functions
                                                                .monthBoundaries(
                                                                    getCurrentTimestamp)
                                                                .firstOrNull,
                                                      )
                                                      .where(
                                                        'occurrenceKey',
                                                        isLessThanOrEqualTo:
                                                            functions
                                                                .monthBoundaries(
                                                                    getCurrentTimestamp)
                                                                .lastOrNull,
                                                      ),
                                            );
                                          }),
                                        ]);
                                        FFAppState().sumExpenses =
                                            functions.sum(_model.expense2!
                                                .map((e) => e.amount)
                                                .toList());
                                        FFAppState().sumIncomes = functions.sum(
                                            _model.incomes2!
                                                .map((e) => e.amount)
                                                .toList());
                                        FFAppState().sumSave = functions.sum(
                                            _model.saves2!
                                                .map((e) => e.amount)
                                                .toList());
                                        safeSetState(() {});
                                      }

                                      safeSetState(() {});
                                    },
                                    () async {},
                                    () async {
                                      _model.accounts =
                                          await queryBankAccountsRecordOnce(
                                        queryBuilder: (bankAccountsRecord) =>
                                            bankAccountsRecord.where(
                                          'userRef',
                                          isEqualTo: currentUserReference,
                                        ),
                                      );

                                      safeSetState(() {});
                                    }
                                  ][i]();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ].divide(SizedBox(height: 0.0)),
                ),
              if (FFAppState().isBlokedHome == true)
                Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            32.0, 19.0, 32.0, 32.0),
                        child: Container(
                          width: double.infinity,
                          height: 132.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'ai592cl4' /* Gold Up  */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.roboto(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          color: Color(0xFFFBD770),
                                          fontSize: 48.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 0.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            't6frxoek' /* Tienes el potencial necesario ... */,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 5,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    fontSize: 19.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ),
                    ]
                        .divide(SizedBox(height: 10.0))
                        .addToStart(SizedBox(height: 20.0))
                        .addToEnd(SizedBox(height: 20.0)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
