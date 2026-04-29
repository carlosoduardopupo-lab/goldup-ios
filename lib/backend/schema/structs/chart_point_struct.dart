// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChartPointStruct extends FFFirebaseStruct {
  ChartPointStruct({
    double? day,
    double? value,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _day = day,
        _value = value,
        super(firestoreUtilData);

  // "day" field.
  double? _day;
  double get day => _day ?? 0.0;
  set day(double? val) => _day = val;

  void incrementDay(double amount) => day = day + amount;

  bool hasDay() => _day != null;

  // "value" field.
  double? _value;
  double get value => _value ?? 0.0;
  set value(double? val) => _value = val;

  void incrementValue(double amount) => value = value + amount;

  bool hasValue() => _value != null;

  static ChartPointStruct fromMap(Map<String, dynamic> data) =>
      ChartPointStruct(
        day: castToType<double>(data['day']),
        value: castToType<double>(data['value']),
      );

  static ChartPointStruct? maybeFromMap(dynamic data) => data is Map
      ? ChartPointStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'day': _day,
        'value': _value,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'day': serializeParam(
          _day,
          ParamType.double,
        ),
        'value': serializeParam(
          _value,
          ParamType.double,
        ),
      }.withoutNulls;

  static ChartPointStruct fromSerializableMap(Map<String, dynamic> data) =>
      ChartPointStruct(
        day: deserializeParam(
          data['day'],
          ParamType.double,
          false,
        ),
        value: deserializeParam(
          data['value'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'ChartPointStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ChartPointStruct &&
        day == other.day &&
        value == other.value;
  }

  @override
  int get hashCode => const ListEquality().hash([day, value]);
}

ChartPointStruct createChartPointStruct({
  double? day,
  double? value,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ChartPointStruct(
      day: day,
      value: value,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ChartPointStruct? updateChartPointStruct(
  ChartPointStruct? chartPoint, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    chartPoint
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addChartPointStructData(
  Map<String, dynamic> firestoreData,
  ChartPointStruct? chartPoint,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (chartPoint == null) {
    return;
  }
  if (chartPoint.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && chartPoint.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final chartPointData = getChartPointFirestoreData(chartPoint, forFieldValue);
  final nestedData = chartPointData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = chartPoint.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getChartPointFirestoreData(
  ChartPointStruct? chartPoint, [
  bool forFieldValue = false,
]) {
  if (chartPoint == null) {
    return {};
  }
  final firestoreData = mapToFirestore(chartPoint.toMap());

  // Add any Firestore field values
  mapToFirestore(chartPoint.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getChartPointListFirestoreData(
  List<ChartPointStruct>? chartPoints,
) =>
    chartPoints?.map((e) => getChartPointFirestoreData(e, true)).toList() ?? [];
