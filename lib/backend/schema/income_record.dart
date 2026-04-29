import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class IncomeRecord extends FirestoreRecord {
  IncomeRecord._(
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
      FirebaseFirestore.instance.collection('income');

  static Stream<IncomeRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => IncomeRecord.fromSnapshot(s));

  static Future<IncomeRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => IncomeRecord.fromSnapshot(s));

  static IncomeRecord fromSnapshot(DocumentSnapshot snapshot) => IncomeRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static IncomeRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      IncomeRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'IncomeRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is IncomeRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createIncomeRecordData() {
  final firestoreData = mapToFirestore(
    <String, dynamic>{}.withoutNulls,
  );

  return firestoreData;
}

class IncomeRecordDocumentEquality implements Equality<IncomeRecord> {
  const IncomeRecordDocumentEquality();

  @override
  bool equals(IncomeRecord? e1, IncomeRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.type, e2?.type);
  }

  @override
  int hash(IncomeRecord? e) => const ListEquality().hash([e?.type]);

  @override
  bool isValidKey(Object? o) => o is IncomeRecord;
}
