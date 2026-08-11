import '/acciones/desvincular_institucion/desvincular_institucion_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/tarjetas/institution/institution_widget.dart';
import 'dart:ui';
import 'institutions_widget.dart' show InstitutionsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InstitutionsModel extends FlutterFlowModel<InstitutionsWidget> {
  ///  State fields for stateful widgets in this component.

  // Models for Institution dynamic component.
  late FlutterFlowDynamicModels<InstitutionModel> institutionModels;

  @override
  void initState(BuildContext context) {
    institutionModels = FlutterFlowDynamicModels(() => InstitutionModel());
  }

  @override
  void dispose() {
    institutionModels.dispose();
  }
}
