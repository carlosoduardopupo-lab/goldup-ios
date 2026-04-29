import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FrasesRecord extends FirestoreRecord {
  FrasesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  void _initializeFields() {
    _text = snapshotData['text'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('frases');

  static Stream<FrasesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => FrasesRecord.fromSnapshot(s));

  static Future<FrasesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => FrasesRecord.fromSnapshot(s));

  static FrasesRecord fromSnapshot(DocumentSnapshot snapshot) => FrasesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FrasesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FrasesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FrasesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FrasesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createFrasesRecordData({
  String? text,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'text': text,
    }.withoutNulls,
  );

  return firestoreData;
}

class FrasesRecordDocumentEquality implements Equality<FrasesRecord> {
  const FrasesRecordDocumentEquality();

  @override
  bool equals(FrasesRecord? e1, FrasesRecord? e2) {
    return e1?.text == e2?.text;
  }

  @override
  int hash(FrasesRecord? e) => const ListEquality().hash([e?.text]);

  @override
  bool isValidKey(Object? o) => o is FrasesRecord;
}
