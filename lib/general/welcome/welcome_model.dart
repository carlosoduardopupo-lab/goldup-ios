import '/components/pagin_bloqueo_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'welcome_widget.dart' show WelcomeWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WelcomeModel extends FlutterFlowModel<WelcomeWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for paginBloqueo component.
  late PaginBloqueoModel paginBloqueoModel;

  @override
  void initState(BuildContext context) {
    paginBloqueoModel = createModel(context, () => PaginBloqueoModel());
  }

  @override
  void dispose() {
    paginBloqueoModel.dispose();
  }
}
