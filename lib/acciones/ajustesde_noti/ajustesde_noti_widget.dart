import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'ajustesde_noti_model.dart';
export 'ajustesde_noti_model.dart';

class AjustesdeNotiWidget extends StatefulWidget {
  const AjustesdeNotiWidget({super.key});

  @override
  State<AjustesdeNotiWidget> createState() => _AjustesdeNotiWidgetState();
}

class _AjustesdeNotiWidgetState extends State<AjustesdeNotiWidget> {
  late AjustesdeNotiModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AjustesdeNotiModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.notificationAt =
          valueOrDefault(currentUserDocument?.notificationAt, 0);
      safeSetState(() {});
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      'y2s20spp' /* Ajustes de Notificaciones */,
                    ),
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          font: GoogleFonts.outfit(
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .fontStyle,
                          ),
                          color: Color(0xFF14181B),
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
            if ((valueOrDefault<bool>(currentUserDocument?.isPremium, false) ==
                    false) ||
                (valueOrDefault<bool>(currentUserDocument?.isBasic, false) ==
                    true) ||
                (valueOrDefault<bool>(
                        currentUserDocument?.isBasicWhitAnunces, false) ==
                    true))
              Align(
                alignment: AlignmentDirectional(-1.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: AuthUserStreamWidget(
                    builder: (context) => Text(
                      FFLocalizations.of(context).getText(
                        'jdquut14' /* Todas las notificaciones han s... */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.golosText(
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
            if ((valueOrDefault<bool>(currentUserDocument?.isPremium, false) ==
                    true) &&
                (valueOrDefault<bool>(currentUserDocument?.isBasic, false) ==
                    false) &&
                (valueOrDefault<bool>(
                        currentUserDocument?.isBasicWhitAnunces, false) ==
                    false))
              AuthUserStreamWidget(
                builder: (context) => Container(
                  height: 192.47,
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 95.0,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(-1.0, -1.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'p3md6mhg' /* Ajustes globales */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.golosText(
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
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  width: double.infinity,
                                  height: 50.0,
                                  decoration: BoxDecoration(),
                                  child: FlutterFlowDropDown<String>(
                                    controller:
                                        _model.dropDownValueController1 ??=
                                            FormFieldController<String>(
                                      _model.dropDownValue1 ??= () {
                                        if (valueOrDefault(
                                                currentUserDocument
                                                    ?.notificationAjustValue,
                                                0) ==
                                            1) {
                                          return 'Predeterminado ( Un mismo tiempo para todas las notificaciones )';
                                        } else if (valueOrDefault(
                                                currentUserDocument
                                                    ?.notificationAjustValue,
                                                0) ==
                                            2) {
                                          return 'Independiente ( Cada evento define su tiempo de notificación )';
                                        } else {
                                          return 'null';
                                        }
                                      }(),
                                    ),
                                    options: [
                                      FFLocalizations.of(context).getText(
                                        '6blvw7yu' /* Predeterminado ( Un mismo tiem... */,
                                      ),
                                      FFLocalizations.of(context).getText(
                                        'ij5wenm2' /* Independiente ( Cada evento de... */,
                                      )
                                    ],
                                    onChanged: (val) async {
                                      safeSetState(
                                          () => _model.dropDownValue1 = val);
                                      await currentUserReference!
                                          .update(createUserRecordData(
                                        notificationAjustValue: () {
                                          if (_model.dropDownValue1 ==
                                              'Predeterminado ( Un mismo tiempo para todas las notificaciones )') {
                                            return 1;
                                          } else if (_model.dropDownValue1 ==
                                              'Independiente ( Cada evento define su tiempo de notificación )') {
                                            return 2;
                                          } else {
                                            return 0;
                                          }
                                        }(),
                                      ));
                                    },
                                    width: 289.8,
                                    height: 40.0,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.golosText(
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
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 24.0,
                                    ),
                                    fillColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    elevation: 2.0,
                                    borderColor: Colors.transparent,
                                    borderWidth: 0.0,
                                    borderRadius: 8.0,
                                    margin: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 12.0, 0.0),
                                    hidesUnderline: true,
                                    isOverButton: false,
                                    isSearchable: false,
                                    isMultiSelect: false,
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(height: 10.0)),
                          ),
                        ),
                      ),
                      if (valueOrDefault(
                              currentUserDocument?.notificationAjustValue, 0) ==
                          1)
                        Container(
                          height: 95.0,
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-1.0, -1.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'ezdvlokr' /* Horas de antelación */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.golosText(
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
                                ),
                                Flexible(
                                  child: Container(
                                    width: double.infinity,
                                    height: 50.0,
                                    decoration: BoxDecoration(),
                                    child: FlutterFlowDropDown<String>(
                                      controller:
                                          _model.dropDownValueController2 ??=
                                              FormFieldController<String>(
                                        _model.dropDownValue2 ??=
                                            valueOrDefault(
                                                    currentUserDocument
                                                        ?.notificationAt,
                                                    0)
                                                .toString(),
                                      ),
                                      options: [
                                        FFLocalizations.of(context).getText(
                                          '4o8tqkh9' /* 24 */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'bco6eskt' /* 48 */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'j2741zrr' /* 72 */,
                                        ),
                                        FFLocalizations.of(context).getText(
                                          'oji9nq5r' /* 96 */,
                                        )
                                      ],
                                      onChanged: (val) async {
                                        safeSetState(
                                            () => _model.dropDownValue2 = val);
                                        _model.notificationAt = () {
                                          if (_model.dropDownValue2 == '24') {
                                            return 24;
                                          } else if (_model.dropDownValue2 ==
                                              '48') {
                                            return 48;
                                          } else if (_model.dropDownValue2 ==
                                              '72') {
                                            return 72;
                                          } else if (_model.dropDownValue2 ==
                                              '96') {
                                            return 96;
                                          } else {
                                            return 0;
                                          }
                                        }();
                                        safeSetState(() {});
                                      },
                                      width: 289.8,
                                      height: 40.0,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.golosText(
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
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 24.0,
                                      ),
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      elevation: 2.0,
                                      borderColor: Colors.transparent,
                                      borderWidth: 0.0,
                                      borderRadius: 8.0,
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 12.0, 0.0),
                                      hidesUnderline: true,
                                      isOverButton: false,
                                      isSearchable: false,
                                      isMultiSelect: false,
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(height: 10.0)),
                            ),
                          ),
                        ),
                    ],
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
                    if (valueOrDefault(
                            currentUserDocument?.notificationAjustValue, 0) ==
                        1) {
                      await currentUserReference!.update(createUserRecordData(
                        notificationAt: _model.notificationAt,
                      ));
                    }
                  }
                  Navigator.pop(context);
                },
                text: FFLocalizations.of(context).getText(
                  '939lghj0' /* Aceptar */,
                ),
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 50.0,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Color(0xFF01654D),
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.golosText(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                        color: Colors.white,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
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
