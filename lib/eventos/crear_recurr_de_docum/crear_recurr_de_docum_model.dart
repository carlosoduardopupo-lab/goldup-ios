import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'crear_recurr_de_docum_widget.dart' show CrearRecurrDeDocumWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CrearRecurrDeDocumModel
    extends FlutterFlowModel<CrearRecurrDeDocumWidget> {
  ///  Local state fields for this component.

  String? type = 'tipo';

  String? description = 'description';

  double? amount = 0.0;

  bool isRecurrent = false;

  String? frequency = 'frequency';

  bool editarSoloEsteEvento = false;

  List<String> evento = [];
  void addToEvento(String item) => evento.add(item);
  void removeFromEvento(String item) => evento.remove(item);
  void removeAtIndexFromEvento(int index) => evento.removeAt(index);
  void insertAtIndexInEvento(int index, String item) =>
      evento.insert(index, item);
  void updateEventoAtIndex(int index, Function(String) updateFn) =>
      evento[index] = updateFn(evento[index]);

  List<String> incom = [];
  void addToIncom(String item) => incom.add(item);
  void removeFromIncom(String item) => incom.remove(item);
  void removeAtIndexFromIncom(int index) => incom.removeAt(index);
  void insertAtIndexInIncom(int index, String item) =>
      incom.insert(index, item);
  void updateIncomAtIndex(int index, Function(String) updateFn) =>
      incom[index] = updateFn(incom[index]);

  List<String> expense = [];
  void addToExpense(String item) => expense.add(item);
  void removeFromExpense(String item) => expense.remove(item);
  void removeAtIndexFromExpense(int index) => expense.removeAt(index);
  void insertAtIndexInExpense(int index, String item) =>
      expense.insert(index, item);
  void updateExpenseAtIndex(int index, Function(String) updateFn) =>
      expense[index] = updateFn(expense[index]);

  int? notificationAt;

  List<String> saves = [];
  void addToSaves(String item) => saves.add(item);
  void removeFromSaves(String item) => saves.remove(item);
  void removeAtIndexFromSaves(int index) => saves.removeAt(index);
  void insertAtIndexInSaves(int index, String item) =>
      saves.insert(index, item);
  void updateSavesAtIndex(int index, Function(String) updateFn) =>
      saves[index] = updateFn(saves[index]);

  String? note;

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for Checkbox widget.
  bool? checkboxValue;
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  DocumentsRecord? recurrente2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }
}
