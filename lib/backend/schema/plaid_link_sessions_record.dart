import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlaidLinkSessionsRecord extends FirestoreRecord {
  PlaidLinkSessionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "webUrl" field.
  String? _webUrl;
  String get webUrl => _webUrl ?? '';
  bool hasWebUrl() => _webUrl != null;

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _webUrl = snapshotData['webUrl'] as String?;
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('plaid_link_sessions');

  static Stream<PlaidLinkSessionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PlaidLinkSessionsRecord.fromSnapshot(s));

  static Future<PlaidLinkSessionsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => PlaidLinkSessionsRecord.fromSnapshot(s));

  static PlaidLinkSessionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PlaidLinkSessionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PlaidLinkSessionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PlaidLinkSessionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PlaidLinkSessionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PlaidLinkSessionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPlaidLinkSessionsRecordData({
  String? webUrl,
  DocumentReference? userRef,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'webUrl': webUrl,
      'userRef': userRef,
      'createdAt': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class PlaidLinkSessionsRecordDocumentEquality
    implements Equality<PlaidLinkSessionsRecord> {
  const PlaidLinkSessionsRecordDocumentEquality();

  @override
  bool equals(PlaidLinkSessionsRecord? e1, PlaidLinkSessionsRecord? e2) {
    return e1?.webUrl == e2?.webUrl &&
        e1?.userRef == e2?.userRef &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(PlaidLinkSessionsRecord? e) =>
      const ListEquality().hash([e?.webUrl, e?.userRef, e?.createdAt]);

  @override
  bool isValidKey(Object? o) => o is PlaidLinkSessionsRecord;
}
