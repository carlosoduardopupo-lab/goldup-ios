import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SaveRecord extends FirestoreRecord {
  SaveRecord._(
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
      FirebaseFirestore.instance.collection('save');

  static Stream<SaveRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SaveRecord.fromSnapshot(s));

  static Future<SaveRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SaveRecord.fromSnapshot(s));

  static SaveRecord fromSnapshot(DocumentSnapshot snapshot) => SaveRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SaveRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SaveRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SaveRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SaveRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSaveRecordData() {
  final firestoreData = mapToFirestore(
    <String, dynamic>{}.withoutNulls,
  );

  return firestoreData;
}

class SaveRecordDocumentEquality implements Equality<SaveRecord> {
  const SaveRecordDocumentEquality();

  @override
  bool equals(SaveRecord? e1, SaveRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.type, e2?.type);
  }

  @override
  int hash(SaveRecord? e) => const ListEquality().hash([e?.type]);

  @override
  bool isValidKey(Object? o) => o is SaveRecord;
}
