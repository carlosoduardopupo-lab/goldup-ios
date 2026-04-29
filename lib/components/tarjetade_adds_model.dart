import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'tarjetade_adds_widget.dart' show TarjetadeAddsWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TarjetadeAddsModel extends FlutterFlowModel<TarjetadeAddsWidget> {
  ///  Local state fields for this component.

  String? image;

  String? title;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in TarjetadeAdds widget.
  AdsRecord? addsDocum;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
