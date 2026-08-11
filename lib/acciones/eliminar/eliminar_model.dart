import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'eliminar_widget.dart' show EliminarWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EliminarModel extends FlutterFlowModel<EliminarWidget> {
  ///  Local state fields for this component.

  bool check = true;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Checkbox widget.
  bool? checkboxValue;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<DocumentsRecord>? document;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  DocumentsRecord? document1;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  DocumentsRecord? doc;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<DocumentsRecord>? docume;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
