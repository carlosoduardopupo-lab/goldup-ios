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
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'crear_recurr_de_docum_model.dart';
export 'crear_recurr_de_docum_model.dart';

class CrearRecurrDeDocumWidget extends StatefulWidget {
  const CrearRecurrDeDocumWidget({
    super.key,
    required this.docDocument,
  });

  final DocumentsRecord? docDocument;

  @override
  State<CrearRecurrDeDocumWidget> createState() =>
      _CrearRecurrDeDocumWidgetState();
}

class _CrearRecurrDeDocumWidgetState extends State<CrearRecurrDeDocumWidget> {
  late CrearRecurrDeDocumModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CrearRecurrDeDocumModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
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
        child: Form(
          key: _model.formKey,
          autovalidateMode: AutovalidateMode.disabled,
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
                          'w0ruz6ep' /* Crear Recurrencias */,
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
                      Container(
                        width: 423.1,
                        decoration: BoxDecoration(),
                        child: Visibility(
                          visible: widget!.docDocument?.description != null &&
                              widget!.docDocument?.description != '',
                          child: Text(
                            valueOrDefault<String>(
                              widget!.docDocument?.description,
                              'description',
                            ),
                            maxLines: 3,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
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
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (widget!.docDocument?.date != null &&
                          widget!.docDocument?.date != '')
                        Text(
                          valueOrDefault<String>(
                            widget!.docDocument?.date,
                            'date',
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
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 0.0, 0.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'zjrp7v70' /* Tipo */,
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
                          child: Align(
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 0.0, 0.0),
                              child: Text(
                                valueOrDefault<String>(
                                  widget!.docDocument?.type,
                                  'type',
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
                if (widget!.docDocument?.source == 'manual')
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
                              'gtqfm916' /* Descripción (opcional) */,
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
                          height: 137.4,
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
                                  'ddplluyk' /* Puedes dejar una breve descrip... */,
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
                if ((widget!.docDocument?.isEvent == false) &&
                    (widget!.docDocument?.source == 'manual'))
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
                              '0irue41v' /* Monto  */,
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
                            20.0, 0.0, 20.0, 15.0),
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
                                  'w78cnj02' /* Cantidad del efectivo... */,
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
                if (widget!.docDocument?.source == 'plaid')
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
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
                            value: _model.checkboxValue ??=
                                widget!.docDocument!.isRecurrent,
                            onChanged: (newValue) async {
                              safeSetState(
                                  () => _model.checkboxValue = newValue!);
                              if (newValue!) {
                                _model.isRecurrent = true;
                                safeSetState(() {});
                              } else {
                                _model.isRecurrent = false;
                                safeSetState(() {});
                                _model.frequency = 'frequency';
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
                            checkColor: FlutterFlowTheme.of(context).alternate,
                          ),
                        ),
                        Text(
                          FFLocalizations.of(context).getText(
                            'zchi2tj9' /* Este evento es recurrente */,
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
                              '053fngfg' /* Frecuencia */,
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
                          child: AuthUserStreamWidget(
                            builder: (context) => FlutterFlowDropDown<String>(
                              controller: _model.dropDownValueController1 ??=
                                  FormFieldController<String>(
                                _model.dropDownValue1 ??=
                                    widget!.docDocument?.frequency,
                              ),
                              options: [
                                FFLocalizations.of(context).getText(
                                  '1ey70vfi' /* Diario */,
                                ),
                                FFLocalizations.of(context).getText(
                                  '5boj6v3o' /* Semanal */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'mkt3inqz' /* Quincenal */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'kynn78un' /* Mensual */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'kbxr4nl8' /* Trimestral */,
                                ),
                                FFLocalizations.of(context).getText(
                                  '34ezcfou' /* Anual */,
                                )
                              ],
                              onChanged: (val) async {
                                safeSetState(() => _model.dropDownValue1 = val);
                                _model.frequency = _model.dropDownValue1;
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
                                'qn85z4yj' /* Seleccionar... */,
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
                              disabled: (valueOrDefault<bool>(
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
                if ((valueOrDefault<bool>(
                            currentUserDocument?.isPremium, false) ==
                        true) &&
                    (valueOrDefault(
                            currentUserDocument?.notificationAjustValue, 0) ==
                        2))
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
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
                                      '2tbb34uu' /* Ajustes de Notificación */,
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
                                      '7m54qhlm' /* ( Horas de antelación para rec... */,
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
                                    FormFieldController<String>(
                                  _model.dropDownValue2 ??= widget!
                                      .docDocument?.notificationAt
                                      ?.toString(),
                                ),
                                options: [
                                  FFLocalizations.of(context).getText(
                                    'vsy9uwn3' /* 24 */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    'cmpkyh1r' /* 48 */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    'ms6md2jw' /* 72 */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    'ds4c01bc' /* 96 */,
                                  )
                                ],
                                onChanged: (val) async {
                                  safeSetState(
                                      () => _model.dropDownValue2 = val);
                                  _model.notificationAt = () {
                                    if (_model.dropDownValue2 == '24') {
                                      return 24;
                                    } else if (_model.dropDownValue2 == '48') {
                                      return 48;
                                    } else if (_model.dropDownValue2 == '72') {
                                      return 72;
                                    } else if (_model.dropDownValue2 == '96') {
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
                        ],
                      ),
                    ),
                  ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 40.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      await widget!.docDocument!.reference.update({
                        ...createDocumentsRecordData(
                          recurrenceId: widget!.docDocument?.reference.id,
                          isRecurrent: true,
                          frequencyCode: () {
                            if ((_model.dropDownValue1 == 'Diario') ||
                                (_model.dropDownValue1 == 'Daily')) {
                              return 1;
                            } else if ((_model.dropDownValue1 == 'Semanal') ||
                                (_model.dropDownValue1 == 'Weekly')) {
                              return 7;
                            } else if ((_model.dropDownValue1 == 'Quincenal') ||
                                (_model.dropDownValue1 == 'Biweekly')) {
                              return 14;
                            } else if ((_model.dropDownValue1 == 'Mensual') ||
                                (_model.dropDownValue1 == 'Monthly')) {
                              return 1001;
                            } else if ((_model.dropDownValue1 ==
                                    'Trimestral') ||
                                (_model.dropDownValue1 == 'Quarterly')) {
                              return 1003;
                            } else if ((_model.dropDownValue1 == 'Anual') ||
                                (_model.dropDownValue1 == ' Annual')) {
                              return 1012;
                            } else {
                              return 0;
                            }
                          }(),
                          frequency: _model.dropDownValue1,
                          isConfirmed: true,
                        ),
                        ...mapToFirestore(
                          {
                            'updatedAt': FieldValue.serverTimestamp(),
                          },
                        ),
                      });
                      for (int loop1Index = 0;
                          loop1Index <
                              functions.generateRecurrenceDatesByCode(
                                  widget!.docDocument!.date, () {
                                if ((_model.dropDownValue1 == 'Diario') ||
                                    (_model.dropDownValue1 == 'Daily')) {
                                  return 1;
                                } else if ((_model.dropDownValue1 ==
                                        'Semanal') ||
                                    (_model.dropDownValue1 == 'Weekly')) {
                                  return 7;
                                } else if ((_model.dropDownValue1 ==
                                        'Quincenal') ||
                                    (_model.dropDownValue1 == 'Biweekly')) {
                                  return 14;
                                } else if ((_model.dropDownValue1 ==
                                        'Mensual') ||
                                    (_model.dropDownValue1 == 'Monthly')) {
                                  return 1001;
                                } else if ((_model.dropDownValue1 ==
                                        'Trimestral') ||
                                    (_model.dropDownValue1 == 'Quarterly')) {
                                  return 1003;
                                } else if ((_model.dropDownValue1 == 'Anual') ||
                                    (_model.dropDownValue1 == ' Annual')) {
                                  return 1012;
                                } else {
                                  return 0;
                                }
                              }(), false).length;
                          loop1Index++) {
                        final currentLoop1Item = functions
                            .generateRecurrenceDatesByCode(
                                widget!.docDocument!.date, () {
                          if ((_model.dropDownValue1 == 'Diario') ||
                              (_model.dropDownValue1 == 'Daily')) {
                            return 1;
                          } else if ((_model.dropDownValue1 == 'Semanal') ||
                              (_model.dropDownValue1 == 'Weekly')) {
                            return 7;
                          } else if ((_model.dropDownValue1 == 'Quincenal') ||
                              (_model.dropDownValue1 == 'Biweekly')) {
                            return 14;
                          } else if ((_model.dropDownValue1 == 'Mensual') ||
                              (_model.dropDownValue1 == 'Monthly')) {
                            return 1001;
                          } else if ((_model.dropDownValue1 == 'Trimestral') ||
                              (_model.dropDownValue1 == 'Quarterly')) {
                            return 1003;
                          } else if ((_model.dropDownValue1 == 'Anual') ||
                              (_model.dropDownValue1 == ' Annual')) {
                            return 1012;
                          } else {
                            return 0;
                          }
                        }(), false)[loop1Index];

                        var documentsRecordReference =
                            DocumentsRecord.collection.doc();
                        await documentsRecordReference.set({
                          ...createDocumentsRecordData(
                            type: widget!.docDocument?.type,
                            description: widget!.docDocument?.description,
                            date: currentLoop1Item,
                            amount: widget!.docDocument?.amount,
                            isRecurrent: true,
                            frequency: _model.dropDownValue1,
                            userRef: currentUserReference,
                            frequencyCode: () {
                              if ((_model.dropDownValue1 == 'Diario') ||
                                  (_model.dropDownValue1 == 'Daily')) {
                                return 1;
                              } else if ((_model.dropDownValue1 == 'Semanal') ||
                                  (_model.dropDownValue1 == 'Weekly')) {
                                return 7;
                              } else if ((_model.dropDownValue1 ==
                                      'Quincenal') ||
                                  (_model.dropDownValue1 == 'Biweekly')) {
                                return 14;
                              } else if ((_model.dropDownValue1 == 'Mensual') ||
                                  (_model.dropDownValue1 == 'Monthly')) {
                                return 1001;
                              } else if ((_model.dropDownValue1 ==
                                      'Trimestral') ||
                                  (_model.dropDownValue1 == 'Quarterly')) {
                                return 1003;
                              } else if ((_model.dropDownValue1 == 'Anual') ||
                                  (_model.dropDownValue1 == ' Annual')) {
                                return 1012;
                              } else {
                                return 0;
                              }
                            }(),
                            recurrenceId: widget!.docDocument?.reference.id,
                            occurrenceKey:
                                functions.dateToOccurrenceKey(currentLoop1Item),
                            notificationAt: 72,
                            isExpenses: widget!.docDocument?.isExpenses,
                            isIncome: widget!.docDocument?.isIncome,
                            isSave: widget!.docDocument?.isSave,
                            isEvent: widget!.docDocument?.isEvent,
                            source: widget!.docDocument?.source,
                            isNotificationScheduledSent: false,
                            isNotificationTodaySent: false,
                            isInternalTransfer:
                                widget!.docDocument?.isInternalTransfer,
                            createdAt: getCurrentTimestamp,
                            isPending: true,
                            isOtherExpenses:
                                widget!.docDocument?.isOtherExpenses,
                            isoCurrencyCode:
                                widget!.docDocument?.isoCurrencyCode,
                            personalFinanceCategoryPrimary: widget!
                                .docDocument?.personalFinanceCategoryPrimary,
                            personalFinanceCategoryDetailed: widget!
                                .docDocument?.personalFinanceCategoryDetailed,
                            subtype: widget!.docDocument?.subtype,
                            merchantName: widget!.docDocument?.merchantName,
                            merchantId: widget!.docDocument?.merchantId,
                            merchantWebsite:
                                widget!.docDocument?.merchantWebsite,
                            merchantLogo: widget!.docDocument?.merchantLogo,
                            accountName: widget!.docDocument?.accountName,
                            institutionName:
                                widget!.docDocument?.institutionName,
                            isConfirmed: true,
                            plaidAccountId: widget!.docDocument?.plaidAccountId,
                            isRealTransaction: false,
                            isRemoved: false,
                          ),
                          ...mapToFirestore(
                            {
                              'updatedAt': FieldValue.serverTimestamp(),
                            },
                          ),
                        });
                        _model.recurrente2 =
                            DocumentsRecord.getDocumentFromData({
                          ...createDocumentsRecordData(
                            type: widget!.docDocument?.type,
                            description: widget!.docDocument?.description,
                            date: currentLoop1Item,
                            amount: widget!.docDocument?.amount,
                            isRecurrent: true,
                            frequency: _model.dropDownValue1,
                            userRef: currentUserReference,
                            frequencyCode: () {
                              if ((_model.dropDownValue1 == 'Diario') ||
                                  (_model.dropDownValue1 == 'Daily')) {
                                return 1;
                              } else if ((_model.dropDownValue1 == 'Semanal') ||
                                  (_model.dropDownValue1 == 'Weekly')) {
                                return 7;
                              } else if ((_model.dropDownValue1 ==
                                      'Quincenal') ||
                                  (_model.dropDownValue1 == 'Biweekly')) {
                                return 14;
                              } else if ((_model.dropDownValue1 == 'Mensual') ||
                                  (_model.dropDownValue1 == 'Monthly')) {
                                return 1001;
                              } else if ((_model.dropDownValue1 ==
                                      'Trimestral') ||
                                  (_model.dropDownValue1 == 'Quarterly')) {
                                return 1003;
                              } else if ((_model.dropDownValue1 == 'Anual') ||
                                  (_model.dropDownValue1 == ' Annual')) {
                                return 1012;
                              } else {
                                return 0;
                              }
                            }(),
                            recurrenceId: widget!.docDocument?.reference.id,
                            occurrenceKey:
                                functions.dateToOccurrenceKey(currentLoop1Item),
                            notificationAt: 72,
                            isExpenses: widget!.docDocument?.isExpenses,
                            isIncome: widget!.docDocument?.isIncome,
                            isSave: widget!.docDocument?.isSave,
                            isEvent: widget!.docDocument?.isEvent,
                            source: widget!.docDocument?.source,
                            isNotificationScheduledSent: false,
                            isNotificationTodaySent: false,
                            isInternalTransfer:
                                widget!.docDocument?.isInternalTransfer,
                            createdAt: getCurrentTimestamp,
                            isPending: true,
                            isOtherExpenses:
                                widget!.docDocument?.isOtherExpenses,
                            isoCurrencyCode:
                                widget!.docDocument?.isoCurrencyCode,
                            personalFinanceCategoryPrimary: widget!
                                .docDocument?.personalFinanceCategoryPrimary,
                            personalFinanceCategoryDetailed: widget!
                                .docDocument?.personalFinanceCategoryDetailed,
                            subtype: widget!.docDocument?.subtype,
                            merchantName: widget!.docDocument?.merchantName,
                            merchantId: widget!.docDocument?.merchantId,
                            merchantWebsite:
                                widget!.docDocument?.merchantWebsite,
                            merchantLogo: widget!.docDocument?.merchantLogo,
                            accountName: widget!.docDocument?.accountName,
                            institutionName:
                                widget!.docDocument?.institutionName,
                            isConfirmed: true,
                            plaidAccountId: widget!.docDocument?.plaidAccountId,
                            isRealTransaction: false,
                            isRemoved: false,
                          ),
                          ...mapToFirestore(
                            {
                              'updatedAt': DateTime.now(),
                            },
                          ),
                        }, documentsRecordReference);
                      }
                      Navigator.pop(context);

                      safeSetState(() {});
                    },
                    text: FFLocalizations.of(context).getText(
                      '4qagjw75' /* Crear */,
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
