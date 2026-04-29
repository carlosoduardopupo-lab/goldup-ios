import '/acciones/error_biometria/error_biometria_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'biometria_widget.dart' show BiometriaWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class BiometriaModel extends FlutterFlowModel<BiometriaWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - hasBiometrics] action in Button widget.
  bool? hasBiometrics;
  bool biometricResult = false;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
