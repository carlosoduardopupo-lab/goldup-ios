import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FeedItemsRecord extends FirestoreRecord {
  FeedItemsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "position" field.
  int? _position;
  int get position => _position ?? 0;
  bool hasPosition() => _position != null;

  // "newsRef" field.
  DocumentReference? _newsRef;
  DocumentReference? get newsRef => _newsRef;
  bool hasNewsRef() => _newsRef != null;

  // "adRef" field.
  DocumentReference? _adRef;
  DocumentReference? get adRef => _adRef;
  bool hasAdRef() => _adRef != null;

  // "isActive" field.
  bool? _isActive;
  bool get isActive => _isActive ?? false;
  bool hasIsActive() => _isActive != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "profile" field.
  String? _profile;
  String get profile => _profile ?? '';
  bool hasProfile() => _profile != null;

  void _initializeFields() {
    _type = snapshotData['type'] as String?;
    _position = castToType<int>(snapshotData['position']);
    _newsRef = snapshotData['newsRef'] as DocumentReference?;
    _adRef = snapshotData['adRef'] as DocumentReference?;
    _isActive = snapshotData['isActive'] as bool?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _profile = snapshotData['profile'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('feedItems');

  static Stream<FeedItemsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => FeedItemsRecord.fromSnapshot(s));

  static Future<FeedItemsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => FeedItemsRecord.fromSnapshot(s));

  static FeedItemsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      FeedItemsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FeedItemsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FeedItemsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FeedItemsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FeedItemsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createFeedItemsRecordData({
  String? type,
  int? position,
  DocumentReference? newsRef,
  DocumentReference? adRef,
  bool? isActive,
  DateTime? createdAt,
  String? profile,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'type': type,
      'position': position,
      'newsRef': newsRef,
      'adRef': adRef,
      'isActive': isActive,
      'createdAt': createdAt,
      'profile': profile,
    }.withoutNulls,
  );

  return firestoreData;
}

class FeedItemsRecordDocumentEquality implements Equality<FeedItemsRecord> {
  const FeedItemsRecordDocumentEquality();

  @override
  bool equals(FeedItemsRecord? e1, FeedItemsRecord? e2) {
    return e1?.type == e2?.type &&
        e1?.position == e2?.position &&
        e1?.newsRef == e2?.newsRef &&
        e1?.adRef == e2?.adRef &&
        e1?.isActive == e2?.isActive &&
        e1?.createdAt == e2?.createdAt &&
        e1?.profile == e2?.profile;
  }

  @override
  int hash(FeedItemsRecord? e) => const ListEquality().hash([
        e?.type,
        e?.position,
        e?.newsRef,
        e?.adRef,
        e?.isActive,
        e?.createdAt,
        e?.profile
      ]);

  @override
  bool isValidKey(Object? o) => o is FeedItemsRecord;
}
