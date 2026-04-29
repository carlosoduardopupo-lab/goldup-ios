import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/calendario/day_text/day_text_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'calendar_comp_model.dart';
export 'calendar_comp_model.dart';

class CalendarCompWidget extends StatefulWidget {
  const CalendarCompWidget({
    super.key,
    required this.inputDate,
    this.onSelectDateAction,
    this.initialSelectedDate,
    required this.documents,
  });

  final DateTime? inputDate;
  final Future Function(DateTime? selectedDate)? onSelectDateAction;
  final DateTime? initialSelectedDate;
  final List<DocumentsRecord>? documents;

  @override
  State<CalendarCompWidget> createState() => _CalendarCompWidgetState();
}

class _CalendarCompWidgetState extends State<CalendarCompWidget> {
  late CalendarCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalendarCompModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.inputDate = widget!.inputDate;
      safeSetState(() {});
      if (widget!.initialSelectedDate != null) {
        _model.selectedDate = widget!.initialSelectedDate;
        safeSetState(() {});
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0,
            color: Color(0x33000000),
            offset: Offset(
              0.0,
              2.0,
            ),
          )
        ],
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Transform.rotate(
                  angle: 180.0 * (math.pi / 180),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30.0,
                    buttonSize: 45.0,
                    icon: Icon(
                      FFIcons.karrowForwardIos80dp000000FILL0Wght600GRAD0Opsz48,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      _model.inputDate =
                          functions.getLastMonthDateTime(_model.inputDate!);
                      safeSetState(() {});
                    },
                  ),
                ),
                if ('${dateTimeFormat(
                          "MMMM",
                          dateTimeFromSecondsSinceEpoch(valueOrDefault<int>(
                            _model.inputDate?.secondsSinceEpoch,
                            0,
                          )),
                          locale: FFLocalizations.of(context).languageCode,
                        )} ${valueOrDefault<String>(
                          dateTimeFormat(
                            "y",
                            _model.inputDate,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          '0',
                        )}' !=
                        null &&
                    '${dateTimeFormat(
                          "MMMM",
                          dateTimeFromSecondsSinceEpoch(valueOrDefault<int>(
                            _model.inputDate?.secondsSinceEpoch,
                            0,
                          )),
                          locale: FFLocalizations.of(context).languageCode,
                        )} ${valueOrDefault<String>(
                          dateTimeFormat(
                            "y",
                            _model.inputDate,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          '0',
                        )}' !=
                        '')
                  Text(
                    '${dateTimeFormat(
                      "MMMM",
                      dateTimeFromSecondsSinceEpoch(valueOrDefault<int>(
                        _model.inputDate?.secondsSinceEpoch,
                        0,
                      )),
                      locale: FFLocalizations.of(context).languageCode,
                    )} ${valueOrDefault<String>(
                      dateTimeFormat(
                        "y",
                        _model.inputDate,
                        locale: FFLocalizations.of(context).languageCode,
                      ),
                      '0',
                    )}',
                    style: FlutterFlowTheme.of(context).labelLarge.override(
                          font: GoogleFonts.golosText(
                            fontWeight: FlutterFlowTheme.of(context)
                                .labelLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelLarge
                                .fontStyle,
                          ),
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelLarge
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).labelLarge.fontStyle,
                        ),
                  ),
                FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30.0,
                  buttonSize: 45.0,
                  icon: Icon(
                    FFIcons.karrowForwardIos80dp000000FILL0Wght600GRAD0Opsz48,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24.0,
                  ),
                  onPressed: () async {
                    _model.inputDate =
                        functions.getNextMonthDateTime(_model.inputDate!);
                    safeSetState(() {});
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(26.0, 10.0, 26.0, 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                wrapWithModel(
                  model: _model.dayLabelModel1,
                  updateCallback: () => safeSetState(() {}),
                  child: DayTextWidget(
                    day: 'Lun',
                  ),
                ),
                wrapWithModel(
                  model: _model.dayLabelModel2,
                  updateCallback: () => safeSetState(() {}),
                  child: DayTextWidget(
                    day: 'Mar',
                  ),
                ),
                wrapWithModel(
                  model: _model.dayLabelModel3,
                  updateCallback: () => safeSetState(() {}),
                  child: DayTextWidget(
                    day: 'Mie',
                  ),
                ),
                wrapWithModel(
                  model: _model.dayLabelModel4,
                  updateCallback: () => safeSetState(() {}),
                  child: DayTextWidget(
                    day: 'Jue',
                  ),
                ),
                wrapWithModel(
                  model: _model.dayLabelModel5,
                  updateCallback: () => safeSetState(() {}),
                  child: DayTextWidget(
                    day: 'Vie',
                  ),
                ),
                wrapWithModel(
                  model: _model.dayLabelModel6,
                  updateCallback: () => safeSetState(() {}),
                  child: DayTextWidget(
                    day: 'Sab',
                  ),
                ),
                wrapWithModel(
                  model: _model.dayLabelModel7,
                  updateCallback: () => safeSetState(() {}),
                  child: DayTextWidget(
                    day: 'Dom',
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 10.0),
              child: Builder(
                builder: (context) {
                  final calendar = functions
                      .getCalendarForMonth(
                          _model.inputDate!,
                          widget!.documents
                              ?.map((e) => e.date)
                              .withoutNulls
                              .toList()
                              ?.toList(),
                          widget!.documents
                              ?.map((e) => e.isIncome)
                              .toList()
                              ?.toList(),
                          widget!.documents
                              ?.map((e) => e.isEvent)
                              .toList()
                              ?.toList(),
                          widget!.documents
                              ?.map((e) => e.isSave)
                              .toList()
                              ?.toList(),
                          widget!.documents
                              ?.map((e) => e.isExpenses)
                              .toList()
                              ?.toList(),
                          widget!.documents
                              ?.map((e) => e.isInternalTransfer)
                              .toList()
                              ?.toList())
                      .toList();

                  return GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      crossAxisSpacing: 2.0,
                      mainAxisSpacing: 2.0,
                      childAspectRatio: 1.0,
                    ),
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: calendar.length,
                    itemBuilder: (context, calendarIndex) {
                      final calendarItem = calendar[calendarIndex];
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          _model.selectedDate = calendarItem.calendarDate;
                          safeSetState(() {});
                          FFAppState().selectedDate = calendarItem.calendarDate;
                          safeSetState(() {});
                          await widget.onSelectDateAction?.call(
                            _model.selectedDate,
                          );
                        },
                        child: Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            color: dateTimeFormat(
                                      "d/M/y",
                                      calendarItem.calendarDate,
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    ) ==
                                    dateTimeFormat(
                                      "d/M/y",
                                      _model.selectedDate,
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    )
                                ? Color(0xFF3C4B52)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(
                              color: dateTimeFormat(
                                        "d/M/y",
                                        calendarItem.calendarDate,
                                        locale: FFLocalizations.of(context)
                                            .languageCode,
                                      ) ==
                                      dateTimeFormat(
                                        "d/M/y",
                                        getCurrentTimestamp,
                                        locale: FFLocalizations.of(context)
                                            .languageCode,
                                      )
                                  ? FlutterFlowTheme.of(context).primaryText
                                  : Colors.transparent,
                              width: 0.5,
                            ),
                          ),
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (dateTimeFormat(
                                        "d",
                                        dateTimeFromSecondsSinceEpoch(
                                            valueOrDefault<int>(
                                          calendarItem
                                              .calendarDate?.secondsSinceEpoch,
                                          0,
                                        )),
                                        locale: FFLocalizations.of(context)
                                            .languageCode,
                                      ) !=
                                      null &&
                                  dateTimeFormat(
                                        "d",
                                        dateTimeFromSecondsSinceEpoch(
                                            valueOrDefault<int>(
                                          calendarItem
                                              .calendarDate?.secondsSinceEpoch,
                                          0,
                                        )),
                                        locale: FFLocalizations.of(context)
                                            .languageCode,
                                      ) !=
                                      '')
                                Text(
                                  dateTimeFormat(
                                    "d",
                                    dateTimeFromSecondsSinceEpoch(
                                        valueOrDefault<int>(
                                      calendarItem
                                          .calendarDate?.secondsSinceEpoch,
                                      0,
                                    )),
                                    locale: FFLocalizations.of(context)
                                        .languageCode,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        font: GoogleFonts.golosText(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .fontStyle,
                                        ),
                                        color: (calendarItem.isPreviousMonth ==
                                                    true) ||
                                                (calendarItem.isNextMonth ==
                                                    true)
                                            ? (dateTimeFormat(
                                                      "d/M/y",
                                                      calendarItem.calendarDate,
                                                      locale:
                                                          FFLocalizations.of(
                                                                  context)
                                                              .languageCode,
                                                    ) ==
                                                    dateTimeFormat(
                                                      "d/M/y",
                                                      _model.selectedDate,
                                                      locale:
                                                          FFLocalizations.of(
                                                                  context)
                                                              .languageCode,
                                                    )
                                                ? FlutterFlowTheme.of(context)
                                                    .alternate
                                                : FlutterFlowTheme.of(context)
                                                    .secondaryText)
                                            : (dateTimeFormat(
                                                      "d/M/y",
                                                      calendarItem.calendarDate,
                                                      locale:
                                                          FFLocalizations.of(
                                                                  context)
                                                              .languageCode,
                                                    ) ==
                                                    dateTimeFormat(
                                                      "d/M/y",
                                                      _model.selectedDate,
                                                      locale:
                                                          FFLocalizations.of(
                                                                  context)
                                                              .languageCode,
                                                    )
                                                ? FlutterFlowTheme.of(context)
                                                    .alternate
                                                : FlutterFlowTheme.of(context)
                                                    .primaryText),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .fontStyle,
                                        lineHeight: 1.1,
                                      ),
                                ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 2.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (calendarItem.hasSave == true)
                                        Container(
                                          width: 6.0,
                                          height: 6.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFC7D700),
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                          ),
                                        ),
                                      if (calendarItem.hasIncome == true)
                                        Container(
                                          width: 6.0,
                                          height: 6.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF05B01F),
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                          ),
                                        ),
                                      if (calendarItem.hasExpense == true)
                                        Container(
                                          width: 6.0,
                                          height: 6.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF5080D),
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                          ),
                                        ),
                                      if (calendarItem.hasEvent == true)
                                        Container(
                                          width: 6.0,
                                          height: 6.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF045EBC),
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                          ),
                                        ),
                                      if (calendarItem.hasInternalTransfer ==
                                          true)
                                        Container(
                                          width: 6.0,
                                          height: 6.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF56D18),
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                          ),
                                        ),
                                    ].divide(SizedBox(width: 3.0)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ].addToStart(SizedBox(height: 10.0)),
      ),
    );
  }
}
