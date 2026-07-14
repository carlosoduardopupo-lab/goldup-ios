import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/recurren_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
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
                                      await currentUserReference!.update({
                                        ...createUserRecordData(
                                          isTransactionsVerificated: true,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'lastTransactionsVerifiedAt':
                                                FieldValue.serverTimestamp(),
                                          },
                                        ),
                                      });

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
                        limit: 1,
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

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewDocumentsRecordList.length,
                          itemBuilder: (context, listViewIndex) {
                            final listViewDocumentsRecord =
                                listViewDocumentsRecordList[listViewIndex];
                            return Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: wrapWithModel(
                                model: _model.recurrenCardModels.getModel(
                                  listViewDocumentsRecord.reference.id,
                                  listViewIndex,
                                ),
                                updateCallback: () => safeSetState(() {}),
                                child: RecurrenCardWidget(
                                  key: Key(
                                    'Keyeut_${listViewDocumentsRecord.reference.id}',
                                  ),
                                  docTransact: listViewDocumentsRecord,
                                ),
                              ),
                            );
                          },
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
                    .addToEnd(SizedBox(height: 40.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
