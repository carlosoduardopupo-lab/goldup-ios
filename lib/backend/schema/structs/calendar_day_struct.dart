// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CalendarDayStruct extends FFFirebaseStruct {
  CalendarDayStruct({
    bool? isPreviousMonth,
    bool? isNextMonth,
    DateTime? calendarDate,
    bool? hasIncome,
    bool? hasEvent,
    bool? hasExpense,
    String? dataKey,
    bool? hasSave,
    bool? hasInternalTransfer,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _isPreviousMonth = isPreviousMonth,
        _isNextMonth = isNextMonth,
        _calendarDate = calendarDate,
        _hasIncome = hasIncome,
        _hasEvent = hasEvent,
        _hasExpense = hasExpense,
        _dataKey = dataKey,
        _hasSave = hasSave,
        _hasInternalTransfer = hasInternalTransfer,
        super(firestoreUtilData);

  // "isPreviousMonth" field.
  bool? _isPreviousMonth;
  bool get isPreviousMonth => _isPreviousMonth ?? false;
  set isPreviousMonth(bool? val) => _isPreviousMonth = val;

  bool hasIsPreviousMonth() => _isPreviousMonth != null;

  // "isNextMonth" field.
  bool? _isNextMonth;
  bool get isNextMonth => _isNextMonth ?? false;
  set isNextMonth(bool? val) => _isNextMonth = val;

  bool hasIsNextMonth() => _isNextMonth != null;

  // "CalendarDate" field.
  DateTime? _calendarDate;
  DateTime? get calendarDate => _calendarDate;
  set calendarDate(DateTime? val) => _calendarDate = val;

  bool hasCalendarDate() => _calendarDate != null;

  // "hasIncome" field.
  bool? _hasIncome;
  bool get hasIncome => _hasIncome ?? false;
  set hasIncome(bool? val) => _hasIncome = val;

  bool hasHasIncome() => _hasIncome != null;

  // "hasEvent" field.
  bool? _hasEvent;
  bool get hasEvent => _hasEvent ?? false;
  set hasEvent(bool? val) => _hasEvent = val;

  bool hasHasEvent() => _hasEvent != null;

  // "hasExpense" field.
  bool? _hasExpense;
  bool get hasExpense => _hasExpense ?? false;
  set hasExpense(bool? val) => _hasExpense = val;

  bool hasHasExpense() => _hasExpense != null;

  // "dataKey" field.
  String? _dataKey;
  String get dataKey => _dataKey ?? '';
  set dataKey(String? val) => _dataKey = val;

  bool hasDataKey() => _dataKey != null;

  // "hasSave" field.
  bool? _hasSave;
  bool get hasSave => _hasSave ?? false;
  set hasSave(bool? val) => _hasSave = val;

  bool hasHasSave() => _hasSave != null;

  // "hasInternalTransfer" field.
  bool? _hasInternalTransfer;
  bool get hasInternalTransfer => _hasInternalTransfer ?? false;
  set hasInternalTransfer(bool? val) => _hasInternalTransfer = val;

  bool hasHasInternalTransfer() => _hasInternalTransfer != null;

  static CalendarDayStruct fromMap(Map<String, dynamic> data) =>
      CalendarDayStruct(
        isPreviousMonth: data['isPreviousMonth'] as bool?,
        isNextMonth: data['isNextMonth'] as bool?,
        calendarDate: data['CalendarDate'] as DateTime?,
        hasIncome: data['hasIncome'] as bool?,
        hasEvent: data['hasEvent'] as bool?,
        hasExpense: data['hasExpense'] as bool?,
        dataKey: data['dataKey'] as String?,
        hasSave: data['hasSave'] as bool?,
        hasInternalTransfer: data['hasInternalTransfer'] as bool?,
      );

  static CalendarDayStruct? maybeFromMap(dynamic data) => data is Map
      ? CalendarDayStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'isPreviousMonth': _isPreviousMonth,
        'isNextMonth': _isNextMonth,
        'CalendarDate': _calendarDate,
        'hasIncome': _hasIncome,
        'hasEvent': _hasEvent,
        'hasExpense': _hasExpense,
        'dataKey': _dataKey,
        'hasSave': _hasSave,
        'hasInternalTransfer': _hasInternalTransfer,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'isPreviousMonth': serializeParam(
          _isPreviousMonth,
          ParamType.bool,
        ),
        'isNextMonth': serializeParam(
          _isNextMonth,
          ParamType.bool,
        ),
        'CalendarDate': serializeParam(
          _calendarDate,
          ParamType.DateTime,
        ),
        'hasIncome': serializeParam(
          _hasIncome,
          ParamType.bool,
        ),
        'hasEvent': serializeParam(
          _hasEvent,
          ParamType.bool,
        ),
        'hasExpense': serializeParam(
          _hasExpense,
          ParamType.bool,
        ),
        'dataKey': serializeParam(
          _dataKey,
          ParamType.String,
        ),
        'hasSave': serializeParam(
          _hasSave,
          ParamType.bool,
        ),
        'hasInternalTransfer': serializeParam(
          _hasInternalTransfer,
          ParamType.bool,
        ),
      }.withoutNulls;

  static CalendarDayStruct fromSerializableMap(Map<String, dynamic> data) =>
      CalendarDayStruct(
        isPreviousMonth: deserializeParam(
          data['isPreviousMonth'],
          ParamType.bool,
          false,
        ),
        isNextMonth: deserializeParam(
          data['isNextMonth'],
          ParamType.bool,
          false,
        ),
        calendarDate: deserializeParam(
          data['CalendarDate'],
          ParamType.DateTime,
          false,
        ),
        hasIncome: deserializeParam(
          data['hasIncome'],
          ParamType.bool,
          false,
        ),
        hasEvent: deserializeParam(
          data['hasEvent'],
          ParamType.bool,
          false,
        ),
        hasExpense: deserializeParam(
          data['hasExpense'],
          ParamType.bool,
          false,
        ),
        dataKey: deserializeParam(
          data['dataKey'],
          ParamType.String,
          false,
        ),
        hasSave: deserializeParam(
          data['hasSave'],
          ParamType.bool,
          false,
        ),
        hasInternalTransfer: deserializeParam(
          data['hasInternalTransfer'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'CalendarDayStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CalendarDayStruct &&
        isPreviousMonth == other.isPreviousMonth &&
        isNextMonth == other.isNextMonth &&
        calendarDate == other.calendarDate &&
        hasIncome == other.hasIncome &&
        hasEvent == other.hasEvent &&
        hasExpense == other.hasExpense &&
        dataKey == other.dataKey &&
        hasSave == other.hasSave &&
        hasInternalTransfer == other.hasInternalTransfer;
  }

  @override
  int get hashCode => const ListEquality().hash([
        isPreviousMonth,
        isNextMonth,
        calendarDate,
        hasIncome,
        hasEvent,
        hasExpense,
        dataKey,
        hasSave,
        hasInternalTransfer
      ]);
}

CalendarDayStruct createCalendarDayStruct({
  bool? isPreviousMonth,
  bool? isNextMonth,
  DateTime? calendarDate,
  bool? hasIncome,
  bool? hasEvent,
  bool? hasExpense,
  String? dataKey,
  bool? hasSave,
  bool? hasInternalTransfer,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CalendarDayStruct(
      isPreviousMonth: isPreviousMonth,
      isNextMonth: isNextMonth,
      calendarDate: calendarDate,
      hasIncome: hasIncome,
      hasEvent: hasEvent,
      hasExpense: hasExpense,
      dataKey: dataKey,
      hasSave: hasSave,
      hasInternalTransfer: hasInternalTransfer,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CalendarDayStruct? updateCalendarDayStruct(
  CalendarDayStruct? calendarDay, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    calendarDay
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCalendarDayStructData(
  Map<String, dynamic> firestoreData,
  CalendarDayStruct? calendarDay,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (calendarDay == null) {
    return;
  }
  if (calendarDay.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && calendarDay.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final calendarDayData =
      getCalendarDayFirestoreData(calendarDay, forFieldValue);
  final nestedData =
      calendarDayData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = calendarDay.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCalendarDayFirestoreData(
  CalendarDayStruct? calendarDay, [
  bool forFieldValue = false,
]) {
  if (calendarDay == null) {
    return {};
  }
  final firestoreData = mapToFirestore(calendarDay.toMap());

  // Add any Firestore field values
  mapToFirestore(calendarDay.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCalendarDayListFirestoreData(
  List<CalendarDayStruct>? calendarDays,
) =>
    calendarDays?.map((e) => getCalendarDayFirestoreData(e, true)).toList() ??
    [];
