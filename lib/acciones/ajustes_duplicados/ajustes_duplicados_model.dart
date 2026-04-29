import '/acciones/editarotr_gas/editarotr_gas_widget.dart';
import '/acciones/eliminar/eliminar_widget.dart';
import '/acciones/eliminar_otro_gasto/eliminar_otro_gasto_widget.dart';
import '/backend/backend.dart';
import '/eventos/editar_evento/editar_evento_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/tarjetas/operationcard/operationcard_widget.dart';
import 'dart:ui';
import 'ajustes_duplicados_widget.dart' show AjustesDuplicadosWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AjustesDuplicadosModel extends FlutterFlowModel<AjustesDuplicadosWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for operationcard component.
  late OperationcardModel operationcardModel;

  @override
  void initState(BuildContext context) {
    operationcardModel = createModel(context, () => OperationcardModel());
  }

  @override
  void dispose() {
    operationcardModel.dispose();
  }
}
