import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'ditar_goald_model.dart';
export 'ditar_goald_model.dart';

class DitarGoaldWidget extends StatefulWidget {
  const DitarGoaldWidget({
    super.key,
    required this.goaldDocument,
  });

  final GoaldsRecord? goaldDocument;

  @override
  State<DitarGoaldWidget> createState() => _DitarGoaldWidgetState();
}

class _DitarGoaldWidgetState extends State<DitarGoaldWidget> {
  late DitarGoaldModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DitarGoaldModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.nombre = widget!.goaldDocument?.name;
      _model.description = widget!.goaldDocument?.description;
      _model.frequency = widget!.goaldDocument?.freuency;
      _model.initialDate = widget!.goaldDocument?.startedDate;
      _model.endDate = widget!.goaldDocument?.finishedDate;
      _model.totalAmount = widget!.goaldDocument?.totalAmount;
      _model.quote = widget!.goaldDocument?.quotes;
      _model.accountSender = widget!.goaldDocument?.senderAccount;
      _model.accountResepter = widget!.goaldDocument?.resiverAccount;
      _model.numbersOfQuotes = widget!.goaldDocument?.totalQuotesNumbers;
      _model.notificationAt = widget!.goaldDocument?.notificationAt;
      _model.frequencyCode = widget!.goaldDocument?.frequencyCode;
      safeSetState(() {});
    });

    _model.textController1 ??=
        TextEditingController(text: widget!.goaldDocument?.name);
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??=
        TextEditingController(text: widget!.goaldDocument?.description);
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController3 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();

    _model.textController4 ??= TextEditingController(
        text: widget!.goaldDocument?.totalAmount?.toString());
    _model.textFieldFocusNode4 ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {
          _model.textController3?.text = dateTimeFormat(
            "yMMMd",
            _model.endDate,
            locale: FFLocalizations.of(context).languageCode,
          );
        }));
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
        child: SingleChildScrollView(
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
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FlutterFlowIconButton(
                      borderRadius: 8.0,
                      buttonSize: 40.0,
                      icon: Icon(
                        Icons.arrow_back,
                        color: FlutterFlowTheme.of(context).info,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        context.safePop();
                      },
                    ),
                    Text(
                      FFLocalizations.of(context).getText(
                        'ze49y43x' /* Editar  Meta */,
                      ),
                      style:
                          FlutterFlowTheme.of(context).headlineSmall.override(
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
                  ].divide(SizedBox(width: 29.0)),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          'yk59jgil' /* Nombre */,
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
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
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
                      child: Container(
                        width: 200.0,
                        child: TextFormField(
                          controller: _model.textController1,
                          focusNode: _model.textFieldFocusNode1,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.textController1',
                            Duration(milliseconds: 2000),
                            () async {
                              _model.nombre = _model.textController1.text;
                              safeSetState(() {});
                            },
                          ),
                          autofocus: false,
                          enabled: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  font: GoogleFonts.golosText(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                            hintText: FFLocalizations.of(context).getText(
                              'qi2ihfw7' /* Nombre de tu meta... */,
                            ),
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  font: GoogleFonts.golosText(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
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
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          enableInteractiveSelection: true,
                          validator: _model.textController1Validator
                              .asValidator(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          'fsbkajws' /* Descripción (opcional) */,
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
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      height: 137.4,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
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
                      child: Container(
                        width: 200.0,
                        child: TextFormField(
                          controller: _model.textController2,
                          focusNode: _model.textFieldFocusNode2,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.textController2',
                            Duration(milliseconds: 2000),
                            () async {
                              _model.description = _model.textController2.text;
                              safeSetState(() {});
                            },
                          ),
                          autofocus: false,
                          enabled: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  font: GoogleFonts.golosText(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                            hintText: FFLocalizations.of(context).getText(
                              'vr7oim4f' /* Puedes dejar una breve descrip... */,
                            ),
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  font: GoogleFonts.golosText(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
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
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          enableInteractiveSelection: true,
                          validator: _model.textController2Validator
                              .asValidator(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          'eawdl1yo' /* Fecha de Inicio */,
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
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 15.0),
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
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
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            dateTimeFormat(
                              "yMMMd",
                              _model.initialDate,
                              locale: FFLocalizations.of(context).languageCode,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
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
                          Icon(
                            Icons.calendar_month,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          'l33lmzmt' /* Fecha de Culminación */,
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
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 15.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        final _datePickedDate = await showDatePicker(
                          context: context,
                          initialDate: getCurrentTimestamp,
                          firstDate: getCurrentTimestamp,
                          lastDate: DateTime(2050),
                          builder: (context, child) {
                            return wrapInMaterialDatePickerTheme(
                              context,
                              child!,
                              headerBackgroundColor:
                                  FlutterFlowTheme.of(context).primary,
                              headerForegroundColor:
                                  FlutterFlowTheme.of(context).info,
                              headerTextStyle: FlutterFlowTheme.of(context)
                                  .headlineLarge
                                  .override(
                                    font: GoogleFonts.golosText(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineLarge
                                          .fontStyle,
                                    ),
                                    fontSize: 32.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineLarge
                                        .fontStyle,
                                  ),
                              pickerBackgroundColor:
                                  FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                              pickerForegroundColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              selectedDateTimeBackgroundColor:
                                  FlutterFlowTheme.of(context).primary,
                              selectedDateTimeForegroundColor:
                                  FlutterFlowTheme.of(context).alternate,
                              actionButtonForegroundColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              iconSize: 24.0,
                            );
                          },
                        );

                        if (_datePickedDate != null) {
                          safeSetState(() {
                            _model.datePicked = DateTime(
                              _datePickedDate.year,
                              _datePickedDate.month,
                              _datePickedDate.day,
                            );
                          });
                        } else if (_model.datePicked != null) {
                          safeSetState(() {
                            _model.datePicked = getCurrentTimestamp;
                          });
                        }
                        _model.endDate = _model.datePicked;
                        safeSetState(() {});
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
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
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Container(
                                width: 200.0,
                                child: TextFormField(
                                  controller: _model.textController3,
                                  focusNode: _model.textFieldFocusNode3,
                                  autofocus: false,
                                  enabled: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          font: GoogleFonts.golosText(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                    hintText:
                                        FFLocalizations.of(context).getText(
                                      '3wk5nnsl' /* Seleccionar fecha... */,
                                    ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          font: GoogleFonts.golosText(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
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
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  enableInteractiveSelection: true,
                                  validator: _model.textController3Validator
                                      .asValidator(context),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.calendar_month,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          'yus5xd1m' /* Monto Total de la Meta */,
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
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 15.0),
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
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
                      child: Container(
                        width: 200.0,
                        child: TextFormField(
                          controller: _model.textController4,
                          focusNode: _model.textFieldFocusNode4,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.textController4',
                            Duration(milliseconds: 2000),
                            () async {
                              _model.totalAmount =
                                  double.tryParse(_model.textController4.text);
                              safeSetState(() {});
                            },
                          ),
                          autofocus: false,
                          enabled: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  font: GoogleFonts.golosText(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                            hintText: FFLocalizations.of(context).getText(
                              '0vkgy6sy' /* Cantidad Total de la meta... */,
                            ),
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  font: GoogleFonts.golosText(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
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
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          enableInteractiveSelection: true,
                          validator: _model.textController4Validator
                              .asValidator(context),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 200.0,
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          'urbyunnx' /* Frecuencia de la Cuota */,
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
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
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
                      child: FlutterFlowDropDown<String>(
                        controller: _model.dropDownValueController1 ??=
                            FormFieldController<String>(
                          _model.dropDownValue1 ??=
                              widget!.goaldDocument?.freuency,
                        ),
                        options: [
                          FFLocalizations.of(context).getText(
                            'g2fvwi3j' /* Diario */,
                          ),
                          FFLocalizations.of(context).getText(
                            'jtfvpfu2' /* Semanal */,
                          ),
                          FFLocalizations.of(context).getText(
                            '1ew0awtw' /* Quincenal */,
                          ),
                          FFLocalizations.of(context).getText(
                            'uk2d05u9' /* Mensual */,
                          ),
                          FFLocalizations.of(context).getText(
                            'mp829wgt' /* Trimestral */,
                          ),
                          FFLocalizations.of(context).getText(
                            'oe3yqfi2' /* Anual */,
                          )
                        ],
                        onChanged: (val) async {
                          safeSetState(() => _model.dropDownValue1 = val);
                          _model.frequency = _model.dropDownValue1;
                          _model.frequencyCode = () {
                            if (_model.frequency == 'Diario') {
                              return 1;
                            } else if (_model.frequency == 'Semanal') {
                              return 7;
                            } else if (_model.frequency == 'Quincenal') {
                              return 14;
                            } else if (_model.frequency == 'Mensual') {
                              return 1001;
                            } else if (_model.frequency == 'Trimestral') {
                              return 1003;
                            } else if (_model.frequency == 'Anual') {
                              return 1012;
                            } else {
                              return 0;
                            }
                          }();
                          safeSetState(() {});
                        },
                        width: 200.0,
                        height: 40.0,
                        textStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
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
                        hintText: FFLocalizations.of(context).getText(
                          'g3tgrqov' /* Seleccionar... */,
                        ),
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24.0,
                        ),
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
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
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          '3g6k3lv1' /* Número de cuotas  */,
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
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 15.0),
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
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
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          valueOrDefault<String>(
                            getJsonField(
                              functions.calculateGoalInstallmentsFn(
                                  _model.initialDate!,
                                  _model.endDate!,
                                  _model.totalAmount!, () {
                                if (_model.frequency == 'Diario') {
                                  return 1;
                                } else if (_model.frequency == 'Semanal') {
                                  return 7;
                                } else if (_model.frequency == 'Quincenal') {
                                  return 14;
                                } else if (_model.frequency == 'Mensual') {
                                  return 1001;
                                } else if (_model.frequency == 'Trimestral') {
                                  return 1003;
                                } else if (_model.frequency == 'Anual') {
                                  return 1012;
                                } else {
                                  return 0;
                                }
                              }()),
                              r'''$.installmentsCount''',
                            )?.toString(),
                            '0',
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.golosText(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: Color(0xFF1A1B24),
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 200.0,
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          'frfrncfz' /* Tamaño de la Cuota */,
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
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 15.0),
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
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
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          valueOrDefault<String>(
                            getJsonField(
                              functions.calculateGoalInstallmentsFn(
                                  _model.initialDate!,
                                  _model.endDate!,
                                  _model.totalAmount!, () {
                                if (_model.frequency == 'Diario') {
                                  return 1;
                                } else if (_model.frequency == 'Semanal') {
                                  return 7;
                                } else if (_model.frequency == 'Quincenal') {
                                  return 14;
                                } else if (_model.frequency == 'Mensual') {
                                  return 1001;
                                } else if (_model.frequency == 'Trimestral') {
                                  return 1003;
                                } else if (_model.frequency == 'Anual') {
                                  return 1012;
                                } else {
                                  return 0;
                                }
                              }()),
                              r'''$.installmentAmount''',
                            )?.toString(),
                            '0',
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.golosText(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: Color(0xFF1A1B24),
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 200.0,
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          'd8vj6zoh' /* Cuenta Emisora (de donde se en... */,
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
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 15.0),
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
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
                      child: FlutterFlowDropDown<String>(
                        controller: _model.dropDownValueController2 ??=
                            FormFieldController<String>(
                          _model.dropDownValue2 ??= _model.accountSender,
                        ),
                        options: [
                          FFLocalizations.of(context).getText(
                            'qr0jox13' /* Option 1 */,
                          ),
                          FFLocalizations.of(context).getText(
                            '8qs1xli9' /* Option 2 */,
                          ),
                          FFLocalizations.of(context).getText(
                            'gon5m95b' /* Option 3 */,
                          )
                        ],
                        onChanged: (val) async {
                          safeSetState(() => _model.dropDownValue2 = val);
                          _model.accountSender = _model.dropDownValue2;
                          safeSetState(() {});
                        },
                        width: 200.0,
                        height: 40.0,
                        textStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
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
                        hintText: FFLocalizations.of(context).getText(
                          'ydm8e992' /* Select... */,
                        ),
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24.0,
                        ),
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
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
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          '0pj7nsq2' /* Cuenta Receptora ( La que reci... */,
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
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 15.0),
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
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
                      child: FlutterFlowDropDown<String>(
                        controller: _model.dropDownValueController3 ??=
                            FormFieldController<String>(
                          _model.dropDownValue3 ??= _model.accountResepter,
                        ),
                        options: [
                          FFLocalizations.of(context).getText(
                            'g70zmztr' /* Option 1 */,
                          ),
                          FFLocalizations.of(context).getText(
                            'yrttzo5g' /* Option 2 */,
                          ),
                          FFLocalizations.of(context).getText(
                            '874v594n' /* Option 3 */,
                          )
                        ],
                        onChanged: (val) async {
                          safeSetState(() => _model.dropDownValue3 = val);
                          _model.accountResepter = _model.dropDownValue3;
                          safeSetState(() {});
                        },
                        width: 200.0,
                        height: 40.0,
                        textStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
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
                        hintText: FFLocalizations.of(context).getText(
                          'qkaizs97' /* Select... */,
                        ),
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24.0,
                        ),
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        elevation: 2.0,
                        borderColor: Colors.transparent,
                        borderWidth: 0.0,
                        borderRadius: 8.0,
                        margin: EdgeInsetsDirectional.fromSTEB(
                            12.0, 0.0, 12.0, 0.0),
                        hidesUnderline: true,
                        disabled:
                            widget!.goaldDocument?.resiverAccount != null &&
                                widget!.goaldDocument?.resiverAccount != '',
                        isOverButton: false,
                        isSearchable: false,
                        isMultiSelect: false,
                      ),
                    ),
                  ),
                ],
              ),
              if (valueOrDefault(
                      currentUserDocument?.notificationAjustValue, 0) ==
                  2)
                AuthUserStreamWidget(
                  builder: (context) => Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'h4byxrn9' /* Ajustes de Notificación */,
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
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    's5a09dy6' /* ( Horas de antelación para rec... */,
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
                                        color: FlutterFlowTheme.of(context)
                                            .accent2,
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
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 20.0),
                        child: Container(
                          width: double.infinity,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
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
                          child: FlutterFlowDropDown<String>(
                            controller: _model.dropDownValueController4 ??=
                                FormFieldController<String>(
                              _model.dropDownValue4 ??= widget!
                                  .goaldDocument?.notificationAt
                                  ?.toString(),
                            ),
                            options: [
                              FFLocalizations.of(context).getText(
                                'l5hrpn0n' /* 24 */,
                              ),
                              FFLocalizations.of(context).getText(
                                'nirhb9u9' /* 48 */,
                              ),
                              FFLocalizations.of(context).getText(
                                'ldhpyl9w' /* 72 */,
                              ),
                              FFLocalizations.of(context).getText(
                                'gxreoyjk' /* 96 */,
                              )
                            ],
                            onChanged: (val) async {
                              safeSetState(() => _model.dropDownValue4 = val);
                              _model.notificationAt = () {
                                if (_model.dropDownValue4 == '24') {
                                  return 24;
                                } else if (_model.dropDownValue4 == '48') {
                                  return 48;
                                } else if (_model.dropDownValue4 == '72') {
                                  return 72;
                                } else if (_model.dropDownValue4 == '96') {
                                  return 96;
                                } else {
                                  return 0;
                                }
                              }();
                              safeSetState(() {});
                            },
                            width: 200.0,
                            height: 40.0,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
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
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText,
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
                    ],
                  ),
                ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    if ((widget!.goaldDocument?.frequencyCode ==
                            _model.frequencyCode) &&
                        (widget!.goaldDocument?.finishedDate ==
                            _model.endDate)) {
                      _model.docus = await queryDocumentsRecordOnce(
                        queryBuilder: (documentsRecord) => documentsRecord
                            .where(
                              'userRef',
                              isEqualTo: currentUserReference,
                            )
                            .where(
                              'recurrenceId',
                              isEqualTo:
                                  widget!.goaldDocument?.recurrentDocumentId,
                            ),
                      );
                      for (int loop1Index = 0;
                          loop1Index < _model.docus!.length;
                          loop1Index++) {
                        final currentLoop1Item = _model.docus![loop1Index];

                        await currentLoop1Item.reference
                            .update(createDocumentsRecordData(
                          description: _model.description,
                          amount: _model.quote,
                          goaldName: currentLoop1Item.goaldName,
                        ));
                      }

                      await widget!.goaldDocument!.reference
                          .update(createGoaldsRecordData(
                        quotes: valueOrDefault<double>(
                          getJsonField(
                            functions.calculateGoalInstallmentsFn(
                                _model.initialDate!,
                                _model.endDate!,
                                _model.totalAmount!, () {
                              if (_model.frequency == 'Diario') {
                                return 1;
                              } else if (_model.frequency == 'Semanal') {
                                return 7;
                              } else if (_model.frequency == 'Quincenal') {
                                return 14;
                              } else if (_model.frequency == 'Mensual') {
                                return 1001;
                              } else if (_model.frequency == 'Trimestral') {
                                return 1003;
                              } else if (_model.frequency == 'Anual') {
                                return 1012;
                              } else {
                                return 0;
                              }
                            }()),
                            r'''$.installmentAmount''',
                          ),
                          0.0,
                        ),
                        name: _model.nombre,
                        description: _model.description,
                        resiverAccount: _model.accountResepter,
                        totalAmount: _model.totalAmount,
                        senderAccount: _model.accountSender,
                      ));
                    } else {
                      _model.documentos = await queryDocumentsRecordOnce(
                        queryBuilder: (documentsRecord) => documentsRecord
                            .where(
                              'recurrenceId',
                              isEqualTo:
                                  widget!.goaldDocument?.recurrentDocumentId,
                            )
                            .where(
                              'userRef',
                              isEqualTo: currentUserReference,
                            ),
                      );
                      for (int loop2Index = 0;
                          loop2Index < _model.documentos!.length;
                          loop2Index++) {
                        final currentLoop2Item = _model.documentos![loop2Index];
                        await currentLoop2Item.reference.delete();
                      }
                      await widget!.goaldDocument!.reference.delete();

                      var goaldsRecordReference = GoaldsRecord.collection.doc();
                      await goaldsRecordReference.set({
                        ...createGoaldsRecordData(
                          userRef: currentUserReference,
                          startedDate:
                              functions.normalizeToCalendarDatedateTime(
                                  widget!.goaldDocument!.startedDate!),
                          finishedDate: functions
                              .normalizeToCalendarDatedateTime(_model.endDate!),
                          totalAmount: _model.totalAmount,
                          quotes: getJsonField(
                            functions.calculateGoalInstallmentsFn(
                                widget!.goaldDocument!.startedDate!,
                                _model.endDate!,
                                _model.totalAmount!, () {
                              if (_model.frequency == 'Diario') {
                                return 1;
                              } else if (_model.frequency == 'Semanal') {
                                return 7;
                              } else if (_model.frequency == 'Quincenal') {
                                return 14;
                              } else if (_model.frequency == 'Mensual') {
                                return 1001;
                              } else if (_model.frequency == 'Trimestral') {
                                return 1003;
                              } else if (_model.frequency == 'Anual') {
                                return 1012;
                              } else {
                                return 0;
                              }
                            }()),
                            r'''$.installmentAmount''',
                          ),
                          name: _model.nombre,
                          description: _model.description,
                          freuency: _model.frequency,
                          isFrozen: false,
                          isComplited: false,
                          senderAccount: _model.accountSender,
                          resiverAccount: _model.accountResepter,
                          porcent: 0.0,
                          currentAmount: 0.0,
                          totalQuotesNumbers: getJsonField(
                            functions.calculateGoalInstallmentsFn(
                                widget!.goaldDocument!.startedDate!,
                                _model.endDate!,
                                _model.totalAmount!, () {
                              if (_model.frequency == 'Diario') {
                                return 1;
                              } else if (_model.frequency == 'Semanal') {
                                return 7;
                              } else if (_model.frequency == 'Quincenal') {
                                return 14;
                              } else if (_model.frequency == 'Mensual') {
                                return 1001;
                              } else if (_model.frequency == 'Trimestral') {
                                return 1003;
                              } else if (_model.frequency == 'Anual') {
                                return 1012;
                              } else {
                                return 0;
                              }
                            }()),
                            r'''$.installmentsCount''',
                          ),
                          frequencyCode: _model.frequencyCode,
                        ),
                        ...mapToFirestore(
                          {
                            'updatedDate': FieldValue.serverTimestamp(),
                          },
                        ),
                      });
                      _model.goal = GoaldsRecord.getDocumentFromData({
                        ...createGoaldsRecordData(
                          userRef: currentUserReference,
                          startedDate:
                              functions.normalizeToCalendarDatedateTime(
                                  widget!.goaldDocument!.startedDate!),
                          finishedDate: functions
                              .normalizeToCalendarDatedateTime(_model.endDate!),
                          totalAmount: _model.totalAmount,
                          quotes: getJsonField(
                            functions.calculateGoalInstallmentsFn(
                                widget!.goaldDocument!.startedDate!,
                                _model.endDate!,
                                _model.totalAmount!, () {
                              if (_model.frequency == 'Diario') {
                                return 1;
                              } else if (_model.frequency == 'Semanal') {
                                return 7;
                              } else if (_model.frequency == 'Quincenal') {
                                return 14;
                              } else if (_model.frequency == 'Mensual') {
                                return 1001;
                              } else if (_model.frequency == 'Trimestral') {
                                return 1003;
                              } else if (_model.frequency == 'Anual') {
                                return 1012;
                              } else {
                                return 0;
                              }
                            }()),
                            r'''$.installmentAmount''',
                          ),
                          name: _model.nombre,
                          description: _model.description,
                          freuency: _model.frequency,
                          isFrozen: false,
                          isComplited: false,
                          senderAccount: _model.accountSender,
                          resiverAccount: _model.accountResepter,
                          porcent: 0.0,
                          currentAmount: 0.0,
                          totalQuotesNumbers: getJsonField(
                            functions.calculateGoalInstallmentsFn(
                                widget!.goaldDocument!.startedDate!,
                                _model.endDate!,
                                _model.totalAmount!, () {
                              if (_model.frequency == 'Diario') {
                                return 1;
                              } else if (_model.frequency == 'Semanal') {
                                return 7;
                              } else if (_model.frequency == 'Quincenal') {
                                return 14;
                              } else if (_model.frequency == 'Mensual') {
                                return 1001;
                              } else if (_model.frequency == 'Trimestral') {
                                return 1003;
                              } else if (_model.frequency == 'Anual') {
                                return 1012;
                              } else {
                                return 0;
                              }
                            }()),
                            r'''$.installmentsCount''',
                          ),
                          frequencyCode: _model.frequencyCode,
                        ),
                        ...mapToFirestore(
                          {
                            'updatedDate': DateTime.now(),
                          },
                        ),
                      }, goaldsRecordReference);

                      await _model.goal!.reference.update({
                        ...mapToFirestore(
                          {
                            'ejecutionDates':
                                functions.buildTransferScheduleDatesFn(
                                    widget!.goaldDocument!.startedDate!,
                                    _model.goal!.finishedDate!,
                                    _model.goal!.frequencyCode),
                          },
                        ),
                      });

                      var documentsRecordReference1 =
                          DocumentsRecord.collection.doc();
                      await documentsRecordReference1
                          .set(createDocumentsRecordData(
                        type: 'Meta Financiera',
                        description: _model.description,
                        date: functions.normalizeToCalendarDatedateTime(
                            widget!.goaldDocument!.startedDate!),
                        amount: _model.quote,
                        isRecurrent: true,
                        frequency: _model.frequency,
                        userRef: currentUserReference,
                        frequencyCode: _model.frequencyCode,
                        notificationAt: _model.notificationAt,
                        isSave: true,
                        isIncome: false,
                        isExpenses: false,
                        isEvent: false,
                        source: 'manual',
                        isGoal: true,
                      ));
                      _model.action1 = DocumentsRecord.getDocumentFromData(
                          createDocumentsRecordData(
                            type: 'Meta Financiera',
                            description: _model.description,
                            date: functions.normalizeToCalendarDatedateTime(
                                widget!.goaldDocument!.startedDate!),
                            amount: _model.quote,
                            isRecurrent: true,
                            frequency: _model.frequency,
                            userRef: currentUserReference,
                            frequencyCode: _model.frequencyCode,
                            notificationAt: _model.notificationAt,
                            isSave: true,
                            isIncome: false,
                            isExpenses: false,
                            isEvent: false,
                            source: 'manual',
                            isGoal: true,
                          ),
                          documentsRecordReference1);

                      await _model.action1!.reference
                          .update(createDocumentsRecordData(
                        recurrenceId: _model.action1?.reference.id,
                        occurrenceKey: functions.dateToOccurrenceKey(
                            widget!.goaldDocument!.startedDate!),
                      ));
                      if (_model.action1?.isRecurrent == true) {
                        for (int loop3Index = 0;
                            loop3Index <
                                functions
                                    .buildGoalPeriodDatesExcludeStart(
                                        _model.initialDate!,
                                        _model.endDate!,
                                        _model.frequencyCode)
                                    .length;
                            loop3Index++) {
                          final currentLoop3Item =
                              functions.buildGoalPeriodDatesExcludeStart(
                                  _model.initialDate!,
                                  _model.endDate!,
                                  _model.frequencyCode)[loop3Index];

                          var documentsRecordReference2 =
                              DocumentsRecord.collection.doc();
                          await documentsRecordReference2
                              .set(createDocumentsRecordData(
                            type: _model.action1?.type,
                            description: _model.action1?.description,
                            date: currentLoop3Item,
                            amount: _model.action1?.amount,
                            isRecurrent: true,
                            frequency: _model.action1?.frequency,
                            userRef: currentUserReference,
                            frequencyCode: _model.action1?.frequencyCode,
                            recurrenceId: _model.action1?.recurrenceId,
                            occurrenceKey:
                                functions.dateToOccurrenceKey(currentLoop3Item),
                            notificationAt: _model.action1?.notificationAt,
                            isSave: true,
                            isIncome: false,
                            isExpenses: false,
                            isEvent: false,
                            source: 'manual',
                            isGoal: true,
                          ));
                          _model.recurrente =
                              DocumentsRecord.getDocumentFromData(
                                  createDocumentsRecordData(
                                    type: _model.action1?.type,
                                    description: _model.action1?.description,
                                    date: currentLoop3Item,
                                    amount: _model.action1?.amount,
                                    isRecurrent: true,
                                    frequency: _model.action1?.frequency,
                                    userRef: currentUserReference,
                                    frequencyCode:
                                        _model.action1?.frequencyCode,
                                    recurrenceId: _model.action1?.recurrenceId,
                                    occurrenceKey: functions
                                        .dateToOccurrenceKey(currentLoop3Item),
                                    notificationAt:
                                        _model.action1?.notificationAt,
                                    isSave: true,
                                    isIncome: false,
                                    isExpenses: false,
                                    isEvent: false,
                                    source: 'manual',
                                    isGoal: true,
                                  ),
                                  documentsRecordReference2);
                        }
                      }
                      _model.account = await queryBankAccountsRecordOnce(
                        queryBuilder: (bankAccountsRecord) =>
                            bankAccountsRecord.where(
                          'userRef',
                          isEqualTo: currentUserReference,
                        ),
                        singleRecord: true,
                      ).then((s) => s.firstOrNull);

                      await _model.goal!.reference
                          .update(createGoaldsRecordData(
                        recurrentDocumentId: _model.action1?.reference.id,
                        bankAccountsRef: _model.account?.reference,
                      ));
                    }

                    Navigator.pop(context);

                    safeSetState(() {});
                  },
                  text: FFLocalizations.of(context).getText(
                    'lxex0fh8' /* Editar Meta */,
                  ),
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 50.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Color(0xFF01654D),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.golosText(
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
      ),
    );
  }
}
