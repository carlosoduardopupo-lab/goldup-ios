import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'recurrentes_model.dart';
export 'recurrentes_model.dart';

class RecurrentesWidget extends StatefulWidget {
  const RecurrentesWidget({super.key});

  static String routeName = 'recurrentes';
  static String routePath = '/recurrentes';

  @override
  State<RecurrentesWidget> createState() => _RecurrentesWidgetState();
}

class _RecurrentesWidgetState extends State<RecurrentesWidget> {
  late RecurrentesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RecurrentesModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.falseb = false;
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color(0x1F71F9F1),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.exclamationTriangle,
                    color: Color(0xFFF4A403),
                    size: 39.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'pht9htaz' /* Posibles transacciones recurre... */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.roboto(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              fontSize: 19.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    child: Container(
                      decoration: BoxDecoration(),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 18.0, 0.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        '1gqo5yd2' /* Para un correcto funcionamient... */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.roboto(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ),
                  StreamBuilder<List<DocumentsRecord>>(
                    stream: queryDocumentsRecord(
                      queryBuilder: (documentsRecord) => documentsRecord
                          .where(
                            'userRef',
                            isEqualTo: currentUserReference,
                          )
                          .where(
                            'isRecurrent',
                            isEqualTo: false,
                          )
                          .where(
                            'isInternalTransfer',
                            isEqualTo: false,
                          )
                          .where(
                            'occurrenceKey',
                            isGreaterThanOrEqualTo: functions
                                .last30DaysOccurrenceKey(getCurrentTimestamp)
                                ?.firstOrNull,
                          )
                          .where(
                            'occurrenceKey',
                            isLessThanOrEqualTo: functions
                                .last30DaysOccurrenceKey(getCurrentTimestamp)
                                ?.lastOrNull,
                          )
                          .where(
                            'isPending',
                            isEqualTo: false,
                          )
                          .where(
                            'isConfirmed',
                            isEqualTo: false,
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
                      List<DocumentsRecord> containerDocumentsRecordList =
                          snapshot.data!;

                      return Container(
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if ((containerDocumentsRecordList.isNotEmpty) ==
                                  true)
                                RichText(
                                  textScaler: MediaQuery.of(context).textScaler,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            FFLocalizations.of(context).getText(
                                          '63s7hts2' /* Gold Up ha detectado  */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.roboto(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                      TextSpan(
                                        text: valueOrDefault<String>(
                                          containerDocumentsRecordList.length
                                              .toString(),
                                          '0',
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
                                              fontSize: 21.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                      TextSpan(
                                        text:
                                            FFLocalizations.of(context).getText(
                                          'bqkf8ne0' /*  posibles transacciones recurr... */,
                                        ),
                                        style: TextStyle(),
                                      )
                                    ],
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.roboto(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                  maxLines: 3,
                                ),
                              if ((containerDocumentsRecordList.isNotEmpty) ==
                                  false)
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'fofxn4xs' /* "¡Todo al día! No hay transacc... */,
                                  ),
                                  maxLines: 3,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        fontSize: 19.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              if ((containerDocumentsRecordList.isNotEmpty) ==
                                  false)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      await currentUserReference!
                                          .update(createUserRecordData(
                                        isTransactionsVerificated: true,
                                      ));

                                      context.pushNamed(HomeWidget.routeName);

                                      await requestPermission(
                                          notificationsPermission);
                                    },
                                    text: FFLocalizations.of(context).getText(
                                      'vmlpih64' /* Aceptar */,
                                    ),
                                    options: FFButtonOptions(
                                      height: 50.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: Color(0xFF01654D),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            font: GoogleFonts.roboto(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                      elevation: 0.0,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                            ].divide(SizedBox(height: 10.0)),
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                    child: StreamBuilder<List<DocumentsRecord>>(
                      stream: queryDocumentsRecord(
                        queryBuilder: (documentsRecord) => documentsRecord
                            .where(
                              'userRef',
                              isEqualTo: currentUserReference,
                            )
                            .where(
                              'isRecurrent',
                              isEqualTo: false,
                            )
                            .where(
                              'isInternalTransfer',
                              isEqualTo: false,
                            )
                            .where(
                              'isPending',
                              isEqualTo: false,
                            )
                            .where(
                              'isConfirmed',
                              isEqualTo: false,
                            )
                            .where(
                              'occurrenceKey',
                              isGreaterThanOrEqualTo: functions
                                  .last30DaysOccurrenceKey(getCurrentTimestamp)
                                  ?.firstOrNull,
                            )
                            .where(
                              'occurrenceKey',
                              isLessThanOrEqualTo: functions
                                  .last30DaysOccurrenceKey(getCurrentTimestamp)
                                  ?.lastOrNull,
                            )
                            .orderBy('occurrenceKey'),
                        singleRecord: true,
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
                        List<DocumentsRecord> listViewDocumentsRecordList =
                            snapshot.data!;
                        // Return an empty Container when the item does not exist.
                        if (snapshot.data!.isEmpty) {
                          return Container();
                        }
                        final listViewDocumentsRecord =
                            listViewDocumentsRecordList.isNotEmpty
                                ? listViewDocumentsRecordList.first
                                : null;

                        return ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 10.0, 0.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
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
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 24.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 224.07,
                                          decoration: BoxDecoration(),
                                          child: Stack(
                                            children: [
                                              Opacity(
                                                opacity: 0.6,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.network(
                                                    () {
                                                      if (listViewDocumentsRecord
                                                              ?.isIncome ==
                                                          true) {
                                                        return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/calendar-ten2s9/assets/xm9lw0eysdgi/Copilot_20260126_230246.png';
                                                      } else if (listViewDocumentsRecord
                                                              ?.isExpenses ==
                                                          true) {
                                                        return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/calendar-ten2s9/assets/sh0f79asn46p/Copilot_20260126_230924.png';
                                                      } else if (listViewDocumentsRecord
                                                              ?.isSave ==
                                                          true) {
                                                        return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/calendar-ten2s9/assets/wehgeiteiicx/Copilot_20260211_232303.png';
                                                      } else if (listViewDocumentsRecord
                                                              ?.isEvent ==
                                                          true) {
                                                        return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/calendar-ten2s9/assets/f1p8o9zble5y/Copilot_20260129_212450.png';
                                                      } else {
                                                        return '';
                                                      }
                                                    }(),
                                                    width: double.infinity,
                                                    fit: BoxFit.fitWidth,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 10.0, 0.0, 10.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, -0.65),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    20.0,
                                                                    0.0,
                                                                    16.0,
                                                                    0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Flexible(
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          10.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        dateTimeFormat(
                                                                          "MMMMEEEEd",
                                                                          functions
                                                                              .stringToDateTime(listViewDocumentsRecord?.date),
                                                                          locale:
                                                                              FFLocalizations.of(context).languageCode,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
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
                                                                  ),
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child:
                                                                        Visibility(
                                                                      visible: listViewDocumentsRecord?.type !=
                                                                              null &&
                                                                          listViewDocumentsRecord?.type !=
                                                                              '',
                                                                      child:
                                                                          Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            listViewDocumentsRecord?.type,
                                                                            'type',
                                                                          ),
                                                                          maxLines:
                                                                              3,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.roboto(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                fontSize: 16.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                if (listViewDocumentsRecord
                                                                            ?.accountName !=
                                                                        null &&
                                                                    listViewDocumentsRecord
                                                                            ?.accountName !=
                                                                        '')
                                                                  Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      listViewDocumentsRecord
                                                                          ?.accountName,
                                                                      'accountName',
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
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          1.0,
                                                                          0.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      if (listViewDocumentsRecord?.institutionName !=
                                                                              null &&
                                                                          listViewDocumentsRecord?.institutionName !=
                                                                              '')
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              1.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            valueOrDefault<String>(
                                                                              listViewDocumentsRecord?.institutionName,
                                                                              'institutionName',
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
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ].divide(SizedBox(
                                                              width: 15.0)),
                                                        ),
                                                      ),
                                                    ),
                                                    if (listViewDocumentsRecord!
                                                            .amount >
                                                        0.0)
                                                      Text(
                                                        valueOrDefault<String>(
                                                          formatNumber(
                                                            listViewDocumentsRecord
                                                                ?.amount,
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
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  fontSize:
                                                                      20.0,
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
                                                    if (listViewDocumentsRecord
                                                                ?.description !=
                                                            null &&
                                                        listViewDocumentsRecord
                                                                ?.description !=
                                                            '')
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    20.0,
                                                                    10.0,
                                                                    20.0,
                                                                    10.0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            listViewDocumentsRecord
                                                                ?.description,
                                                            'description',
                                                          ),
                                                          maxLines: 10,
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
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
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
                                                                  20.0,
                                                                  0.0,
                                                                  16.0,
                                                                  10.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(),
                                                      ),
                                                    ),
                                                    if (listViewDocumentsRecord
                                                            ?.source ==
                                                        'plaid')
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      20.0,
                                                                      0.0,
                                                                      16.0,
                                                                      0.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        -1.0,
                                                                        0.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                      child:
                                                                          Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          '0m7a2wn1' /* Categoría */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyLarge
                                                                            .override(
                                                                              font: GoogleFonts.roboto(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                              ),
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        -1.0,
                                                                        0.0),
                                                                child: Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    listViewDocumentsRecord
                                                                        ?.personalFinanceCategoryPrimary,
                                                                    'personalFinanceCategoryPrimary',
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .roboto(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyLarge
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyLarge
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        fontSize:
                                                                            14.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyLarge
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyLarge
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      if (listViewDocumentsRecord?.merchantName !=
                                                                              null &&
                                                                          listViewDocumentsRecord?.merchantName !=
                                                                              '')
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            FFLocalizations.of(context).getText(
                                                                              'wi4cp3vv' /* Información del Comercio */,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                  font: GoogleFonts.roboto(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                  ),
                                                                                  fontSize: 14.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                  if (listViewDocumentsRecord
                                                                              ?.merchantName !=
                                                                          null &&
                                                                      listViewDocumentsRecord
                                                                              ?.merchantName !=
                                                                          '')
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(),
                                                                        child:
                                                                            RichText(
                                                                          textScaler:
                                                                              MediaQuery.of(context).textScaler,
                                                                          text:
                                                                              TextSpan(
                                                                            children: [
                                                                              TextSpan(
                                                                                text: FFLocalizations.of(context).getText(
                                                                                  'v5qdvix3' /* Nombre:  */,
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.roboto(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                              TextSpan(
                                                                                text: valueOrDefault<String>(
                                                                                  listViewDocumentsRecord?.merchantName,
                                                                                  'merchantName',
                                                                                ),
                                                                                style: TextStyle(),
                                                                              )
                                                                            ],
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
                                                                      ),
                                                                    ),
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          432.7,
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                    ),
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
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 0.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Theme(
                                                data: ThemeData(
                                                  checkboxTheme:
                                                      CheckboxThemeData(
                                                    visualDensity:
                                                        VisualDensity.compact,
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.0),
                                                    ),
                                                  ),
                                                  unselectedWidgetColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                ),
                                                child: Checkbox(
                                                  value: _model
                                                      .checkboxValue ??= false,
                                                  onChanged: (newValue) async {
                                                    safeSetState(() =>
                                                        _model.checkboxValue =
                                                            newValue!);
                                                  },
                                                  side: (FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText !=
                                                          null)
                                                      ? BorderSide(
                                                          width: 2,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText!,
                                                        )
                                                      : null,
                                                  activeColor:
                                                      Color(0xFF01654D),
                                                  checkColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryBackground,
                                                ),
                                              ),
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'w49hu4ov' /* Gasto recurrente */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (_model.checkboxValue == true)
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 19.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(20.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '8jqbfb7k' /* Frecuencia */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
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
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          20.0, 0.0, 20.0, 0.0),
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 50.0,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
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
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                      ),
                                                    ),
                                                    child: FlutterFlowDropDown<
                                                        String>(
                                                      controller: _model
                                                              .dropDownValueController ??=
                                                          FormFieldController<
                                                              String>(null),
                                                      options: [
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'e5tp9d56' /* Diario */,
                                                        ),
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          '6oz1a3rg' /* Semanal */,
                                                        ),
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          '4ct1vl0j' /* Quincenal */,
                                                        ),
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          '42331a6g' /* Mensual */,
                                                        ),
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'pzbcpge4' /* Trimestral */,
                                                        ),
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          '82gd3upk' /* Anual */,
                                                        )
                                                      ],
                                                      onChanged: (val) =>
                                                          safeSetState(() =>
                                                              _model.dropDownValue =
                                                                  val),
                                                      width: 200.0,
                                                      height: 40.0,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
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
                                                      hintText:
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                        'lry1f470' /* Seleccionar... */,
                                                      ),
                                                      icon: Icon(
                                                        Icons
                                                            .keyboard_arrow_down_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        size: 24.0,
                                                      ),
                                                      fillColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                      elevation: 2.0,
                                                      borderColor:
                                                          Colors.transparent,
                                                      borderWidth: 0.0,
                                                      borderRadius: 8.0,
                                                      margin:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  12.0,
                                                                  0.0,
                                                                  12.0,
                                                                  0.0),
                                                      hidesUnderline: true,
                                                      isOverButton: false,
                                                      isSearchable: false,
                                                      isMultiSelect: false,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 10.0),
                                          child: ListView(
                                            padding: EdgeInsets.zero,
                                            primary: false,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                child: FFButtonWidget(
                                                  onPressed: (_model
                                                                  .dropDownValue ==
                                                              null ||
                                                          _model.dropDownValue ==
                                                              '')
                                                      ? null
                                                      : () async {
                                                          if (_model
                                                                  .checkboxValue ==
                                                              true) {
                                                            await listViewDocumentsRecord!
                                                                .reference
                                                                .update({
                                                              ...createDocumentsRecordData(
                                                                recurrenceId:
                                                                    listViewDocumentsRecord
                                                                        ?.reference
                                                                        .id,
                                                                isRecurrent:
                                                                    true,
                                                                frequencyCode:
                                                                    () {
                                                                  if ((_model.dropDownValue ==
                                                                          'Diario') ||
                                                                      (_model.dropDownValue ==
                                                                          'Daily')) {
                                                                    return 1;
                                                                  } else if ((_model
                                                                              .dropDownValue ==
                                                                          'Semanal') ||
                                                                      (_model.dropDownValue ==
                                                                          'Weekly')) {
                                                                    return 7;
                                                                  } else if ((_model
                                                                              .dropDownValue ==
                                                                          'Quincenal') ||
                                                                      (_model.dropDownValue ==
                                                                          'Biweekly')) {
                                                                    return 14;
                                                                  } else if ((_model
                                                                              .dropDownValue ==
                                                                          'Mensual') ||
                                                                      (_model.dropDownValue ==
                                                                          'Monthly')) {
                                                                    return 1001;
                                                                  } else if ((_model
                                                                              .dropDownValue ==
                                                                          'Trimestral') ||
                                                                      (_model.dropDownValue ==
                                                                          'Quarterly')) {
                                                                    return 1003;
                                                                  } else if ((_model
                                                                              .dropDownValue ==
                                                                          'Anual') ||
                                                                      (_model.dropDownValue ==
                                                                          ' Annual')) {
                                                                    return 1012;
                                                                  } else {
                                                                    return 0;
                                                                  }
                                                                }(),
                                                                frequency: _model
                                                                    .dropDownValue,
                                                                isConfirmed:
                                                                    true,
                                                              ),
                                                              ...mapToFirestore(
                                                                {
                                                                  'updatedAt':
                                                                      FieldValue
                                                                          .serverTimestamp(),
                                                                },
                                                              ),
                                                            });
                                                            for (int loop1Index =
                                                                    0;
                                                                loop1Index <
                                                                    functions.generateRecurrenceDatesByCode(
                                                                        listViewDocumentsRecord!
                                                                            .date,
                                                                        () {
                                                                      if (_model
                                                                              .dropDownValue ==
                                                                          'Diario') {
                                                                        return 1;
                                                                      } else if (_model
                                                                              .dropDownValue ==
                                                                          'Semanal') {
                                                                        return 7;
                                                                      } else if (_model
                                                                              .dropDownValue ==
                                                                          'Quincenal') {
                                                                        return 14;
                                                                      } else if (_model
                                                                              .dropDownValue ==
                                                                          'Mensual') {
                                                                        return 1001;
                                                                      } else if (_model
                                                                              .dropDownValue ==
                                                                          'Trimestral') {
                                                                        return 1003;
                                                                      } else if (_model
                                                                              .dropDownValue ==
                                                                          'Anual') {
                                                                        return 1012;
                                                                      } else {
                                                                        return 0;
                                                                      }
                                                                    }(),
                                                                        false).length;
                                                                loop1Index++) {
                                                              final currentLoop1Item =
                                                                  functions.generateRecurrenceDatesByCode(
                                                                      listViewDocumentsRecord!
                                                                          .date,
                                                                      () {
                                                                if (_model
                                                                        .dropDownValue ==
                                                                    'Diario') {
                                                                  return 1;
                                                                } else if (_model
                                                                        .dropDownValue ==
                                                                    'Semanal') {
                                                                  return 7;
                                                                } else if (_model
                                                                        .dropDownValue ==
                                                                    'Quincenal') {
                                                                  return 14;
                                                                } else if (_model
                                                                        .dropDownValue ==
                                                                    'Mensual') {
                                                                  return 1001;
                                                                } else if (_model
                                                                        .dropDownValue ==
                                                                    'Trimestral') {
                                                                  return 1003;
                                                                } else if (_model
                                                                        .dropDownValue ==
                                                                    'Anual') {
                                                                  return 1012;
                                                                } else {
                                                                  return 0;
                                                                }
                                                              }(), false)[loop1Index];

                                                              var documentsRecordReference =
                                                                  DocumentsRecord
                                                                      .collection
                                                                      .doc();
                                                              await documentsRecordReference
                                                                  .set({
                                                                ...createDocumentsRecordData(
                                                                  type:
                                                                      listViewDocumentsRecord
                                                                          ?.type,
                                                                  description:
                                                                      listViewDocumentsRecord
                                                                          ?.description,
                                                                  date:
                                                                      currentLoop1Item,
                                                                  amount:
                                                                      listViewDocumentsRecord
                                                                          ?.amount,
                                                                  isRecurrent:
                                                                      true,
                                                                  frequency: _model
                                                                      .dropDownValue,
                                                                  userRef:
                                                                      currentUserReference,
                                                                  frequencyCode:
                                                                      () {
                                                                    if (_model
                                                                            .dropDownValue ==
                                                                        'Diario') {
                                                                      return 1;
                                                                    } else if (_model
                                                                            .dropDownValue ==
                                                                        'Semanal') {
                                                                      return 7;
                                                                    } else if (_model
                                                                            .dropDownValue ==
                                                                        'Quincenal') {
                                                                      return 14;
                                                                    } else if (_model
                                                                            .dropDownValue ==
                                                                        'Mensual') {
                                                                      return 1001;
                                                                    } else if (_model
                                                                            .dropDownValue ==
                                                                        'Trimestral') {
                                                                      return 1003;
                                                                    } else if (_model
                                                                            .dropDownValue ==
                                                                        'Anual') {
                                                                      return 1012;
                                                                    } else {
                                                                      return 0;
                                                                    }
                                                                  }(),
                                                                  recurrenceId:
                                                                      listViewDocumentsRecord
                                                                          ?.reference
                                                                          .id,
                                                                  occurrenceKey:
                                                                      functions
                                                                          .dateToOccurrenceKey(
                                                                              currentLoop1Item),
                                                                  notificationAt:
                                                                      72,
                                                                  isExpenses:
                                                                      listViewDocumentsRecord
                                                                          ?.isExpenses,
                                                                  isIncome:
                                                                      listViewDocumentsRecord
                                                                          ?.isIncome,
                                                                  isSave:
                                                                      listViewDocumentsRecord
                                                                          ?.isSave,
                                                                  isEvent:
                                                                      listViewDocumentsRecord
                                                                          ?.isEvent,
                                                                  source:
                                                                      listViewDocumentsRecord
                                                                          ?.source,
                                                                  isGoal:
                                                                      listViewDocumentsRecord
                                                                          ?.isGoal,
                                                                  isNotificationScheduledSent:
                                                                      false,
                                                                  isNotificationTodaySent:
                                                                      false,
                                                                  isInternalTransfer:
                                                                      listViewDocumentsRecord
                                                                          ?.isInternalTransfer,
                                                                  createdAt:
                                                                      getCurrentTimestamp,
                                                                  isPending:
                                                                      true,
                                                                  isOtherExpenses:
                                                                      listViewDocumentsRecord
                                                                          ?.isOtherExpenses,
                                                                  isoCurrencyCode:
                                                                      listViewDocumentsRecord
                                                                          ?.isoCurrencyCode,
                                                                  personalFinanceCategoryPrimary:
                                                                      listViewDocumentsRecord
                                                                          ?.personalFinanceCategoryPrimary,
                                                                  personalFinanceCategoryDetailed:
                                                                      listViewDocumentsRecord
                                                                          ?.personalFinanceCategoryDetailed,
                                                                  subtype:
                                                                      listViewDocumentsRecord
                                                                          ?.subtype,
                                                                  merchantName:
                                                                      listViewDocumentsRecord
                                                                          ?.merchantName,
                                                                  merchantId:
                                                                      listViewDocumentsRecord
                                                                          ?.merchantId,
                                                                  merchantWebsite:
                                                                      listViewDocumentsRecord
                                                                          ?.merchantWebsite,
                                                                  merchantLogo:
                                                                      listViewDocumentsRecord
                                                                          ?.merchantLogo,
                                                                  goaldName:
                                                                      listViewDocumentsRecord
                                                                          ?.goaldName,
                                                                  accountName:
                                                                      listViewDocumentsRecord
                                                                          ?.accountName,
                                                                  institutionName:
                                                                      listViewDocumentsRecord
                                                                          ?.institutionName,
                                                                  isConfirmed:
                                                                      true,
                                                                  plaidAccountId:
                                                                      listViewDocumentsRecord
                                                                          ?.plaidAccountId,
                                                                ),
                                                                ...mapToFirestore(
                                                                  {
                                                                    'updatedAt':
                                                                        FieldValue
                                                                            .serverTimestamp(),
                                                                  },
                                                                ),
                                                              });
                                                              _model.recurrente2 =
                                                                  DocumentsRecord
                                                                      .getDocumentFromData({
                                                                ...createDocumentsRecordData(
                                                                  type:
                                                                      listViewDocumentsRecord
                                                                          ?.type,
                                                                  description:
                                                                      listViewDocumentsRecord
                                                                          ?.description,
                                                                  date:
                                                                      currentLoop1Item,
                                                                  amount:
                                                                      listViewDocumentsRecord
                                                                          ?.amount,
                                                                  isRecurrent:
                                                                      true,
                                                                  frequency: _model
                                                                      .dropDownValue,
                                                                  userRef:
                                                                      currentUserReference,
                                                                  frequencyCode:
                                                                      () {
                                                                    if (_model
                                                                            .dropDownValue ==
                                                                        'Diario') {
                                                                      return 1;
                                                                    } else if (_model
                                                                            .dropDownValue ==
                                                                        'Semanal') {
                                                                      return 7;
                                                                    } else if (_model
                                                                            .dropDownValue ==
                                                                        'Quincenal') {
                                                                      return 14;
                                                                    } else if (_model
                                                                            .dropDownValue ==
                                                                        'Mensual') {
                                                                      return 1001;
                                                                    } else if (_model
                                                                            .dropDownValue ==
                                                                        'Trimestral') {
                                                                      return 1003;
                                                                    } else if (_model
                                                                            .dropDownValue ==
                                                                        'Anual') {
                                                                      return 1012;
                                                                    } else {
                                                                      return 0;
                                                                    }
                                                                  }(),
                                                                  recurrenceId:
                                                                      listViewDocumentsRecord
                                                                          ?.reference
                                                                          .id,
                                                                  occurrenceKey:
                                                                      functions
                                                                          .dateToOccurrenceKey(
                                                                              currentLoop1Item),
                                                                  notificationAt:
                                                                      72,
                                                                  isExpenses:
                                                                      listViewDocumentsRecord
                                                                          ?.isExpenses,
                                                                  isIncome:
                                                                      listViewDocumentsRecord
                                                                          ?.isIncome,
                                                                  isSave:
                                                                      listViewDocumentsRecord
                                                                          ?.isSave,
                                                                  isEvent:
                                                                      listViewDocumentsRecord
                                                                          ?.isEvent,
                                                                  source:
                                                                      listViewDocumentsRecord
                                                                          ?.source,
                                                                  isGoal:
                                                                      listViewDocumentsRecord
                                                                          ?.isGoal,
                                                                  isNotificationScheduledSent:
                                                                      false,
                                                                  isNotificationTodaySent:
                                                                      false,
                                                                  isInternalTransfer:
                                                                      listViewDocumentsRecord
                                                                          ?.isInternalTransfer,
                                                                  createdAt:
                                                                      getCurrentTimestamp,
                                                                  isPending:
                                                                      true,
                                                                  isOtherExpenses:
                                                                      listViewDocumentsRecord
                                                                          ?.isOtherExpenses,
                                                                  isoCurrencyCode:
                                                                      listViewDocumentsRecord
                                                                          ?.isoCurrencyCode,
                                                                  personalFinanceCategoryPrimary:
                                                                      listViewDocumentsRecord
                                                                          ?.personalFinanceCategoryPrimary,
                                                                  personalFinanceCategoryDetailed:
                                                                      listViewDocumentsRecord
                                                                          ?.personalFinanceCategoryDetailed,
                                                                  subtype:
                                                                      listViewDocumentsRecord
                                                                          ?.subtype,
                                                                  merchantName:
                                                                      listViewDocumentsRecord
                                                                          ?.merchantName,
                                                                  merchantId:
                                                                      listViewDocumentsRecord
                                                                          ?.merchantId,
                                                                  merchantWebsite:
                                                                      listViewDocumentsRecord
                                                                          ?.merchantWebsite,
                                                                  merchantLogo:
                                                                      listViewDocumentsRecord
                                                                          ?.merchantLogo,
                                                                  goaldName:
                                                                      listViewDocumentsRecord
                                                                          ?.goaldName,
                                                                  accountName:
                                                                      listViewDocumentsRecord
                                                                          ?.accountName,
                                                                  institutionName:
                                                                      listViewDocumentsRecord
                                                                          ?.institutionName,
                                                                  isConfirmed:
                                                                      true,
                                                                  plaidAccountId:
                                                                      listViewDocumentsRecord
                                                                          ?.plaidAccountId,
                                                                ),
                                                                ...mapToFirestore(
                                                                  {
                                                                    'updatedAt':
                                                                        DateTime
                                                                            .now(),
                                                                  },
                                                                ),
                                                              }, documentsRecordReference);
                                                            }
                                                          } else {
                                                            await listViewDocumentsRecord!
                                                                .reference
                                                                .update(
                                                                    createDocumentsRecordData(
                                                              isConfirmed: true,
                                                            ));
                                                          }

                                                          await currentUserReference!
                                                              .update(
                                                                  createUserRecordData(
                                                            isDocumentCreated:
                                                                true,
                                                            isExpensesCreated:
                                                                true,
                                                          ));

                                                          safeSetState(() {});
                                                        },
                                                  text: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    '8dl1c91w' /* Aceptar */,
                                                  ),
                                                  options: FFButtonOptions(
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
                                                    disabledColor:
                                                        Color(0xFF0AE8B3),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
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
                                                  ),
                                                  child: FFButtonWidget(
                                                    onPressed:
                                                        (_model.checkboxValue ==
                                                                true)
                                                            ? null
                                                            : () async {
                                                                await listViewDocumentsRecord!
                                                                    .reference
                                                                    .update(
                                                                        createDocumentsRecordData(
                                                                  isConfirmed:
                                                                      true,
                                                                ));
                                                              },
                                                    text: FFLocalizations.of(
                                                            context)
                                                        .getText(
                                                      'bi29tn6n' /* Omitir */,
                                                    ),
                                                    options: FFButtonOptions(
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
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
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
                                                                color: FlutterFlowTheme.of(
                                                                        context)
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
                                                          BorderRadius.circular(
                                                              8.0),
                                                      disabledColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                      hoverBorderSide:
                                                          BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                      ),
                                                      hoverElevation: 3.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 10.0)),
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 10.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(),
                  ),
                ]
                    .divide(SizedBox(height: 10.0))
                    .addToStart(SizedBox(height: 40.0))
                    .addToEnd(SizedBox(height: 20.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
