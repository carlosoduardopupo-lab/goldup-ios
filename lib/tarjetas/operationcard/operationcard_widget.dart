import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'operationcard_model.dart';
export 'operationcard_model.dart';

class OperationcardWidget extends StatefulWidget {
  const OperationcardWidget({
    super.key,
    required this.document,
  });

  final DocumentsRecord? document;

  @override
  State<OperationcardWidget> createState() => _OperationcardWidgetState();
}

class _OperationcardWidgetState extends State<OperationcardWidget> {
  late OperationcardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OperationcardModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 10.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://picsum.photos/seed/597/600',
                        width: 24.0,
                        height: 24.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: 210.0,
                      decoration: BoxDecoration(),
                      child: Text(
                        valueOrDefault<String>(
                          widget!.document?.description,
                          'description',
                        ),
                        maxLines: 1,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.roboto(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                    ),
                  ].divide(SizedBox(width: 10.0)),
                ),
                Text(
                  valueOrDefault<String>(
                    formatNumber(
                      widget!.document?.amount,
                      formatType: FormatType.decimal,
                      decimalType: DecimalType.automatic,
                      currency: '\$',
                    ),
                    '0',
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: () {
                          if ((widget!.document?.isExpenses == false) &&
                              (widget!.document?.isOtherExpenses == false) &&
                              (widget!.document?.isSave == false) &&
                              (widget!.document?.isGoal == false) &&
                              (widget!.document?.isIncome == true)) {
                            return Color(0xFF048209);
                          } else if ((widget!.document?.isExpenses == true) &&
                              (widget!.document?.isOtherExpenses == false) &&
                              (widget!.document?.isSave == false) &&
                              (widget!.document?.isGoal == false) &&
                              (widget!.document?.isIncome == false)) {
                            return Color(0xFFB80404);
                          } else if ((widget!.document?.isExpenses == false) &&
                              (widget!.document?.isOtherExpenses == true) &&
                              (widget!.document?.isSave == false) &&
                              (widget!.document?.isGoal == false) &&
                              (widget!.document?.isIncome == false)) {
                            return Color(0xFFB80404);
                          } else if ((widget!.document?.isExpenses == true) &&
                              (widget!.document?.isOtherExpenses == true) &&
                              (widget!.document?.isSave == false) &&
                              (widget!.document?.isGoal == false) &&
                              (widget!.document?.isIncome == false)) {
                            return Color(0xFFB80404);
                          } else {
                            return Color(0xFF0505FD);
                          }
                        }(),
                        fontSize: 20.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ],
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-1.0, 0.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
              child: Text(
                valueOrDefault<String>(
                  widget!.document?.date,
                  'date',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).accent1,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryText,
              ),
            ),
          ),
        ].divide(SizedBox(height: 10.0)),
      ),
    );
  }
}
