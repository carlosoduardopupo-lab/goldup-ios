import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'recurren_card_model.dart';
export 'recurren_card_model.dart';

class RecurrenCardWidget extends StatefulWidget {
  const RecurrenCardWidget({
    super.key,
    required this.docTransact,
  });

  final DocumentsRecord? docTransact;

  @override
  State<RecurrenCardWidget> createState() => _RecurrenCardWidgetState();
}

class _RecurrenCardWidgetState extends State<RecurrenCardWidget> {
  late RecurrenCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RecurrenCardModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
        child: Container(
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
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 234.73,
                  decoration: BoxDecoration(),
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: 0.6,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            () {
                              if (widget!.docTransact?.isIncome == true) {
                                return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/calendar-ten2s9/assets/xm9lw0eysdgi/Copilot_20260126_230246.png';
                              } else if (widget!.docTransact?.isExpenses ==
                                  true) {
                                return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/calendar-ten2s9/assets/sh0f79asn46p/Copilot_20260126_230924.png';
                              } else if (widget!.docTransact?.isSave == true) {
                                return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/calendar-ten2s9/assets/wehgeiteiicx/Copilot_20260211_232303.png';
                              } else if (widget!.docTransact?.isEvent == true) {
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
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 10.0, 0.0, 10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, -0.65),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 16.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 10.0, 0.0),
                                              child: Text(
                                                dateTimeFormat(
                                                  "MMMMEEEEd",
                                                  functions.stringToDateTime(
                                                      widget!
                                                          .docTransact?.date),
                                                  locale: FFLocalizations.of(
                                                          context)
                                                      .languageCode,
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
                                          Container(
                                            decoration: BoxDecoration(),
                                            child: Visibility(
                                              visible: widget!
                                                          .docTransact?.type !=
                                                      null &&
                                                  widget!.docTransact?.type !=
                                                      '',
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    widget!.docTransact?.type,
                                                    'type',
                                                  ),
                                                  maxLines: 3,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.roboto(
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
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if (widget!.docTransact?.accountName !=
                                                null &&
                                            widget!.docTransact?.accountName !=
                                                '')
                                          Text(
                                            valueOrDefault<String>(
                                              widget!.docTransact?.accountName,
                                              'accountName',
                                            ),
                                            style: FlutterFlowTheme.of(context)
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
                                        Align(
                                          alignment:
                                              AlignmentDirectional(1.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              if (widget!.docTransact
                                                          ?.institutionName !=
                                                      null &&
                                                  widget!.docTransact
                                                          ?.institutionName !=
                                                      '')
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          1.0, 0.0),
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      widget!.docTransact
                                                          ?.institutionName,
                                                      'institutionName',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .roboto(
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
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ].divide(SizedBox(width: 15.0)),
                                ),
                              ),
                            ),
                            if (widget!.docTransact!.amount > 0.0)
                              Text(
                                valueOrDefault<String>(
                                  formatNumber(
                                    widget!.docTransact?.amount,
                                    formatType: FormatType.decimal,
                                    decimalType: DecimalType.automatic,
                                    currency: '\$',
                                  ),
                                  '0',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            if (widget!.docTransact?.description != null &&
                                widget!.docTransact?.description != '')
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 10.0, 20.0, 10.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    widget!.docTransact?.description,
                                    'description',
                                  ),
                                  maxLines: 10,
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
                                            .primary,
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
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 16.0, 10.0),
                              child: Container(
                                decoration: BoxDecoration(),
                              ),
                            ),
                            if (widget!.docTransact?.source == 'plaid')
                              Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 16.0, 9.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '1j3nv1o3' /* Categoría */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyLarge
                                                    .override(
                                                      font: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontStyle,
                                                      ),
                                                      fontSize: 14.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLarge
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: Text(
                                          valueOrDefault<String>(
                                            widget!.docTransact
                                                ?.personalFinanceCategoryPrimary,
                                            'personalFinanceCategoryPrimary',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                font: GoogleFonts.roboto(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              if (widget!.docTransact
                                                          ?.merchantName !=
                                                      null &&
                                                  widget!.docTransact
                                                          ?.merchantName !=
                                                      '')
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'reo27cbf' /* Información del Comercio */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyLarge
                                                        .override(
                                                          font: GoogleFonts
                                                              .roboto(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          if (widget!.docTransact
                                                      ?.merchantName !=
                                                  null &&
                                              widget!.docTransact
                                                      ?.merchantName !=
                                                  '')
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Container(
                                                decoration: BoxDecoration(),
                                                child: RichText(
                                                  textScaler:
                                                      MediaQuery.of(context)
                                                          .textScaler,
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                          'yl3jqy7x' /* Nombre:  */,
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
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                      TextSpan(
                                                        text: valueOrDefault<
                                                            String>(
                                                          widget!.docTransact
                                                              ?.merchantName,
                                                          'merchantName',
                                                        ),
                                                        style: TextStyle(),
                                                      )
                                                    ],
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .roboto(
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
                                                ),
                                              ),
                                            ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Container(
                                              width: 432.7,
                                              decoration: BoxDecoration(),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Container(
                                              decoration: BoxDecoration(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ].addToEnd(SizedBox(height: 10.0)),
                        ),
                      ),
                    ],
                  ),
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
                              FlutterFlowTheme.of(context).primaryText,
                        ),
                        child: Checkbox(
                          value: _model.checkboxValue ??= false,
                          onChanged: (newValue) async {
                            safeSetState(
                                () => _model.checkboxValue = newValue!);
                          },
                          side: (FlutterFlowTheme.of(context).primaryText !=
                                  null)
                              ? BorderSide(
                                  width: 2,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText!,
                                )
                              : null,
                          activeColor: Color(0xFF01654D),
                          checkColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                        ),
                      ),
                      Text(
                        FFLocalizations.of(context).getText(
                          'uvdiedcm' /* Transacción recurrente */,
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
                if (_model.checkboxValue == true)
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 19.0),
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
                                'p9y37r8x' /* Frecuencia */,
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
                              controller: _model.dropDownValueController ??=
                                  FormFieldController<String>(null),
                              options: [
                                FFLocalizations.of(context).getText(
                                  '11l6rvlq' /* Diario */,
                                ),
                                FFLocalizations.of(context).getText(
                                  '711w7vsx' /* Semanal */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'uteetwvo' /* Quincenal */,
                                ),
                                FFLocalizations.of(context).getText(
                                  '731m8ckp' /* Mensual */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'wylngybm' /* Trimestral */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'fzb1qn35' /* Anual */,
                                )
                              ],
                              onChanged: (val) => safeSetState(
                                  () => _model.dropDownValue = val),
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
                                'oleeax14' /* Seleccionar... */,
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 24.0,
                              ),
                              fillColor: FlutterFlowTheme.of(context)
                                  .primaryBackground,
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
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: (_model.dropDownValue == null ||
                                  _model.dropDownValue == '')
                              ? null
                              : () async {
                                  if (_model.checkboxValue == true) {
                                    await widget!.docTransact!.reference
                                        .update({
                                      ...createDocumentsRecordData(
                                        recurrenceId:
                                            widget!.docTransact?.recurrenceId,
                                        isRecurrent: true,
                                        frequencyCode: () {
                                          if ((_model.dropDownValue ==
                                                  'Diario') ||
                                              (_model.dropDownValue ==
                                                  'Daily')) {
                                            return 1;
                                          } else if ((_model.dropDownValue ==
                                                  'Semanal') ||
                                              (_model.dropDownValue ==
                                                  'Weekly')) {
                                            return 7;
                                          } else if ((_model.dropDownValue ==
                                                  'Quincenal') ||
                                              (_model.dropDownValue ==
                                                  'Biweekly')) {
                                            return 14;
                                          } else if ((_model.dropDownValue ==
                                                  'Mensual') ||
                                              (_model.dropDownValue ==
                                                  'Monthly')) {
                                            return 1001;
                                          } else if ((_model.dropDownValue ==
                                                  'Trimestral') ||
                                              (_model.dropDownValue ==
                                                  'Quarterly')) {
                                            return 1003;
                                          } else if ((_model.dropDownValue ==
                                                  'Anual') ||
                                              (_model.dropDownValue ==
                                                  ' Annual')) {
                                            return 1012;
                                          } else {
                                            return 0;
                                          }
                                        }(),
                                        frequency: _model.dropDownValue,
                                        isConfirmed: true,
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'updatedAt':
                                              FieldValue.serverTimestamp(),
                                        },
                                      ),
                                    });
                                    for (int loop1Index = 0;
                                        loop1Index <
                                            functions
                                                .generateRecurrenceDatesByCode(
                                                    widget!.docTransact!.date,
                                                    () {
                                              if (_model.dropDownValue ==
                                                  'Diario') {
                                                return 1;
                                              } else if (_model.dropDownValue ==
                                                  'Semanal') {
                                                return 7;
                                              } else if (_model.dropDownValue ==
                                                  'Quincenal') {
                                                return 14;
                                              } else if (_model.dropDownValue ==
                                                  'Mensual') {
                                                return 1001;
                                              } else if (_model.dropDownValue ==
                                                  'Trimestral') {
                                                return 1003;
                                              } else if (_model.dropDownValue ==
                                                  'Anual') {
                                                return 1012;
                                              } else {
                                                return 0;
                                              }
                                            }(), false).length;
                                        loop1Index++) {
                                      final currentLoop1Item = functions
                                          .generateRecurrenceDatesByCode(
                                              widget!.docTransact!.date, () {
                                        if (_model.dropDownValue == 'Diario') {
                                          return 1;
                                        } else if (_model.dropDownValue ==
                                            'Semanal') {
                                          return 7;
                                        } else if (_model.dropDownValue ==
                                            'Quincenal') {
                                          return 14;
                                        } else if (_model.dropDownValue ==
                                            'Mensual') {
                                          return 1001;
                                        } else if (_model.dropDownValue ==
                                            'Trimestral') {
                                          return 1003;
                                        } else if (_model.dropDownValue ==
                                            'Anual') {
                                          return 1012;
                                        } else {
                                          return 0;
                                        }
                                      }(), false)[loop1Index];

                                      var documentsRecordReference =
                                          DocumentsRecord.collection.doc();
                                      await documentsRecordReference.set({
                                        ...createDocumentsRecordData(
                                          type: widget!.docTransact?.type,
                                          description:
                                              widget!.docTransact?.description,
                                          date: currentLoop1Item,
                                          amount: widget!.docTransact?.amount,
                                          isRecurrent: true,
                                          frequency: _model.dropDownValue,
                                          userRef: currentUserReference,
                                          frequencyCode: () {
                                            if ((_model.dropDownValue ==
                                                    'Diario') ||
                                                (_model.dropDownValue ==
                                                    'Daily')) {
                                              return 1;
                                            } else if ((_model.dropDownValue ==
                                                    'Semanal') ||
                                                (_model.dropDownValue ==
                                                    'Weekly')) {
                                              return 7;
                                            } else if ((_model.dropDownValue ==
                                                    'Quincenal') ||
                                                (_model.dropDownValue ==
                                                    'Biweekly')) {
                                              return 14;
                                            } else if ((_model.dropDownValue ==
                                                    'Mensual') ||
                                                (_model.dropDownValue ==
                                                    'Monthly')) {
                                              return 1001;
                                            } else if ((_model.dropDownValue ==
                                                    'Trimestral') ||
                                                (_model.dropDownValue ==
                                                    'Quarterly')) {
                                              return 1003;
                                            } else if ((_model.dropDownValue ==
                                                    'Anual') ||
                                                (_model.dropDownValue ==
                                                    ' Annual')) {
                                              return 1012;
                                            } else {
                                              return 0;
                                            }
                                          }(),
                                          recurrenceId:
                                              widget!.docTransact?.recurrenceId,
                                          occurrenceKey:
                                              functions.dateToOccurrenceKey(
                                                  currentLoop1Item),
                                          notificationAt: 72,
                                          isExpenses:
                                              widget!.docTransact?.isExpenses,
                                          isIncome:
                                              widget!.docTransact?.isIncome,
                                          isSave: widget!.docTransact?.isSave,
                                          isEvent: widget!.docTransact?.isEvent,
                                          source: widget!.docTransact?.source,
                                          isNotificationScheduledSent: false,
                                          isNotificationTodaySent: false,
                                          isInternalTransfer: widget!
                                              .docTransact?.isInternalTransfer,
                                          createdAt: getCurrentTimestamp,
                                          isPending: true,
                                          isOtherExpenses: widget!
                                              .docTransact?.isOtherExpenses,
                                          isoCurrencyCode: widget!
                                              .docTransact?.isoCurrencyCode,
                                          personalFinanceCategoryPrimary: widget!
                                              .docTransact
                                              ?.personalFinanceCategoryPrimary,
                                          personalFinanceCategoryDetailed: widget!
                                              .docTransact
                                              ?.personalFinanceCategoryDetailed,
                                          subtype: widget!.docTransact?.subtype,
                                          merchantName:
                                              widget!.docTransact?.merchantName,
                                          merchantId:
                                              widget!.docTransact?.merchantId,
                                          merchantWebsite: widget!
                                              .docTransact?.merchantWebsite,
                                          merchantLogo:
                                              widget!.docTransact?.merchantLogo,
                                          accountName:
                                              widget!.docTransact?.accountName,
                                          institutionName: widget!
                                              .docTransact?.institutionName,
                                          isConfirmed: true,
                                          plaidAccountId: widget!
                                              .docTransact?.plaidAccountId,
                                          isRealTransaction: false,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'updatedAt':
                                                FieldValue.serverTimestamp(),
                                          },
                                        ),
                                      });
                                      _model.recurrente2 =
                                          DocumentsRecord.getDocumentFromData({
                                        ...createDocumentsRecordData(
                                          type: widget!.docTransact?.type,
                                          description:
                                              widget!.docTransact?.description,
                                          date: currentLoop1Item,
                                          amount: widget!.docTransact?.amount,
                                          isRecurrent: true,
                                          frequency: _model.dropDownValue,
                                          userRef: currentUserReference,
                                          frequencyCode: () {
                                            if ((_model.dropDownValue ==
                                                    'Diario') ||
                                                (_model.dropDownValue ==
                                                    'Daily')) {
                                              return 1;
                                            } else if ((_model.dropDownValue ==
                                                    'Semanal') ||
                                                (_model.dropDownValue ==
                                                    'Weekly')) {
                                              return 7;
                                            } else if ((_model.dropDownValue ==
                                                    'Quincenal') ||
                                                (_model.dropDownValue ==
                                                    'Biweekly')) {
                                              return 14;
                                            } else if ((_model.dropDownValue ==
                                                    'Mensual') ||
                                                (_model.dropDownValue ==
                                                    'Monthly')) {
                                              return 1001;
                                            } else if ((_model.dropDownValue ==
                                                    'Trimestral') ||
                                                (_model.dropDownValue ==
                                                    'Quarterly')) {
                                              return 1003;
                                            } else if ((_model.dropDownValue ==
                                                    'Anual') ||
                                                (_model.dropDownValue ==
                                                    ' Annual')) {
                                              return 1012;
                                            } else {
                                              return 0;
                                            }
                                          }(),
                                          recurrenceId:
                                              widget!.docTransact?.recurrenceId,
                                          occurrenceKey:
                                              functions.dateToOccurrenceKey(
                                                  currentLoop1Item),
                                          notificationAt: 72,
                                          isExpenses:
                                              widget!.docTransact?.isExpenses,
                                          isIncome:
                                              widget!.docTransact?.isIncome,
                                          isSave: widget!.docTransact?.isSave,
                                          isEvent: widget!.docTransact?.isEvent,
                                          source: widget!.docTransact?.source,
                                          isNotificationScheduledSent: false,
                                          isNotificationTodaySent: false,
                                          isInternalTransfer: widget!
                                              .docTransact?.isInternalTransfer,
                                          createdAt: getCurrentTimestamp,
                                          isPending: true,
                                          isOtherExpenses: widget!
                                              .docTransact?.isOtherExpenses,
                                          isoCurrencyCode: widget!
                                              .docTransact?.isoCurrencyCode,
                                          personalFinanceCategoryPrimary: widget!
                                              .docTransact
                                              ?.personalFinanceCategoryPrimary,
                                          personalFinanceCategoryDetailed: widget!
                                              .docTransact
                                              ?.personalFinanceCategoryDetailed,
                                          subtype: widget!.docTransact?.subtype,
                                          merchantName:
                                              widget!.docTransact?.merchantName,
                                          merchantId:
                                              widget!.docTransact?.merchantId,
                                          merchantWebsite: widget!
                                              .docTransact?.merchantWebsite,
                                          merchantLogo:
                                              widget!.docTransact?.merchantLogo,
                                          accountName:
                                              widget!.docTransact?.accountName,
                                          institutionName: widget!
                                              .docTransact?.institutionName,
                                          isConfirmed: true,
                                          plaidAccountId: widget!
                                              .docTransact?.plaidAccountId,
                                          isRealTransaction: false,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'updatedAt': DateTime.now(),
                                          },
                                        ),
                                      }, documentsRecordReference);
                                    }
                                  } else {
                                    await widget!.docTransact!.reference
                                        .update(createDocumentsRecordData(
                                      isConfirmed: true,
                                    ));
                                  }

                                  await currentUserReference!
                                      .update(createUserRecordData(
                                    isDocumentCreated: true,
                                    isExpensesCreated: true,
                                  ));

                                  safeSetState(() {});
                                },
                          text: FFLocalizations.of(context).getText(
                            '75svz42g' /* Aceptar */,
                          ),
                          options: FFButtonOptions(
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Color(0xFF01654D),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
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
                            disabledColor: Color(0xFF0AE8B3),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: Container(
                          decoration: BoxDecoration(
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
                          ),
                          child: FFButtonWidget(
                            onPressed: () async {
                              await widget!.docTransact!.reference
                                  .update(createDocumentsRecordData(
                                isConfirmed: true,
                              ));
                            },
                            text: FFLocalizations.of(context).getText(
                              'indiwler' /* Omitir */,
                            ),
                            options: FFButtonOptions(
                              height: 50.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    font: GoogleFonts.roboto(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).primary,
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
                              hoverBorderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
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
    );
  }
}
