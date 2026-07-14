import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatsIARecord extends FirestoreRecord {
  ChatsIARecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "isIA" field.
  bool? _isIA;
  bool get isIA => _isIA ?? false;
  bool hasIsIA() => _isIA != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "isSuggestion" field.
  bool? _isSuggestion;
  bool get isSuggestion => _isSuggestion ?? false;
  bool hasIsSuggestion() => _isSuggestion != null;

  void _initializeFields() {
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _text = snapshotData['text'] as String?;
    _isIA = snapshotData['isIA'] as bool?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _uid = snapshotData['uid'] as String?;
    _isSuggestion = snapshotData['isSuggestion'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chatsIA');

  static Stream<ChatsIARecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChatsIARecord.fromSnapshot(s));

  static Future<ChatsIARecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChatsIARecord.fromSnapshot(s));

  static ChatsIARecord fromSnapshot(DocumentSnapshot snapshot) =>
      ChatsIARecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChatsIARecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChatsIARecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChatsIARecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChatsIARecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChatsIARecordData({
  DocumentReference? userRef,
  String? text,
  bool? isIA,
  DateTime? createdAt,
  String? uid,
  bool? isSuggestion,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userRef': userRef,
      'text': text,
      'isIA': isIA,
      'createdAt': createdAt,
      'uid': uid,
      'isSuggestion': isSuggestion,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChatsIARecordDocumentEquality implements Equality<ChatsIARecord> {
  const ChatsIARecordDocumentEquality();

  @override
  bool equals(ChatsIARecord? e1, ChatsIARecord? e2) {
    return e1?.userRef == e2?.userRef &&
        e1?.text == e2?.text &&
        e1?.isIA == e2?.isIA &&
        e1?.createdAt == e2?.createdAt &&
        e1?.uid == e2?.uid &&
        e1?.isSuggestion == e2?.isSuggestion;
  }

  @override
  int hash(ChatsIARecord? e) => const ListEquality().hash(
      [e?.userRef, e?.text, e?.isIA, e?.createdAt, e?.uid, e?.isSuggestion]);

  @override
  bool isValidKey(Object? o) => o is ChatsIARecord;
}
