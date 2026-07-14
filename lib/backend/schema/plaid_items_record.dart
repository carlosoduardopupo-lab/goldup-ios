import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlaidItemsRecord extends FirestoreRecord {
  PlaidItemsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "itemId" field.
  String? _itemId;
  String get itemId => _itemId ?? '';
  bool hasItemId() => _itemId != null;

  // "accessToken" field.
  String? _accessToken;
  String get accessToken => _accessToken ?? '';
  bool hasAccessToken() => _accessToken != null;

  // "institutionId" field.
  String? _institutionId;
  String get institutionId => _institutionId ?? '';
  bool hasInstitutionId() => _institutionId != null;

  // "institutionName" field.
  String? _institutionName;
  String get institutionName => _institutionName ?? '';
  bool hasInstitutionName() => _institutionName != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "cursor" field.
  String? _cursor;
  String get cursor => _cursor ?? '';
  bool hasCursor() => _cursor != null;

  // "lastWebhookCode" field.
  String? _lastWebhookCode;
  String get lastWebhookCode => _lastWebhookCode ?? '';
  bool hasLastWebhookCode() => _lastWebhookCode != null;

  // "lastWebhookType" field.
  String? _lastWebhookType;
  String get lastWebhookType => _lastWebhookType ?? '';
  bool hasLastWebhookType() => _lastWebhookType != null;

  // "lastWebhookAt" field.
  DateTime? _lastWebhookAt;
  DateTime? get lastWebhookAt => _lastWebhookAt;
  bool hasLastWebhookAt() => _lastWebhookAt != null;

  // "lastSyncRequestId" field.
  String? _lastSyncRequestId;
  String get lastSyncRequestId => _lastSyncRequestId ?? '';
  bool hasLastSyncRequestId() => _lastSyncRequestId != null;

  // "lastSyncedAt" field.
  DateTime? _lastSyncedAt;
  DateTime? get lastSyncedAt => _lastSyncedAt;
  bool hasLastSyncedAt() => _lastSyncedAt != null;

  // "updatedAt" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "needsAttention" field.
  bool? _needsAttention;
  bool get needsAttention => _needsAttention ?? false;
  bool hasNeedsAttention() => _needsAttention != null;

  // "needsBalanceRefresh" field.
  bool? _needsBalanceRefresh;
  bool get needsBalanceRefresh => _needsBalanceRefresh ?? false;
  bool hasNeedsBalanceRefresh() => _needsBalanceRefresh != null;

  // "needsSync" field.
  bool? _needsSync;
  bool get needsSync => _needsSync ?? false;
  bool hasNeedsSync() => _needsSync != null;

  void _initializeFields() {
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _itemId = snapshotData['itemId'] as String?;
    _accessToken = snapshotData['accessToken'] as String?;
    _institutionId = snapshotData['institutionId'] as String?;
    _institutionName = snapshotData['institutionName'] as String?;
    _status = snapshotData['status'] as String?;
    _cursor = snapshotData['cursor'] as String?;
    _lastWebhookCode = snapshotData['lastWebhookCode'] as String?;
    _lastWebhookType = snapshotData['lastWebhookType'] as String?;
    _lastWebhookAt = snapshotData['lastWebhookAt'] as DateTime?;
    _lastSyncRequestId = snapshotData['lastSyncRequestId'] as String?;
    _lastSyncedAt = snapshotData['lastSyncedAt'] as DateTime?;
    _updatedAt = snapshotData['updatedAt'] as DateTime?;
    _needsAttention = snapshotData['needsAttention'] as bool?;
    _needsBalanceRefresh = snapshotData['needsBalanceRefresh'] as bool?;
    _needsSync = snapshotData['needsSync'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('plaid_items');

  static Stream<PlaidItemsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PlaidItemsRecord.fromSnapshot(s));

  static Future<PlaidItemsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PlaidItemsRecord.fromSnapshot(s));

  static PlaidItemsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PlaidItemsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PlaidItemsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PlaidItemsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PlaidItemsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PlaidItemsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPlaidItemsRecordData({
  DocumentReference? userRef,
  DateTime? createdAt,
  String? itemId,
  String? accessToken,
  String? institutionId,
  String? institutionName,
  String? status,
  String? cursor,
  String? lastWebhookCode,
  String? lastWebhookType,
  DateTime? lastWebhookAt,
  String? lastSyncRequestId,
  DateTime? lastSyncedAt,
  DateTime? updatedAt,
  bool? needsAttention,
  bool? needsBalanceRefresh,
  bool? needsSync,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userRef': userRef,
      'createdAt': createdAt,
      'itemId': itemId,
      'accessToken': accessToken,
      'institutionId': institutionId,
      'institutionName': institutionName,
      'status': status,
      'cursor': cursor,
      'lastWebhookCode': lastWebhookCode,
      'lastWebhookType': lastWebhookType,
      'lastWebhookAt': lastWebhookAt,
      'lastSyncRequestId': lastSyncRequestId,
      'lastSyncedAt': lastSyncedAt,
      'updatedAt': updatedAt,
      'needsAttention': needsAttention,
      'needsBalanceRefresh': needsBalanceRefresh,
      'needsSync': needsSync,
    }.withoutNulls,
  );

  return firestoreData;
}

class PlaidItemsRecordDocumentEquality implements Equality<PlaidItemsRecord> {
  const PlaidItemsRecordDocumentEquality();

  @override
  bool equals(PlaidItemsRecord? e1, PlaidItemsRecord? e2) {
    return e1?.userRef == e2?.userRef &&
        e1?.createdAt == e2?.createdAt &&
        e1?.itemId == e2?.itemId &&
        e1?.accessToken == e2?.accessToken &&
        e1?.institutionId == e2?.institutionId &&
        e1?.institutionName == e2?.institutionName &&
        e1?.status == e2?.status &&
        e1?.cursor == e2?.cursor &&
        e1?.lastWebhookCode == e2?.lastWebhookCode &&
        e1?.lastWebhookType == e2?.lastWebhookType &&
        e1?.lastWebhookAt == e2?.lastWebhookAt &&
        e1?.lastSyncRequestId == e2?.lastSyncRequestId &&
        e1?.lastSyncedAt == e2?.lastSyncedAt &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.needsAttention == e2?.needsAttention &&
        e1?.needsBalanceRefresh == e2?.needsBalanceRefresh &&
        e1?.needsSync == e2?.needsSync;
  }

  @override
  int hash(PlaidItemsRecord? e) => const ListEquality().hash([
        e?.userRef,
        e?.createdAt,
        e?.itemId,
        e?.accessToken,
        e?.institutionId,
        e?.institutionName,
        e?.status,
        e?.cursor,
        e?.lastWebhookCode,
        e?.lastWebhookType,
        e?.lastWebhookAt,
        e?.lastSyncRequestId,
        e?.lastSyncedAt,
        e?.updatedAt,
        e?.needsAttention,
        e?.needsBalanceRefresh,
        e?.needsSync
      ]);

  @override
  bool isValidKey(Object? o) => o is PlaidItemsRecord;
}
