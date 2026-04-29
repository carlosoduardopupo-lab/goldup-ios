import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/tarjetas/operationcard/operationcard_widget.dart';
import '/transacciones/transactiondetails/transactiondetails_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'operations_widget.dart' show OperationsWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OperationsModel extends FlutterFlowModel<OperationsWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for operationcard dynamic component.
  late FlutterFlowDynamicModels<OperationcardModel> operationcardModels1;
  // Models for operationcard dynamic component.
  late FlutterFlowDynamicModels<OperationcardModel> operationcardModels2;

  @override
  void initState(BuildContext context) {
    operationcardModels1 = FlutterFlowDynamicModels(() => OperationcardModel());
    operationcardModels2 = FlutterFlowDynamicModels(() => OperationcardModel());
  }

  @override
  void dispose() {
    operationcardModels1.dispose();
    operationcardModels2.dispose();
  }
}
