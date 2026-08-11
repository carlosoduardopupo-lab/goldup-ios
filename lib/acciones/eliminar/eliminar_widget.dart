import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'eliminar_model.dart';
export 'eliminar_model.dart';

class EliminarWidget extends StatefulWidget {
  const EliminarWidget({
    super.key,
    required this.recurrenceID,
    required this.docRef,
    required this.isRecurrent,
    this.docum,
  });

  final String? recurrenceID;
  final DocumentReference? docRef;
  final bool? isRecurrent;
  final DocumentsRecord? docum;

  @override
  State<EliminarWidget> createState() => _EliminarWidgetState();
}

class _EliminarWidgetState extends State<EliminarWidget> {
  late EliminarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EliminarModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (valueOrDefault<bool>(currentUserDocument?.isPremium, false) ==
          false) {
        _model.check = true;
        safeSetState(() {});
      } else {
        _model.check = widget!.isRecurrent!;
        safeSetState(() {});
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
              child: Container(
                width: 50.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: Color(0xFFF1F4F8),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    FFLocalizations.of(context).getText(
                      '311n6bnj' /* ¿Deseas eliminar este evento? */,
                    ),
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          font: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primary,
                          fontSize: 24.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .fontStyle,
                        ),
                  ),
                ],
              ),
            ),
            if (widget!.isRecurrent == true)
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AuthUserStreamWidget(
                      builder: (context) => Theme(
                        data: ThemeData(
                          checkboxTheme: CheckboxThemeData(
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          unselectedWidgetColor:
                              FlutterFlowTheme.of(context).alternate,
                        ),
                        child: Checkbox(
                          value: _model.checkboxValue ??= widget!.isRecurrent!,
                          onChanged: (valueOrDefault<bool>(
                                      currentUserDocument?.isPremium, false) ==
                                  false)
                              ? null
                              : (newValue) async {
                                  safeSetState(
                                      () => _model.checkboxValue = newValue!);
                                  if (newValue!) {
                                    _model.check = true;
                                    safeSetState(() {});
                                  } else {
                                    _model.check = false;
                                    safeSetState(() {});
                                  }
                                },
                          side: (FlutterFlowTheme.of(context).alternate != null)
                              ? BorderSide(
                                  width: 2,
                                  color:
                                      FlutterFlowTheme.of(context).alternate!,
                                )
                              : null,
                          activeColor: Color(0xFF01654D),
                          checkColor: (valueOrDefault<bool>(
                                      currentUserDocument?.isPremium, false) ==
                                  false)
                              ? null
                              : FlutterFlowTheme.of(context).primaryBackground,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Align(
                        alignment: AlignmentDirectional(-1.0, 0.0),
                        child: Container(
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 16.0, 0.0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'j1jirkqa' /* Eliminar también eventos recur... */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
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
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ListView(
              padding: EdgeInsets.fromLTRB(
                0,
                0,
                0,
                40.0,
              ),
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
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
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 2.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 12.0, 8.0, 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  'cw6gcryb' /* Cancelar Acción */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontStyle,
                                      ),
                                      color: Color(0xFF14181B),
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      if (valueOrDefault<bool>(
                              currentUserDocument?.isPremium, false) ==
                          true) {
                        if (_model.checkboxValue == true) {
                          _model.document = await queryDocumentsRecordOnce(
                            queryBuilder: (documentsRecord) => documentsRecord
                                .where(
                                  'recurrenceId',
                                  isEqualTo: widget!.recurrenceID,
                                )
                                .where(
                                  'isRealTransaction',
                                  isEqualTo: false,
                                )
                                .where(
                                  'userRef',
                                  isEqualTo: currentUserReference,
                                ),
                          );
                          for (int loop1Index = 0;
                              loop1Index < _model.document!.length;
                              loop1Index++) {
                            final currentLoop1Item =
                                _model.document![loop1Index];
                            await currentLoop1Item.reference.delete();
                          }
                          _model.document1 = await queryDocumentsRecordOnce(
                            queryBuilder: (documentsRecord) => documentsRecord
                                .where(
                                  'recurrenceId',
                                  isEqualTo: widget!.recurrenceID,
                                )
                                .where(
                                  'isRealTransaction',
                                  isEqualTo: true,
                                )
                                .where(
                                  'userRef',
                                  isEqualTo: currentUserReference,
                                ),
                            singleRecord: true,
                          ).then((s) => s.firstOrNull);

                          await _model.document1!.reference.update({
                            ...createDocumentsRecordData(
                              isRecurrent: false,
                            ),
                            ...mapToFirestore(
                              {
                                'frequency': FieldValue.delete(),
                                'frequencyCode': FieldValue.delete(),
                                'updatedAt': FieldValue.serverTimestamp(),
                                'recurrenceId': FieldValue.delete(),
                              },
                            ),
                          });
                        } else {
                          _model.doc = await DocumentsRecord.getDocumentOnce(
                              widget!.docRef!);
                          if (_model.doc?.isRealTransaction == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'No se puede eliminar este documento. La transacción es real.',
                                  style: TextStyle(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                  ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor:
                                    FlutterFlowTheme.of(context).secondary,
                              ),
                            );
                          } else {
                            await widget!.docRef!.delete();
                          }
                        }
                      } else {
                        if (_model.checkboxValue == true) {
                          _model.docume = await queryDocumentsRecordOnce(
                            queryBuilder: (documentsRecord) => documentsRecord
                                .where(
                                  'recurrenceId',
                                  isEqualTo: widget!.docum?.recurrenceId,
                                )
                                .where(
                                  'userRef',
                                  isEqualTo: currentUserReference,
                                ),
                          );
                          for (int loop2Index = 0;
                              loop2Index < _model.docume!.length;
                              loop2Index++) {
                            final currentLoop2Item = _model.docume![loop2Index];
                            await currentLoop2Item.reference.delete();
                          }
                        } else {
                          await widget!.docRef!.delete();
                        }
                      }

                      Navigator.pop(context);

                      safeSetState(() {});
                    },
                    text: FFLocalizations.of(context).getText(
                      'jsf6kq6a' /* Eliminar Evento */,
                    ),
                    options: FFButtonOptions(
                      height: 51.07,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: Color(0xFF01654D),
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                font: GoogleFonts.roboto(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                                color: Colors.white,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ].divide(SizedBox(height: 15.0)),
            ),
          ]
              .divide(SizedBox(height: 10.0))
              .addToStart(SizedBox(height: 20.0))
              .addToEnd(SizedBox(height: 20.0)),
        ),
      ),
    );
  }
}
