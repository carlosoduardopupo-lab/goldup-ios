import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'desvincular_institucion_widget.dart' show DesvincularInstitucionWidget;
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DesvincularInstitucionModel
    extends FlutterFlowModel<DesvincularInstitucionWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Cloud Function - deleteBankInstitutionV2] action in Button widget.
  DeleteBankInstitutionV2CloudFunctionCallResponse? deleteResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
