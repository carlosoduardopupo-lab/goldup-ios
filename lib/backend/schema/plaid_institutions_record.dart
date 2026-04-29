import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlaidInstitutionsRecord extends FirestoreRecord {
  PlaidInstitutionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "institutionId" field.
  String? _institutionId;
  String get institutionId => _institutionId ?? '';
  bool hasInstitutionId() => _institutionId != null;

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  void _initializeFields() {
    _institutionId = snapshotData['institutionId'] as String?;
    _userRef = snapshotData['userRef'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('plaid_institutions');

  static Stream<PlaidInstitutionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PlaidInstitutionsRecord.fromSnapshot(s));

  static Future<PlaidInstitutionsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => PlaidInstitutionsRecord.fromSnapshot(s));

  static PlaidInstitutionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PlaidInstitutionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PlaidInstitutionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PlaidInstitutionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PlaidInstitutionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PlaidInstitutionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPlaidInstitutionsRecordData({
  String? institutionId,
  DocumentReference? userRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'institutionId': institutionId,
      'userRef': userRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class PlaidInstitutionsRecordDocumentEquality
    implements Equality<PlaidInstitutionsRecord> {
  const PlaidInstitutionsRecordDocumentEquality();

  @override
  bool equals(PlaidInstitutionsRecord? e1, PlaidInstitutionsRecord? e2) {
    return e1?.institutionId == e2?.institutionId && e1?.userRef == e2?.userRef;
  }

  @override
  int hash(PlaidInstitutionsRecord? e) =>
      const ListEquality().hash([e?.institutionId, e?.userRef]);

  @override
  bool isValidKey(Object? o) => o is PlaidInstitutionsRecord;
}
