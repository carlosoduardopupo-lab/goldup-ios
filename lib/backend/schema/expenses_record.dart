import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ExpensesRecord extends FirestoreRecord {
  ExpensesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "type" field.
  List<String>? _type;
  List<String> get type => _type ?? const [];
  bool hasType() => _type != null;

  void _initializeFields() {
    _type = getDataList(snapshotData['type']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('expenses');

  static Stream<ExpensesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ExpensesRecord.fromSnapshot(s));

  static Future<ExpensesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ExpensesRecord.fromSnapshot(s));

  static ExpensesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ExpensesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ExpensesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ExpensesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ExpensesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ExpensesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createExpensesRecordData() {
  final firestoreData = mapToFirestore(
    <String, dynamic>{}.withoutNulls,
  );

  return firestoreData;
}

class ExpensesRecordDocumentEquality implements Equality<ExpensesRecord> {
  const ExpensesRecordDocumentEquality();

  @override
  bool equals(ExpensesRecord? e1, ExpensesRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.type, e2?.type);
  }

  @override
  int hash(ExpensesRecord? e) => const ListEquality().hash([e?.type]);

  @override
  bool isValidKey(Object? o) => o is ExpensesRecord;
}
