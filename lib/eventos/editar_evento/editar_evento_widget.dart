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
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'editar_evento_model.dart';
export 'editar_evento_model.dart';

class EditarEventoWidget extends StatefulWidget {
  const EditarEventoWidget({
    super.key,
    required this.docDocument,
  });

  final DocumentsRecord? docDocument;

  @override
  State<EditarEventoWidget> createState() => _EditarEventoWidgetState();
}

class _EditarEventoWidgetState extends State<EditarEventoWidget> {
  late EditarEventoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditarEventoModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        Future(() async {
          _model.income = await queryIncomeRecordOnce(
            singleRecord: true,
          ).then((s) => s.firstOrNull);
          _model.incom = _model.income!.type.toList().cast<String>();
          safeSetState(() {});
        }),
        Future(() async {
          _model.expenses = await queryExpensesRecordOnce(
            singleRecord: true,
          ).then((s) => s.firstOrNull);
          _model.expense = _model.expenses!.type.toList().cast<String>();
          safeSetState(() {});
        }),
        Future(() async {
          _model.events = await queryEventsRecordOnce(
            singleRecord: true,
          ).then((s) => s.firstOrNull);
          _model.evento = _model.events!.type.toList().cast<String>();
          safeSetState(() {});
        }),
        Future(() async {
          _model.save = await querySaveRecordOnce(
            singleRecord: true,
          ).then((s) => s.firstOrNull);
          _model.saves = _model.save!.type.toList().cast<String>();
          safeSetState(() {});
        }),
      ]);
      _model.type = widget!.docDocument?.type;
      _model.description = widget!.docDocument?.description;
      _model.amount = widget!.docDocument?.amount;
      _model.isRecurrent = widget!.docDocument!.isRecurrent;
      _model.frequency = widget!.docDocument?.frequency;
      _model.editarSoloEsteEvento =
          widget!.docDocument?.isRecurrent == true ? false : true;
      _model.notificationAt = widget!.docDocument?.notificationAt;
      safeSetState(() {});
    });

    _model.textController1 ??=
        TextEditingController(text: widget!.docDocument?.description);
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController(
        text: valueOrDefault<String>(
      widget!.docDocument?.amount?.toString(),
      '0',
    ));
    _model.textFieldFocusNode2 ??= FocusNode();

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
        child: SingleChildScrollView(
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
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      FFLocalizations.of(context).getText(
                        'dxsdhlib' /* Editar Evento */,
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (widget!.docDocument?.date != null)
                      Text(
                        valueOrDefault<String>(
                          dateTimeFormat(
                            "MMMMEEEEd",
                            widget!.docDocument?.date,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          'MMMMEEEEd',
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
                  ],
                ),
              ),
              if ((widget!.docDocument?.type != null &&
                      widget!.docDocument?.type != '') &&
                  (widget!.docDocument?.source == 'manual'))
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
                            'ittwj46r' /* Tipo */,
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
                        child: FlutterFlowDropDown<String>(
                          controller: _model.dropDownValueController1 ??=
                              FormFieldController<String>(
                            _model.dropDownValue1 ??= widget!.docDocument?.type,
                          ),
                          options: () {
                            if ((widget!.docDocument?.isIncome == true) &&
                                (widget!.docDocument?.isEvent == false) &&
                                (widget!.docDocument?.isSave == false) &&
                                (widget!.docDocument?.isExpenses == false)) {
                              return _model.incom;
                            } else if ((widget!.docDocument?.isIncome ==
                                    false) &&
                                (widget!.docDocument?.isEvent == false) &&
                                (widget!.docDocument?.isSave == false) &&
                                (widget!.docDocument?.isExpenses == true)) {
                              return _model.expense;
                            } else if ((widget!.docDocument?.isIncome ==
                                    false) &&
                                (widget!.docDocument?.isEvent == false) &&
                                (widget!.docDocument?.isSave == true) &&
                                (widget!.docDocument?.isExpenses == false)) {
                              return _model.saves;
                            } else if ((widget!.docDocument?.isIncome ==
                                    false) &&
                                (widget!.docDocument?.isEvent == true) &&
                                (widget!.docDocument?.isSave == false) &&
                                (widget!.docDocument?.isExpenses == false)) {
                              return _model.evento;
                            } else {
                              return _model.evento;
                            }
                          }(),
                          onChanged: (val) async {
                            safeSetState(() => _model.dropDownValue1 = val);
                            _model.type = _model.dropDownValue1;
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
                          'paumplas' /* Descripción (opcional) */,
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
                      height: 137.42,
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
                              _model.description = _model.textController1.text;
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
                              '2pb67126' /* Puedes dejar una breve descrip... */,
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
              if ((widget!.docDocument?.isEvent == false) &&
                  (widget!.docDocument?.source == 'manual'))
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
                            '6agbstzt' /* Monto  */,
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
                        child: Container(
                          width: 200.0,
                          child: TextFormField(
                            controller: _model.textController2,
                            focusNode: _model.textFieldFocusNode2,
                            onChanged: (_) => EasyDebounce.debounce(
                              '_model.textController2',
                              Duration(milliseconds: 2000),
                              () async {
                                _model.amount = double.tryParse(
                                    _model.textController2.text);
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
                                'n0s4p3f0' /* Cantidad del efectivo... */,
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
                            cursorColor:
                                FlutterFlowTheme.of(context).primaryText,
                            enableInteractiveSelection: true,
                            validator: _model.textController2Validator
                                .asValidator(context),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              if (widget!.docDocument?.isRecurrent == true)
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
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
                            value: _model.checkboxValue ??=
                                widget!.docDocument!.isRecurrent,
                            onChanged: ((valueOrDefault<bool>(
                                            currentUserDocument?.isPremium,
                                            false) ==
                                        false) ||
                                    (valueOrDefault<bool>(
                                            currentUserDocument?.isBasic,
                                            false) ==
                                        true) ||
                                    (valueOrDefault<bool>(
                                            currentUserDocument
                                                ?.isBasicWhitAnunces,
                                            false) ==
                                        true))
                                ? null
                                : (newValue) async {
                                    safeSetState(
                                        () => _model.checkboxValue = newValue!);
                                    if (newValue!) {
                                      _model.isRecurrent = true;
                                      _model.editarSoloEsteEvento = false;
                                      safeSetState(() {});
                                    } else {
                                      _model.isRecurrent = false;
                                      _model.frequency = 'frequency';
                                      _model.editarSoloEsteEvento = true;
                                      safeSetState(() {});
                                    }
                                  },
                            side: (FlutterFlowTheme.of(context).alternate !=
                                    null)
                                ? BorderSide(
                                    width: 2,
                                    color:
                                        FlutterFlowTheme.of(context).alternate!,
                                  )
                                : null,
                            activeColor: Color(0xFF01654D),
                            checkColor: ((valueOrDefault<bool>(
                                            currentUserDocument?.isPremium,
                                            false) ==
                                        false) ||
                                    (valueOrDefault<bool>(
                                            currentUserDocument?.isBasic,
                                            false) ==
                                        true) ||
                                    (valueOrDefault<bool>(
                                            currentUserDocument
                                                ?.isBasicWhitAnunces,
                                            false) ==
                                        true))
                                ? null
                                : FlutterFlowTheme.of(context)
                                    .primaryBackground,
                          ),
                        ),
                      ),
                      Text(
                        FFLocalizations.of(context).getText(
                          'uc28cxro' /* Editar también todas las recur... */,
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
                    ],
                  ),
                ),
              if ((widget!.docDocument?.isRecurrent == true) &&
                  (widget!.docDocument?.source == 'manual'))
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
                            'mm40ygy0' /* Frecuencia */,
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
                        child: AuthUserStreamWidget(
                          builder: (context) => FlutterFlowDropDown<String>(
                            controller: _model.dropDownValueController2 ??=
                                FormFieldController<String>(
                              _model.dropDownValue2 ??=
                                  widget!.docDocument?.frequency,
                            ),
                            options: [
                              FFLocalizations.of(context).getText(
                                'zmnw3pdx' /* Diario */,
                              ),
                              FFLocalizations.of(context).getText(
                                'fbupax7r' /* Semanal */,
                              ),
                              FFLocalizations.of(context).getText(
                                'pa0leuxr' /* Quincenal */,
                              ),
                              FFLocalizations.of(context).getText(
                                'jopkbkj0' /* Mensual */,
                              ),
                              FFLocalizations.of(context).getText(
                                'qnirlmj3' /* Trimestral */,
                              ),
                              FFLocalizations.of(context).getText(
                                'xxj5kcqe' /* Anual */,
                              )
                            ],
                            onChanged: (val) async {
                              safeSetState(() => _model.dropDownValue2 = val);
                              _model.frequency = _model.dropDownValue2;
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
                            hintText: FFLocalizations.of(context).getText(
                              'hildixv2' /* Seleccionar... */,
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
                            disabled: (valueOrDefault<bool>(
                                        currentUserDocument?.isPremium,
                                        false) ==
                                    false) ||
                                (valueOrDefault<bool>(
                                        currentUserDocument?.isBasic, false) ==
                                    true) ||
                                (valueOrDefault<bool>(
                                        currentUserDocument?.isBasicWhitAnunces,
                                        false) ==
                                    true),
                            isOverButton: false,
                            isSearchable: false,
                            isMultiSelect: false,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              if (((valueOrDefault<bool>(
                              currentUserDocument?.isPremium, false) ==
                          true) &&
                      (valueOrDefault<bool>(
                              currentUserDocument?.isBasic, false) ==
                          false) &&
                      (valueOrDefault<bool>(
                              currentUserDocument?.isBasicWhitAnunces, false) ==
                          false)) &&
                  (valueOrDefault(
                          currentUserDocument?.notificationAjustValue, 0) ==
                      2))
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                  child: AuthUserStreamWidget(
                    builder: (context) => Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'qiijo0z7' /* Ajustes de Notificación */,
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
                                    '5zpt7j0h' /* ( Horas de antelación para rec... */,
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 0.0),
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
                              controller: _model.dropDownValueController3 ??=
                                  FormFieldController<String>(
                                _model.dropDownValue3 ??= widget!
                                    .docDocument?.notificationAt
                                    ?.toString(),
                              ),
                              options: [
                                FFLocalizations.of(context).getText(
                                  'qb7iolo4' /* 24 */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'y140w7ib' /* 48 */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'kcyv5x67' /* 72 */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'g89o8tzx' /* 96 */,
                                )
                              ],
                              onChanged: (val) async {
                                safeSetState(() => _model.dropDownValue3 = val);
                                _model.notificationAt = () {
                                  if (_model.dropDownValue3 == '24') {
                                    return 24;
                                  } else if (_model.dropDownValue3 == '48') {
                                    return 48;
                                  } else if (_model.dropDownValue3 == '72') {
                                    return 72;
                                  } else if (_model.dropDownValue3 == '96') {
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
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
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
                ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    if (valueOrDefault<bool>(
                            currentUserDocument?.isPremium, false) ==
                        true) {
                      if (_model.editarSoloEsteEvento == true) {
                        if (widget!.docDocument?.isExpenses == true) {
                          await widget!.docDocument!.reference.update({
                            ...createDocumentsRecordData(
                              type: _model.type,
                              description: _model.description,
                              amount: _model.amount,
                              isRecurrent: _model.isRecurrent,
                              notificationAt: _model.notificationAt,
                              isOtherExpenses: true,
                            ),
                            ...mapToFirestore(
                              {
                                'frequency': FieldValue.delete(),
                                'recurrenceId': FieldValue.delete(),
                                'frequencyCode': FieldValue.delete(),
                              },
                            ),
                          });
                        } else {
                          await widget!.docDocument!.reference.update({
                            ...createDocumentsRecordData(
                              type: _model.type,
                              description: _model.description,
                              amount: _model.amount,
                              isRecurrent: _model.isRecurrent,
                              notificationAt: _model.notificationAt,
                            ),
                            ...mapToFirestore(
                              {
                                'frequency': FieldValue.delete(),
                                'recurrenceId': FieldValue.delete(),
                                'frequencyCode': FieldValue.delete(),
                              },
                            ),
                          });
                        }
                      } else {
                        if (widget!.docDocument?.frequency ==
                            _model.frequency) {
                          _model.docRecurrentes3 =
                              await queryDocumentsRecordOnce(
                            queryBuilder: (documentsRecord) => documentsRecord
                                .where(
                                  'userRef',
                                  isEqualTo: currentUserReference,
                                )
                                .where(
                                  'recurrenceId',
                                  isEqualTo: widget!.docDocument?.recurrenceId,
                                ),
                          );
                          for (int loop1Index = 0;
                              loop1Index <
                                  _model.docRecurrentes3!
                                      .map((e) => e.reference)
                                      .toList()
                                      .length;
                              loop1Index++) {
                            final currentLoop1Item = _model.docRecurrentes3!
                                .map((e) => e.reference)
                                .toList()[loop1Index];

                            await currentLoop1Item
                                .update(createDocumentsRecordData(
                              type: _model.type,
                              description: _model.description,
                              amount: _model.amount,
                              notificationAt: _model.notificationAt,
                            ));
                          }
                        } else {
                          _model.docRecurrentes2 =
                              await queryDocumentsRecordOnce(
                            queryBuilder: (documentsRecord) => documentsRecord
                                .where(
                                  'userRef',
                                  isEqualTo: currentUserReference,
                                )
                                .where(
                                  'recurrenceId',
                                  isEqualTo: widget!.docDocument?.recurrenceId,
                                ),
                          );
                          for (int loop2Index = 0;
                              loop2Index <
                                  _model.docRecurrentes2!
                                      .map((e) => e.reference)
                                      .toList()
                                      .length;
                              loop2Index++) {
                            final currentLoop2Item = _model.docRecurrentes2!
                                .map((e) => e.reference)
                                .toList()[loop2Index];
                            await currentLoop2Item.delete();
                          }

                          var documentsRecordReference1 =
                              DocumentsRecord.collection.doc();
                          await documentsRecordReference1
                              .set(createDocumentsRecordData(
                            type: _model.type,
                            description: _model.description,
                            amount: _model.amount,
                            isRecurrent: _model.isRecurrent,
                            frequency: _model.frequency,
                            userRef: currentUserReference,
                            frequencyCode: () {
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
                            }(),
                            isIncome: widget!.docDocument?.isIncome,
                            date: functions.normalizeToCalendarDatedateTime(
                                widget!.docDocument!.date!),
                            notificationAt: _model.notificationAt,
                            isSave: widget!.docDocument?.isSave,
                            isExpenses: widget!.docDocument?.isExpenses,
                            isEvent: widget!.docDocument?.isEvent,
                            isNotificationScheduledSent: false,
                            isNotificationTodaySent: false,
                            isInternalTransfer: false,
                          ));
                          _model.action1 = DocumentsRecord.getDocumentFromData(
                              createDocumentsRecordData(
                                type: _model.type,
                                description: _model.description,
                                amount: _model.amount,
                                isRecurrent: _model.isRecurrent,
                                frequency: _model.frequency,
                                userRef: currentUserReference,
                                frequencyCode: () {
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
                                }(),
                                isIncome: widget!.docDocument?.isIncome,
                                date: functions.normalizeToCalendarDatedateTime(
                                    widget!.docDocument!.date!),
                                notificationAt: _model.notificationAt,
                                isSave: widget!.docDocument?.isSave,
                                isExpenses: widget!.docDocument?.isExpenses,
                                isEvent: widget!.docDocument?.isEvent,
                                isNotificationScheduledSent: false,
                                isNotificationTodaySent: false,
                                isInternalTransfer: false,
                              ),
                              documentsRecordReference1);

                          await _model.action1!.reference
                              .update(createDocumentsRecordData(
                            recurrenceId: _model.action1?.reference.id,
                            occurrenceKey: functions
                                .dateToOccurrenceKey(_model.action1!.date!),
                          ));
                          if (_model.action1?.isRecurrent == true) {
                            for (int loop3Index = 0;
                                loop3Index <
                                    functions
                                        .generateRecurrenceDatesByCode(
                                            _model.action1!.date!,
                                            _model.action1!.frequencyCode,
                                            false)
                                        .length;
                                loop3Index++) {
                              final currentLoop3Item =
                                  functions.generateRecurrenceDatesByCode(
                                      _model.action1!.date!,
                                      _model.action1!.frequencyCode,
                                      false)[loop3Index];

                              var documentsRecordReference2 =
                                  DocumentsRecord.collection.doc();
                              await documentsRecordReference2
                                  .set(createDocumentsRecordData(
                                type: _model.action1?.type,
                                isIncome: _model.action1?.isIncome,
                                description: _model.action1?.description,
                                date: functions.normalizeToCalendarDatedateTime(
                                    currentLoop3Item),
                                amount: _model.action1?.amount,
                                isRecurrent: _model.action1?.isRecurrent,
                                frequency: _model.action1?.frequency,
                                userRef: currentUserReference,
                                frequencyCode: _model.action1?.frequencyCode,
                                recurrenceId: _model.action1?.reference.id,
                                occurrenceKey: functions
                                    .dateToOccurrenceKey(currentLoop3Item),
                                notificationAt: _model.action1?.notificationAt,
                                isSave: _model.action1?.isSave,
                                isExpenses: _model.action1?.isExpenses,
                                isEvent: _model.action1?.isEvent,
                                isNotificationScheduledSent: false,
                                isNotificationTodaySent: false,
                                isInternalTransfer: false,
                              ));
                              _model.recurrente =
                                  DocumentsRecord.getDocumentFromData(
                                      createDocumentsRecordData(
                                        type: _model.action1?.type,
                                        isIncome: _model.action1?.isIncome,
                                        description:
                                            _model.action1?.description,
                                        date: functions
                                            .normalizeToCalendarDatedateTime(
                                                currentLoop3Item),
                                        amount: _model.action1?.amount,
                                        isRecurrent:
                                            _model.action1?.isRecurrent,
                                        frequency: _model.action1?.frequency,
                                        userRef: currentUserReference,
                                        frequencyCode:
                                            _model.action1?.frequencyCode,
                                        recurrenceId:
                                            _model.action1?.reference.id,
                                        occurrenceKey:
                                            functions.dateToOccurrenceKey(
                                                currentLoop3Item),
                                        notificationAt:
                                            _model.action1?.notificationAt,
                                        isSave: _model.action1?.isSave,
                                        isExpenses: _model.action1?.isExpenses,
                                        isEvent: _model.action1?.isEvent,
                                        isNotificationScheduledSent: false,
                                        isNotificationTodaySent: false,
                                        isInternalTransfer: false,
                                      ),
                                      documentsRecordReference2);
                            }
                          }
                        }
                      }
                    } else {
                      _model.docRecurrentes1 = await queryDocumentsRecordOnce(
                        queryBuilder: (documentsRecord) => documentsRecord
                            .where(
                              'userRef',
                              isEqualTo: currentUserReference,
                            )
                            .where(
                              'recurrenceId',
                              isEqualTo: widget!.docDocument?.recurrenceId,
                            ),
                      );
                      for (int loop4Index = 0;
                          loop4Index < _model.docRecurrentes1!.length;
                          loop4Index++) {
                        final currentLoop4Item =
                            _model.docRecurrentes1![loop4Index];

                        await currentLoop4Item.reference
                            .update(createDocumentsRecordData(
                          type: _model.type,
                          description: _model.description,
                          amount: _model.amount,
                        ));
                      }
                    }

                    Navigator.pop(context);

                    safeSetState(() {});
                  },
                  text: FFLocalizations.of(context).getText(
                    'u7rmh6bb' /* Editar */,
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
