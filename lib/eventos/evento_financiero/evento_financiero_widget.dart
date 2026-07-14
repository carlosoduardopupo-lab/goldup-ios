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
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'evento_financiero_model.dart';
export 'evento_financiero_model.dart';

class EventoFinancieroWidget extends StatefulWidget {
  const EventoFinancieroWidget({super.key});

  @override
  State<EventoFinancieroWidget> createState() => _EventoFinancieroWidgetState();
}

class _EventoFinancieroWidgetState extends State<EventoFinancieroWidget> {
  late EventoFinancieroModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventoFinancieroModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

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

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Material(
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
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
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
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
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
                              '93b8tnns' /* Evento Financiero */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
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
                        ],
                      ),
                    ),
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
                                '0xxqjhk9' /* Tipo */,
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
                              controller: _model.dropDownValueController1 ??=
                                  FormFieldController<String>(null),
                              options: [
                                FFLocalizations.of(context).getText(
                                  '10z3vkmu' /* Cierre de ciclo (estado de cue... */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'h4ljv574' /* Fecha limite de pago de tarjet... */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'bxury6wy' /* Otro */,
                                )
                              ],
                              onChanged: (val) async {
                                safeSetState(() => _model.dropDownValue1 = val);
                                _model.type = _model.dropDownValue1;
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
                                'a7r0pfy8' /* Seleccionar... */,
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
                    if (valueOrDefault<bool>(
                            currentUserDocument?.isPremium, false) ==
                        false)
                      AuthUserStreamWidget(
                        builder: (context) => Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    '9facd9y2' /* Descripción  */,
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
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                  ),
                                ),
                                child: Container(
                                  width: 200.0,
                                  child: TextFormField(
                                    controller: _model.textController,
                                    focusNode: _model.textFieldFocusNode,
                                    onChanged: (_) => EasyDebounce.debounce(
                                      '_model.textController',
                                      Duration(milliseconds: 2000),
                                      () async {
                                        _model.description =
                                            _model.textController.text;
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
                                        'd8p6cbb7' /* Nombre del banco y cuatro últi... */,
                                      ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.roboto(
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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
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
                                    cursorColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    enableInteractiveSelection: true,
                                    validator: _model.textControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (valueOrDefault<bool>(
                            currentUserDocument?.isPremium, false) ==
                        true)
                      AuthUserStreamWidget(
                        builder: (context) => Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'mfji1o8n' /* tarjeta */,
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
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                  ),
                                ),
                                child: StreamBuilder<List<BankAccountsRecord>>(
                                  stream: queryBankAccountsRecord(
                                    queryBuilder: (bankAccountsRecord) =>
                                        bankAccountsRecord
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
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    List<BankAccountsRecord>
                                        dropDownBankAccountsRecordList =
                                        snapshot.data!;

                                    return FlutterFlowDropDown<String>(
                                      controller:
                                          _model.dropDownValueController2 ??=
                                              FormFieldController<String>(null),
                                      options: functions.joinBankAccountTexts(
                                          dropDownBankAccountsRecordList
                                              .toList(),
                                          '...')!,
                                      onChanged: (val) async {
                                        safeSetState(
                                            () => _model.dropDownValue2 = val);
                                        _model.creditCardName =
                                            _model.dropDownValue2;
                                        safeSetState(() {});
                                      },
                                      width: 200.0,
                                      height: 0.0,
                                      textStyle: FlutterFlowTheme.of(context)
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
                                      hintText:
                                          FFLocalizations.of(context).getText(
                                        'yab7m1ud' /* Select... */,
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
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                              side: (FlutterFlowTheme.of(context).alternate !=
                                      null)
                                  ? BorderSide(
                                      width: 2,
                                      color: FlutterFlowTheme.of(context)
                                          .alternate!,
                                    )
                                  : null,
                              activeColor: Color(0xFF01654D),
                              checkColor:
                                  FlutterFlowTheme.of(context).alternate,
                            ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              '0wki6db1' /* Evento recurrente */,
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
                                  'frjhwr9z' /* Frecuencia */,
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
                                controller: _model.dropDownValueController3 ??=
                                    FormFieldController<String>(null),
                                options: [
                                  FFLocalizations.of(context).getText(
                                    'te2wgo3p' /* Diario */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    'uvn0bjp4' /* Semanal */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    'kdk9djpz' /* Quincenal */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    'z5noo9we' /* Mensual */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    '915h7dzd' /* Trimestral */,
                                  ),
                                  FFLocalizations.of(context).getText(
                                    'r5rhan46' /* Anual */,
                                  )
                                ],
                                onChanged: (val) async {
                                  safeSetState(
                                      () => _model.dropDownValue3 = val);
                                  _model.frequency = _model.dropDownValue3;
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
                                  '15z3nurd' /* Seleccionar... */,
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
                                          '9urakpya' /* Ajustes de Notificación */,
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
                                          'ikhpmb78' /* ( Horas de antelación para rec... */,
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
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                  ),
                                ),
                                child: FlutterFlowDropDown<String>(
                                  controller:
                                      _model.dropDownValueController4 ??=
                                          FormFieldController<String>(
                                    _model.dropDownValue4 ??=
                                        FFLocalizations.of(context).getText(
                                      'o86d6um1' /* 72 */,
                                    ),
                                  ),
                                  options: [
                                    FFLocalizations.of(context).getText(
                                      '149njvbe' /* 24 */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      '4xlwol1r' /* 48 */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      '0gb1aq95' /* 72 */,
                                    ),
                                    FFLocalizations.of(context).getText(
                                      '6mvf0k4v' /* 96 */,
                                    )
                                  ],
                                  onChanged: (val) async {
                                    safeSetState(
                                        () => _model.dropDownValue4 = val);
                                    _model.notificationAt = () {
                                      if (_model.dropDownValue4 == '24') {
                                        return 24;
                                      } else if (_model.dropDownValue4 ==
                                          '48') {
                                        return 48;
                                      } else if (_model.dropDownValue4 ==
                                          '72') {
                                        return 72;
                                      } else if (_model.dropDownValue4 ==
                                          '96') {
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
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 40.0),
                      child: FFButtonWidget(
                        onPressed: (_model.type == null || _model.type == '')
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
                                  description: valueOrDefault<bool>(
                                              currentUserDocument?.isPremium,
                                              false) ==
                                          true
                                      ? _model.creditCardName
                                      : _model.description,
                                  date:
                                      functions.normalizeToCalendarDatedateTime(
                                          FFAppState().selectedDate!),
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
                                    } else if ((_model.frequency == 'Anual') ||
                                        (_model.frequency == 'Annual')) {
                                      return 1012;
                                    } else {
                                      return 0;
                                    }
                                  }(),
                                  notificationAt: _model.notificationAt,
                                  isIncome: false,
                                  isSave: false,
                                  isExpenses: false,
                                  isEvent: true,
                                  source: valueOrDefault<bool>(
                                              currentUserDocument?.isPremium,
                                              false) ==
                                          true
                                      ? 'plaid'
                                      : 'manual',
                                  isGoal: false,
                                  isNotificationScheduledSent: false,
                                  isNotificationTodaySent: false,
                                  isInternalTransfer: false,
                                  createdAt: getCurrentTimestamp,
                                  occurrenceKey: functions.dateToOccurrenceKey(
                                      functions.normalizeToCalendarDatedateTime(
                                          FFAppState().selectedDate!)),
                                  creditCardName: _model.creditCardName,
                                ));
                                _model.action1 =
                                    DocumentsRecord.getDocumentFromData(
                                        createDocumentsRecordData(
                                          type: _model.type,
                                          description: valueOrDefault<bool>(
                                                      currentUserDocument
                                                          ?.isPremium,
                                                      false) ==
                                                  true
                                              ? _model.creditCardName
                                              : _model.description,
                                          date: functions
                                              .normalizeToCalendarDatedateTime(
                                                  FFAppState().selectedDate!),
                                          isRecurrent: _model.isRecurrent,
                                          frequency: _model.frequency,
                                          userRef: currentUserReference,
                                          frequencyCode: () {
                                            if ((_model.frequency ==
                                                    'Diario') ||
                                                (_model.frequency == 'Daily')) {
                                              return 1;
                                            } else if ((_model.frequency ==
                                                    'Semanal') ||
                                                (_model.frequency ==
                                                    'Weekly')) {
                                              return 7;
                                            } else if ((_model.frequency ==
                                                    'Quincenal') ||
                                                (_model.frequency ==
                                                    'Biweekly')) {
                                              return 14;
                                            } else if ((_model.frequency ==
                                                    'Mensual') ||
                                                (_model.frequency ==
                                                    'Monthly')) {
                                              return 1001;
                                            } else if ((_model.frequency ==
                                                    'Trimestral') ||
                                                (_model.frequency ==
                                                    'Quarterly')) {
                                              return 1003;
                                            } else if ((_model.frequency ==
                                                    'Anual') ||
                                                (_model.frequency ==
                                                    'Annual')) {
                                              return 1012;
                                            } else {
                                              return 0;
                                            }
                                          }(),
                                          notificationAt: _model.notificationAt,
                                          isIncome: false,
                                          isSave: false,
                                          isExpenses: false,
                                          isEvent: true,
                                          source: valueOrDefault<bool>(
                                                      currentUserDocument
                                                          ?.isPremium,
                                                      false) ==
                                                  true
                                              ? 'plaid'
                                              : 'manual',
                                          isGoal: false,
                                          isNotificationScheduledSent: false,
                                          isNotificationTodaySent: false,
                                          isInternalTransfer: false,
                                          createdAt: getCurrentTimestamp,
                                          occurrenceKey: functions
                                              .dateToOccurrenceKey(functions
                                                  .normalizeToCalendarDatedateTime(
                                                      FFAppState()
                                                          .selectedDate!)),
                                          creditCardName: _model.creditCardName,
                                        ),
                                        documentsRecordReference1);

                                await _model.action1!.reference
                                    .update(createDocumentsRecordData(
                                  recurrenceId: _model.action1?.reference.id,
                                ));
                                if (_model.action1?.isRecurrent == true) {
                                  for (int loop1Index = 0;
                                      loop1Index <
                                          functions
                                              .generateRecurrenceDatesByCode(
                                                  functions
                                                      .normalizeToCalendarDatedateTime(
                                                          FFAppState()
                                                              .selectedDate!),
                                                  _model.action1!.frequencyCode,
                                                  false)
                                              .length;
                                      loop1Index++) {
                                    final currentLoop1Item =
                                        functions.generateRecurrenceDatesByCode(
                                            functions
                                                .normalizeToCalendarDatedateTime(
                                                    FFAppState().selectedDate!),
                                            _model.action1!.frequencyCode,
                                            false)[loop1Index];

                                    var documentsRecordReference2 =
                                        DocumentsRecord.collection.doc();
                                    await documentsRecordReference2
                                        .set(createDocumentsRecordData(
                                      type: _model.type,
                                      description: valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isPremium,
                                                  false) ==
                                              true
                                          ? _model.creditCardName
                                          : _model.description,
                                      date: currentLoop1Item,
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
                                      isIncome: false,
                                      isSave: false,
                                      isExpenses: false,
                                      isEvent: true,
                                      source: valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isPremium,
                                                  false) ==
                                              true
                                          ? 'plaid'
                                          : 'manual',
                                      isGoal: false,
                                      isNotificationScheduledSent: false,
                                      isNotificationTodaySent: false,
                                      isInternalTransfer: false,
                                      createdAt: getCurrentTimestamp,
                                      creditCardName: _model.creditCardName,
                                    ));
                                    _model.duplicado =
                                        DocumentsRecord.getDocumentFromData(
                                            createDocumentsRecordData(
                                              type: _model.type,
                                              description: valueOrDefault<bool>(
                                                          currentUserDocument
                                                              ?.isPremium,
                                                          false) ==
                                                      true
                                                  ? _model.creditCardName
                                                  : _model.description,
                                              date: currentLoop1Item,
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
                                              notificationAt: _model
                                                  .action1?.notificationAt,
                                              isIncome: false,
                                              isSave: false,
                                              isExpenses: false,
                                              isEvent: true,
                                              source: valueOrDefault<bool>(
                                                          currentUserDocument
                                                              ?.isPremium,
                                                          false) ==
                                                      true
                                                  ? 'plaid'
                                                  : 'manual',
                                              isGoal: false,
                                              isNotificationScheduledSent:
                                                  false,
                                              isNotificationTodaySent: false,
                                              isInternalTransfer: false,
                                              createdAt: getCurrentTimestamp,
                                              creditCardName:
                                                  _model.creditCardName,
                                            ),
                                            documentsRecordReference2);
                                  }
                                }

                                await currentUserReference!
                                    .update(createUserRecordData(
                                  isDocumentCreated: true,
                                ));
                                Navigator.pop(context);
                                await requestPermission(
                                    notificationsPermission);

                                safeSetState(() {});
                              },
                        text: FFLocalizations.of(context).getText(
                          'ak2vobvh' /* Añadir */,
                        ),
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 50.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
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
        ),
      ],
    );
  }
}
