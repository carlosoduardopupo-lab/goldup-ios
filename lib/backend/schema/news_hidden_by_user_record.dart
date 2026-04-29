import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NewsHiddenByUserRecord extends FirestoreRecord {
  NewsHiddenByUserRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "newsRef" field.
  DocumentReference? _newsRef;
  DocumentReference? get newsRef => _newsRef;
  bool hasNewsRef() => _newsRef != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _newsRef = snapshotData['newsRef'] as DocumentReference?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('newsHiddenByUser');

  static Stream<NewsHiddenByUserRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => NewsHiddenByUserRecord.fromSnapshot(s));

  static Future<NewsHiddenByUserRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => NewsHiddenByUserRecord.fromSnapshot(s));

  static NewsHiddenByUserRecord fromSnapshot(DocumentSnapshot snapshot) =>
      NewsHiddenByUserRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NewsHiddenByUserRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NewsHiddenByUserRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NewsHiddenByUserRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NewsHiddenByUserRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createNewsHiddenByUserRecordData({
  DocumentReference? userRef,
  DocumentReference? newsRef,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userRef': userRef,
      'newsRef': newsRef,
      'createdAt': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class NewsHiddenByUserRecordDocumentEquality
    implements Equality<NewsHiddenByUserRecord> {
  const NewsHiddenByUserRecordDocumentEquality();

  @override
  bool equals(NewsHiddenByUserRecord? e1, NewsHiddenByUserRecord? e2) {
    return e1?.userRef == e2?.userRef &&
        e1?.newsRef == e2?.newsRef &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(NewsHiddenByUserRecord? e) =>
      const ListEquality().hash([e?.userRef, e?.newsRef, e?.createdAt]);

  @override
  bool isValidKey(Object? o) => o is NewsHiddenByUserRecord;
}
