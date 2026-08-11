import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'institution_model.dart';
export 'institution_model.dart';

class InstitutionWidget extends StatefulWidget {
  const InstitutionWidget({
    super.key,
    required this.plaidItems,
    required this.needsAttention,
  });

  final PlaidItemsRecord? plaidItems;
  final bool? needsAttention;

  @override
  State<InstitutionWidget> createState() => _InstitutionWidgetState();
}

class _InstitutionWidgetState extends State<InstitutionWidget> {
  late InstitutionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InstitutionModel());

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
      height: 105.0,
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
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stack(
            children: [
              if (widget!.needsAttention == true)
                Align(
                  alignment: AlignmentDirectional(1.0, 1.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 34.0, 10.0, 0.0),
                    child: FaIcon(
                      FontAwesomeIcons.exclamationTriangle,
                      color: Color(0xFFF4A403),
                      size: 26.0,
                    ),
                  ),
                ),
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 70.0,
                            height: 70.0,
                            child: custom_widgets.Base64Image(
                              width: 70.0,
                              height: 70.0,
                              base64String: widget!.plaidItems?.institutionLogo,
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: AlignmentDirectional(1.0, 0.0),
                        child: StreamBuilder<List<PlaidInstitutionsRecord>>(
                          stream: queryPlaidInstitutionsRecord(
                            queryBuilder: (plaidInstitutionsRecord) =>
                                plaidInstitutionsRecord.where(
                              'institutionId',
                              isEqualTo: widget!.plaidItems?.institutionId,
                            ),
                            singleRecord: true,
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
                            List<PlaidInstitutionsRecord>
                                textPlaidInstitutionsRecordList =
                                snapshot.data!;
                            // Return an empty Container when the item does not exist.
                            if (snapshot.data!.isEmpty) {
                              return Container();
                            }
                            final textPlaidInstitutionsRecord =
                                textPlaidInstitutionsRecordList.isNotEmpty
                                    ? textPlaidInstitutionsRecordList.first
                                    : null;

                            return Text(
                              valueOrDefault<String>(
                                widget!.plaidItems?.institutionName,
                                'Bank name',
                              ),
                              maxLines: 2,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: colorFromCssString(
                                      textPlaidInstitutionsRecord!.primaryColor,
                                      defaultColor: Colors.black,
                                    ),
                                    fontSize: 29.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
