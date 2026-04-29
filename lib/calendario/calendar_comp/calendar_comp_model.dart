import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/calendario/day_text/day_text_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'calendar_comp_widget.dart' show CalendarCompWidget;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CalendarCompModel extends FlutterFlowModel<CalendarCompWidget> {
  ///  Local state fields for this component.

  DateTime? inputDate;

  DateTime? selectedDate;

  ///  State fields for stateful widgets in this component.

  // Model for DayLabel.
  late DayTextModel dayLabelModel1;
  // Model for DayLabel.
  late DayTextModel dayLabelModel2;
  // Model for DayLabel.
  late DayTextModel dayLabelModel3;
  // Model for DayLabel.
  late DayTextModel dayLabelModel4;
  // Model for DayLabel.
  late DayTextModel dayLabelModel5;
  // Model for DayLabel.
  late DayTextModel dayLabelModel6;
  // Model for DayLabel.
  late DayTextModel dayLabelModel7;

  @override
  void initState(BuildContext context) {
    dayLabelModel1 = createModel(context, () => DayTextModel());
    dayLabelModel2 = createModel(context, () => DayTextModel());
    dayLabelModel3 = createModel(context, () => DayTextModel());
    dayLabelModel4 = createModel(context, () => DayTextModel());
    dayLabelModel5 = createModel(context, () => DayTextModel());
    dayLabelModel6 = createModel(context, () => DayTextModel());
    dayLabelModel7 = createModel(context, () => DayTextModel());
  }

  @override
  void dispose() {
    dayLabelModel1.dispose();
    dayLabelModel2.dispose();
    dayLabelModel3.dispose();
    dayLabelModel4.dispose();
    dayLabelModel5.dispose();
    dayLabelModel6.dispose();
    dayLabelModel7.dispose();
  }
}
