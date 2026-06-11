import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'conectarcuentas_widget.dart' show ConectarcuentasWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ConectarcuentasModel extends FlutterFlowModel<ConectarcuentasWidget> {
  ///  Local state fields for this component.

  bool chek = true;

  String? webUlr;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Checkbox widget.
  bool? checkboxValue;
  // Stores action output result for [Cloud Function - startPlaidLinkWebV2] action in Button widget.
  StartPlaidLinkWebV2CloudFunctionCallResponse? plaidStartResult2;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  PlaidLinkSessionsRecord? weburl2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
