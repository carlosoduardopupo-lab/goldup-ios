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
import '/flutter_flow/permissions_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'ingreso_model.dart';
export 'ingreso_model.dart';

class IngresoWidget extends StatefulWidget {
  const IngresoWidget({super.key});

  @override
  State<IngresoWidget> createState() => _IngresoWidgetState();
}

class _IngresoWidgetState extends State<IngresoWidget> {
  late IngresoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IngresoModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.amount = 0.0;
      safeSetState(() {});
    });

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
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
    context.watch<FFAppState>();

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
        child: Form(
          key: _model.formKey,
          autovalidateMode: AutovalidateMode.disabled,
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
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        FFLocalizations.of(context).getText(
                          'nak72f8v' /* Ingreso */,
                        ),
                        style:
                            FlutterFlowTheme.of(context).headlineSmall.override(
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
                    ].divide(SizedBox(width: 29.0)),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        dateTimeFormat(
                          "MMMMEEEEd",
                          FFAppState().selectedDate,
                          locale: FFLocalizations.of(context).languageCode,
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
                    ],
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
                            'r1xf2ued' /* Tipo */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
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
                              FormFieldController<String>(null),
                          options: [
                            FFLocalizations.of(context).getText(
                              'hxjfhexu' /* Salario */,
                            ),
                            FFLocalizations.of(context).getText(
                              'jws6ym4z' /* Propinas */,
                            ),
                            FFLocalizations.of(context).getText(
                              'xluem7ez' /* Comisiones */,
                            ),
                            FFLocalizations.of(context).getText(
                              'iu2eex6q' /* Venta */,
                            ),
                            FFLocalizations.of(context).getText(
                              'zvvg5616' /* Regalias */,
                            ),
                            FFLocalizations.of(context).getText(
                              '0y09ie3m' /* Préstamo */,
                            ),
                            FFLocalizations.of(context).getText(
                              'hd7c4du0' /* Otro */,
                            )
                          ],
                          onChanged: (val) async {
                            safeSetState(() => _model.dropDownValue1 = val);
                            _model.type = _model.dropDownValue1;
                            safeSetState(() {});
                          },
                          width: 200.0,
                          height: 40.0,
                          textStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
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
                          hintText: FFLocalizations.of(context).getText(
                            'nbkstgz0' /* Seleccionar... */,
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
                            '1jsp3k3f' /* Descripción  */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
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
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        height: 137.42,
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
                            controller: _model.textController1,
                            focusNode: _model.textFieldFocusNode1,
                            onChanged: (_) => EasyDebounce.debounce(
                              '_model.textController1',
                              Duration(milliseconds: 2000),
                              () async {
                                _model.description =
                                    _model.textController1.text;
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
                                    font: GoogleFonts.roboto(
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
                                'shv786po' /* Puedes dejar una breve descrip... */,
                              ),
                              hintStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    font: GoogleFonts.roboto(
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
                            cursorColor:
                                FlutterFlowTheme.of(context).primaryText,
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
                            '87jnqffd' /* Monto  */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
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
                                _model.amount =
                                    _model.textController2.text != null &&
                                            _model.textController2.text != ''
                                        ? double.tryParse(
                                            _model.textController2.text)
                                        : 0.0;
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
                                    font: GoogleFonts.roboto(
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
                                '3eyn3nhx' /* 0.0 */,
                              ),
                              hintStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    font: GoogleFonts.roboto(
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Theme(
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
                          value: _model.checkboxValue ??= false,
                          onChanged: (newValue) async {
                            safeSetState(
                                () => _model.checkboxValue = newValue!);
                            if (newValue!) {
                              _model.isRecurrent = true;
                              safeSetState(() {});
                            } else {
                              _model.isRecurrent = false;
                              safeSetState(() {});
                              _model.frequency = null;
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
                          checkColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                        ),
                      ),
                      Text(
                        FFLocalizations.of(context).getText(
                          '8do17dfy' /* Ingreso recurrente */,
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
                    ],
                  ),
                ),
                if (_model.isRecurrent == true)
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
                              'pktf0xea' /* Frecuencia */,
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
                            controller: _model.dropDownValueController2 ??=
                                FormFieldController<String>(null),
                            options: [
                              FFLocalizations.of(context).getText(
                                't7vddq58' /* Diario */,
                              ),
                              FFLocalizations.of(context).getText(
                                'tlq2y488' /* Semanal */,
                              ),
                              FFLocalizations.of(context).getText(
                                '72nvpdza' /* Quincenal */,
                              ),
                              FFLocalizations.of(context).getText(
                                'ezxtnhn8' /* Mensual */,
                              ),
                              FFLocalizations.of(context).getText(
                                'xv0oc039' /* Trimestral */,
                              ),
                              FFLocalizations.of(context).getText(
                                '6gtu0op4' /* Anual */,
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
                            hintText: FFLocalizations.of(context).getText(
                              '62wcjb56' /* Seleccionar... */,
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
                if (valueOrDefault(
                        currentUserDocument?.notificationAjustValue, 0) ==
                    2)
                  AuthUserStreamWidget(
                    builder: (context) => Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
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
                                      'sqy09t8s' /* Ajustes de Notificación */,
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
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      '85b3ytpz' /* ( Horas de antelación para rec... */,
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
                                          color: FlutterFlowTheme.of(context)
                                              .accent2,
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
                              controller: _model.dropDownValueController3 ??=
                                  FormFieldController<String>(
                                _model.dropDownValue3 ??=
                                    FFLocalizations.of(context).getText(
                                  'yf8m56h4' /* 72 */,
                                ),
                              ),
                              options: [
                                FFLocalizations.of(context).getText(
                                  'qexd8ak6' /* 24 */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'ucqacvm7' /* 48 */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'tpj0gnuf' /* 72 */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'zuw6a6fr' /* 96 */,
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
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 40.0),
                  child: FFButtonWidget(
                    onPressed: ((_model.type == null || _model.type == '') ||
                            (_model.description == null ||
                                _model.description == '') ||
                            (_model.amount! <= 0.0))
                        ? null
                        : () async {
                            if (_model.formKey.currentState == null ||
                                !_model.formKey.currentState!.validate()) {
                              return;
                            }

                            var documentsRecordReference1 =
                                DocumentsRecord.collection.doc();
                            await documentsRecordReference1
                                .set(createDocumentsRecordData(
                              type: _model.type,
                              isIncome: true,
                              description: _model.description,
                              date: functions.normalizeToCalendarDatedateTime(
                                  FFAppState().selectedDate!),
                              amount: _model.amount,
                              isRecurrent: _model.isRecurrent,
                              frequency: _model.frequency,
                              userRef: currentUserReference,
                              frequencyCode: () {
                                if ((_model.frequency == 'Diario') ||
                                    (_model.frequency == 'Daily')) {
                                  return 1;
                                } else if ((_model.frequency == 'Semanal') ||
                                    (_model.frequency == 'Weekly')) {
                                  return 7;
                                } else if ((_model.frequency == 'Quincenal') ||
                                    (_model.frequency == 'Biweekly')) {
                                  return 14;
                                } else if ((_model.frequency == 'Mensual') ||
                                    (_model.frequency == 'Monthly')) {
                                  return 1001;
                                } else if ((_model.frequency == 'Trimestral') ||
                                    (_model.frequency == 'Quarterly')) {
                                  return 1003;
                                } else if ((_model.frequency == 'Anual') ||
                                    (_model.frequency == 'Annual')) {
                                  return 1012;
                                } else {
                                  return 0;
                                }
                              }(),
                              notificationAt: _model.notificationAt,
                              isSave: false,
                              isExpenses: false,
                              isEvent: false,
                              source: 'manual',
                              isGoal: false,
                              isNotificationScheduledSent: false,
                              isNotificationTodaySent: false,
                              isInternalTransfer: false,
                              createdAt: getCurrentTimestamp,
                              occurrenceKey: functions.dateToOccurrenceKey(
                                  functions.normalizeToCalendarDatedateTime(
                                      FFAppState().selectedDate!)),
                              isRemoved: false,
                              isRealTransaction: false,
                            ));
                            _model.action1 =
                                DocumentsRecord.getDocumentFromData(
                                    createDocumentsRecordData(
                                      type: _model.type,
                                      isIncome: true,
                                      description: _model.description,
                                      date: functions
                                          .normalizeToCalendarDatedateTime(
                                              FFAppState().selectedDate!),
                                      amount: _model.amount,
                                      isRecurrent: _model.isRecurrent,
                                      frequency: _model.frequency,
                                      userRef: currentUserReference,
                                      frequencyCode: () {
                                        if ((_model.frequency == 'Diario') ||
                                            (_model.frequency == 'Daily')) {
                                          return 1;
                                        } else if ((_model.frequency ==
                                                'Semanal') ||
                                            (_model.frequency == 'Weekly')) {
                                          return 7;
                                        } else if ((_model.frequency ==
                                                'Quincenal') ||
                                            (_model.frequency == 'Biweekly')) {
                                          return 14;
                                        } else if ((_model.frequency ==
                                                'Mensual') ||
                                            (_model.frequency == 'Monthly')) {
                                          return 1001;
                                        } else if ((_model.frequency ==
                                                'Trimestral') ||
                                            (_model.frequency == 'Quarterly')) {
                                          return 1003;
                                        } else if ((_model.frequency ==
                                                'Anual') ||
                                            (_model.frequency == 'Annual')) {
                                          return 1012;
                                        } else {
                                          return 0;
                                        }
                                      }(),
                                      notificationAt: _model.notificationAt,
                                      isSave: false,
                                      isExpenses: false,
                                      isEvent: false,
                                      source: 'manual',
                                      isGoal: false,
                                      isNotificationScheduledSent: false,
                                      isNotificationTodaySent: false,
                                      isInternalTransfer: false,
                                      createdAt: getCurrentTimestamp,
                                      occurrenceKey: functions
                                          .dateToOccurrenceKey(functions
                                              .normalizeToCalendarDatedateTime(
                                                  FFAppState().selectedDate!)),
                                      isRemoved: false,
                                      isRealTransaction: false,
                                    ),
                                    documentsRecordReference1);

                            await _model.action1!.reference
                                .update(createDocumentsRecordData(
                              isPending: _model.action1!.occurrenceKey <=
                                      functions.dateToOccurrenceKey(functions
                                          .normalizeToCalendarDatedateTime(
                                              getCurrentTimestamp))
                                  ? false
                                  : true,
                              recurrenceId: _model.action1?.reference.id,
                            ));
                            if (_model.action1?.isRecurrent == true) {
                              for (int loop1Index = 0;
                                  loop1Index <
                                      functions
                                          .generateRecurrenceDatesByCode(
                                              _model.action1!.date,
                                              _model.action1!.frequencyCode,
                                              false)
                                          .length;
                                  loop1Index++) {
                                final currentLoop1Item =
                                    functions.generateRecurrenceDatesByCode(
                                        _model.action1!.date,
                                        _model.action1!.frequencyCode,
                                        false)[loop1Index];

                                var documentsRecordReference2 =
                                    DocumentsRecord.collection.doc();
                                await documentsRecordReference2
                                    .set(createDocumentsRecordData(
                                  type: _model.type,
                                  isIncome: true,
                                  description: _model.description,
                                  date: currentLoop1Item,
                                  amount: _model.amount,
                                  isRecurrent: true,
                                  frequency: _model.frequency,
                                  userRef: currentUserReference,
                                  frequencyCode: _model.action1?.frequencyCode,
                                  recurrenceId: _model.action1?.reference.id,
                                  occurrenceKey: functions
                                      .dateToOccurrenceKey(currentLoop1Item),
                                  notificationAt:
                                      _model.action1?.notificationAt,
                                  isSave: false,
                                  isExpenses: false,
                                  isEvent: false,
                                  source: 'manual',
                                  isGoal: false,
                                  isNotificationScheduledSent: false,
                                  isNotificationTodaySent: false,
                                  isInternalTransfer: false,
                                  createdAt: _model.action1?.createdAt,
                                  isRemoved: false,
                                  isRealTransaction: false,
                                ));
                                _model.recurrente =
                                    DocumentsRecord.getDocumentFromData(
                                        createDocumentsRecordData(
                                          type: _model.type,
                                          isIncome: true,
                                          description: _model.description,
                                          date: currentLoop1Item,
                                          amount: _model.amount,
                                          isRecurrent: true,
                                          frequency: _model.frequency,
                                          userRef: currentUserReference,
                                          frequencyCode:
                                              _model.action1?.frequencyCode,
                                          recurrenceId:
                                              _model.action1?.reference.id,
                                          occurrenceKey:
                                              functions.dateToOccurrenceKey(
                                                  currentLoop1Item),
                                          notificationAt:
                                              _model.action1?.notificationAt,
                                          isSave: false,
                                          isExpenses: false,
                                          isEvent: false,
                                          source: 'manual',
                                          isGoal: false,
                                          isNotificationScheduledSent: false,
                                          isNotificationTodaySent: false,
                                          isInternalTransfer: false,
                                          createdAt: _model.action1?.createdAt,
                                          isRemoved: false,
                                          isRealTransaction: false,
                                        ),
                                        documentsRecordReference2);
                              }

                              await _model.recurrente!.reference
                                  .update(createDocumentsRecordData(
                                isPending: _model.recurrente!.occurrenceKey <=
                                        functions.dateToOccurrenceKey(functions
                                            .normalizeToCalendarDatedateTime(
                                                getCurrentTimestamp))
                                    ? false
                                    : true,
                              ));
                            }

                            await currentUserReference!
                                .update(createUserRecordData(
                              isDocumentCreated: true,
                              isIncomeCreated: true,
                            ));
                            Navigator.pop(context);
                            await requestPermission(notificationsPermission);

                            safeSetState(() {});
                          },
                    text: FFLocalizations.of(context).getText(
                      'ubns1aom' /* Añadir */,
                    ),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 50.0,
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
                      disabledColor: Color(0xFF01A47B),
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
      ),
    );
  }
}
