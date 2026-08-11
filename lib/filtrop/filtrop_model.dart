import '/acciones/ajustes/ajustes_widget.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/tarjetas/card_bill_copy/card_bill_copy_widget.dart';
import 'dart:ui';
import 'filtrop_widget.dart' show FiltropWidget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FiltropModel extends FlutterFlowModel<FiltropWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for cardBillCopy dynamic component.
  late FlutterFlowDynamicModels<CardBillCopyModel> cardBillCopyModels;

  @override
  void initState(BuildContext context) {
    cardBillCopyModels = FlutterFlowDynamicModels(() => CardBillCopyModel());
  }

  @override
  void dispose() {
    cardBillCopyModels.dispose();
  }
}
