// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChartPointStruct extends FFFirebaseStruct {
  ChartPointStruct({
    String? date,
    double? amount,
    int? occurrenceKey,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _date = date,
        _amount = amount,
        _occurrenceKey = occurrenceKey,
        super(firestoreUtilData);

  // "date" field.
  String? _date;
  String get date => _date ?? '';
  set date(String? val) => _date = val;

  bool hasDate() => _date != null;

  // "amount" field.
  double? _amount;
  double get amount => _amount ?? 0.0;
  set amount(double? val) => _amount = val;

  void incrementAmount(double amount) => amount = amount + amount;

  bool hasAmount() => _amount != null;

  // "occurrenceKey" field.
  int? _occurrenceKey;
  int get occurrenceKey => _occurrenceKey ?? 0;
  set occurrenceKey(int? val) => _occurrenceKey = val;

  void incrementOccurrenceKey(int amount) =>
      occurrenceKey = occurrenceKey + amount;

  bool hasOccurrenceKey() => _occurrenceKey != null;

  static ChartPointStruct fromMap(Map<String, dynamic> data) =>
      ChartPointStruct(
        date: data['date'] as String?,
        amount: castToType<double>(data['amount']),
        occurrenceKey: castToType<int>(data['occurrenceKey']),
      );

  static ChartPointStruct? maybeFromMap(dynamic data) => data is Map
      ? ChartPointStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'date': _date,
        'amount': _amount,
        'occurrenceKey': _occurrenceKey,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'date': serializeParam(
          _date,
          ParamType.String,
        ),
        'amount': serializeParam(
          _amount,
          ParamType.double,
        ),
        'occurrenceKey': serializeParam(
          _occurrenceKey,
          ParamType.int,
        ),
      }.withoutNulls;

  static ChartPointStruct fromSerializableMap(Map<String, dynamic> data) =>
      ChartPointStruct(
        date: deserializeParam(
          data['date'],
          ParamType.String,
          false,
        ),
        amount: deserializeParam(
          data['amount'],
          ParamType.double,
          false,
        ),
        occurrenceKey: deserializeParam(
          data['occurrenceKey'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'ChartPointStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ChartPointStruct &&
        date == other.date &&
        amount == other.amount &&
        occurrenceKey == other.occurrenceKey;
  }

  @override
  int get hashCode => const ListEquality().hash([date, amount, occurrenceKey]);
}

ChartPointStruct createChartPointStruct({
  String? date,
  double? amount,
  int? occurrenceKey,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ChartPointStruct(
      date: date,
      amount: amount,
      occurrenceKey: occurrenceKey,
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
