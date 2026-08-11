import '/acciones/desvincular_institucion/desvincular_institucion_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/tarjetas/institution/institution_widget.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'institutions_model.dart';
export 'institutions_model.dart';

class InstitutionsWidget extends StatefulWidget {
  const InstitutionsWidget({super.key});

  @override
  State<InstitutionsWidget> createState() => _InstitutionsWidgetState();
}

class _InstitutionsWidgetState extends State<InstitutionsWidget> {
  late InstitutionsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InstitutionsModel());

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
          color: Colors.white,
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
                      '7ymly05i' /* Instituciones  Bancarias */,
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
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 32.0),
              child: StreamBuilder<List<PlaidItemsRecord>>(
                stream: queryPlaidItemsRecord(
                  queryBuilder: (plaidItemsRecord) => plaidItemsRecord.where(
                    'userRef',
                    isEqualTo: currentUserReference,
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
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    );
                  }
                  List<PlaidItemsRecord> listViewPlaidItemsRecordList =
                      snapshot.data!;

                  return ListView.separated(
                    padding: EdgeInsets.fromLTRB(
                      0,
                      20.0,
                      0,
                      20.0,
                    ),
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: listViewPlaidItemsRecordList.length,
                    separatorBuilder: (_, __) => SizedBox(height: 10.0),
                    itemBuilder: (context, listViewIndex) {
                      final listViewPlaidItemsRecord =
                          listViewPlaidItemsRecordList[listViewIndex];
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          Navigator.pop(context);
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            enableDrag: false,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: MediaQuery.viewInsetsOf(context),
                                child: DesvincularInstitucionWidget(
                                  accountRef: listViewPlaidItemsRecord,
                                ),
                              );
                            },
                          ).then((value) => safeSetState(() {}));
                        },
                        child: wrapWithModel(
                          model: _model.institutionModels.getModel(
                            listViewPlaidItemsRecord.reference.id,
                            listViewIndex,
                          ),
                          updateCallback: () => safeSetState(() {}),
                          child: InstitutionWidget(
                            key: Key(
                              'Key7uz_${listViewPlaidItemsRecord.reference.id}',
                            ),
                            needsAttention: false,
                            plaidItems: listViewPlaidItemsRecord,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
