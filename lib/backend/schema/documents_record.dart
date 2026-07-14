import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DocumentsRecord extends FirestoreRecord {
  DocumentsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "isIncome" field.
  bool? _isIncome;
  bool get isIncome => _isIncome ?? false;
  bool hasIsIncome() => _isIncome != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "amount" field.
  double? _amount;
  double get amount => _amount ?? 0.0;
  bool hasAmount() => _amount != null;

  // "isRecurrent" field.
  bool? _isRecurrent;
  bool get isRecurrent => _isRecurrent ?? false;
  bool hasIsRecurrent() => _isRecurrent != null;

  // "frequency" field.
  String? _frequency;
  String get frequency => _frequency ?? '';
  bool hasFrequency() => _frequency != null;

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "recurrenceId" field.
  String? _recurrenceId;
  String get recurrenceId => _recurrenceId ?? '';
  bool hasRecurrenceId() => _recurrenceId != null;

  // "frequencyCode" field.
  int? _frequencyCode;
  int get frequencyCode => _frequencyCode ?? 0;
  bool hasFrequencyCode() => _frequencyCode != null;

  // "notificationAt" field.
  int? _notificationAt;
  int get notificationAt => _notificationAt ?? 0;
  bool hasNotificationAt() => _notificationAt != null;

  // "isOtherExpenses" field.
  bool? _isOtherExpenses;
  bool get isOtherExpenses => _isOtherExpenses ?? false;
  bool hasIsOtherExpenses() => _isOtherExpenses != null;

  // "isSave" field.
  bool? _isSave;
  bool get isSave => _isSave ?? false;
  bool hasIsSave() => _isSave != null;

  // "isExpenses" field.
  bool? _isExpenses;
  bool get isExpenses => _isExpenses ?? false;
  bool hasIsExpenses() => _isExpenses != null;

  // "isEvent" field.
  bool? _isEvent;
  bool get isEvent => _isEvent ?? false;
  bool hasIsEvent() => _isEvent != null;

  // "source" field.
  String? _source;
  String get source => _source ?? '';
  bool hasSource() => _source != null;

  // "plaidTransactionId" field.
  String? _plaidTransactionId;
  String get plaidTransactionId => _plaidTransactionId ?? '';
  bool hasPlaidTransactionId() => _plaidTransactionId != null;

  // "plaidAccountId" field.
  String? _plaidAccountId;
  String get plaidAccountId => _plaidAccountId ?? '';
  bool hasPlaidAccountId() => _plaidAccountId != null;

  // "isoCurrencyCode" field.
  String? _isoCurrencyCode;
  String get isoCurrencyCode => _isoCurrencyCode ?? '';
  bool hasIsoCurrencyCode() => _isoCurrencyCode != null;

  // "personalFinanceCategoryPrimary" field.
  String? _personalFinanceCategoryPrimary;
  String get personalFinanceCategoryPrimary =>
      _personalFinanceCategoryPrimary ?? '';
  bool hasPersonalFinanceCategoryPrimary() =>
      _personalFinanceCategoryPrimary != null;

  // "personalFinanceCategoryDetailed" field.
  String? _personalFinanceCategoryDetailed;
  String get personalFinanceCategoryDetailed =>
      _personalFinanceCategoryDetailed ?? '';
  bool hasPersonalFinanceCategoryDetailed() =>
      _personalFinanceCategoryDetailed != null;

  // "lastPlaidSyncAt" field.
  DateTime? _lastPlaidSyncAt;
  DateTime? get lastPlaidSyncAt => _lastPlaidSyncAt;
  bool hasLastPlaidSyncAt() => _lastPlaidSyncAt != null;

  // "isGoal" field.
  bool? _isGoal;
  bool get isGoal => _isGoal ?? false;
  bool hasIsGoal() => _isGoal != null;

  // "isInternalTransfer" field.
  bool? _isInternalTransfer;
  bool get isInternalTransfer => _isInternalTransfer ?? false;
  bool hasIsInternalTransfer() => _isInternalTransfer != null;

  // "transferPairId" field.
  String? _transferPairId;
  String get transferPairId => _transferPairId ?? '';
  bool hasTransferPairId() => _transferPairId != null;

  // "linkedAccountId" field.
  String? _linkedAccountId;
  String get linkedAccountId => _linkedAccountId ?? '';
  bool hasLinkedAccountId() => _linkedAccountId != null;

  // "transferId" field.
  String? _transferId;
  String get transferId => _transferId ?? '';
  bool hasTransferId() => _transferId != null;

  // "subtype" field.
  String? _subtype;
  String get subtype => _subtype ?? '';
  bool hasSubtype() => _subtype != null;

  // "isNotificationScheduledSent" field.
  bool? _isNotificationScheduledSent;
  bool get isNotificationScheduledSent => _isNotificationScheduledSent ?? false;
  bool hasIsNotificationScheduledSent() => _isNotificationScheduledSent != null;

  // "isNotificationTodaySent" field.
  bool? _isNotificationTodaySent;
  bool get isNotificationTodaySent => _isNotificationTodaySent ?? false;
  bool hasIsNotificationTodaySent() => _isNotificationTodaySent != null;

  // "isPending" field.
  bool? _isPending;
  bool get isPending => _isPending ?? false;
  bool hasIsPending() => _isPending != null;

  // "merchantName" field.
  String? _merchantName;
  String get merchantName => _merchantName ?? '';
  bool hasMerchantName() => _merchantName != null;

  // "merchantId" field.
  String? _merchantId;
  String get merchantId => _merchantId ?? '';
  bool hasMerchantId() => _merchantId != null;

  // "merchantWebsite" field.
  String? _merchantWebsite;
  String get merchantWebsite => _merchantWebsite ?? '';
  bool hasMerchantWebsite() => _merchantWebsite != null;

  // "merchantLogo" field.
  String? _merchantLogo;
  String get merchantLogo => _merchantLogo ?? '';
  bool hasMerchantLogo() => _merchantLogo != null;

  // "goaldName" field.
  String? _goaldName;
  String get goaldName => _goaldName ?? '';
  bool hasGoaldName() => _goaldName != null;

  // "accountName" field.
  String? _accountName;
  String get accountName => _accountName ?? '';
  bool hasAccountName() => _accountName != null;

  // "date" field.
  String? _date;
  String get date => _date ?? '';
  bool hasDate() => _date != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "occurrenceKey" field.
  int? _occurrenceKey;
  int get occurrenceKey => _occurrenceKey ?? 0;
  bool hasOccurrenceKey() => _occurrenceKey != null;

  // "institutionName" field.
  String? _institutionName;
  String get institutionName => _institutionName ?? '';
  bool hasInstitutionName() => _institutionName != null;

  // "isRemoved" field.
  bool? _isRemoved;
  bool get isRemoved => _isRemoved ?? false;
  bool hasIsRemoved() => _isRemoved != null;

  // "updatedAt" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "isConfirmed" field.
  bool? _isConfirmed;
  bool get isConfirmed => _isConfirmed ?? false;
  bool hasIsConfirmed() => _isConfirmed != null;

  // "note" field.
  String? _note;
  String get note => _note ?? '';
  bool hasNote() => _note != null;

  // "isRealTransaction" field.
  bool? _isRealTransaction;
  bool get isRealTransaction => _isRealTransaction ?? false;
  bool hasIsRealTransaction() => _isRealTransaction != null;

  // "authorizedDate" field.
  String? _authorizedDate;
  String get authorizedDate => _authorizedDate ?? '';
  bool hasAuthorizedDate() => _authorizedDate != null;

  // "creditCardName" field.
  String? _creditCardName;
  String get creditCardName => _creditCardName ?? '';
  bool hasCreditCardName() => _creditCardName != null;

  void _initializeFields() {
    _type = snapshotData['type'] as String?;
    _isIncome = snapshotData['isIncome'] as bool?;
    _description = snapshotData['description'] as String?;
    _amount = castToType<double>(snapshotData['amount']);
    _isRecurrent = snapshotData['isRecurrent'] as bool?;
    _frequency = snapshotData['frequency'] as String?;
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _recurrenceId = snapshotData['recurrenceId'] as String?;
    _frequencyCode = castToType<int>(snapshotData['frequencyCode']);
    _notificationAt = castToType<int>(snapshotData['notificationAt']);
    _isOtherExpenses = snapshotData['isOtherExpenses'] as bool?;
    _isSave = snapshotData['isSave'] as bool?;
    _isExpenses = snapshotData['isExpenses'] as bool?;
    _isEvent = snapshotData['isEvent'] as bool?;
    _source = snapshotData['source'] as String?;
    _plaidTransactionId = snapshotData['plaidTransactionId'] as String?;
    _plaidAccountId = snapshotData['plaidAccountId'] as String?;
    _isoCurrencyCode = snapshotData['isoCurrencyCode'] as String?;
    _personalFinanceCategoryPrimary =
        snapshotData['personalFinanceCategoryPrimary'] as String?;
    _personalFinanceCategoryDetailed =
        snapshotData['personalFinanceCategoryDetailed'] as String?;
    _lastPlaidSyncAt = snapshotData['lastPlaidSyncAt'] as DateTime?;
    _isGoal = snapshotData['isGoal'] as bool?;
    _isInternalTransfer = snapshotData['isInternalTransfer'] as bool?;
    _transferPairId = snapshotData['transferPairId'] as String?;
    _linkedAccountId = snapshotData['linkedAccountId'] as String?;
    _transferId = snapshotData['transferId'] as String?;
    _subtype = snapshotData['subtype'] as String?;
    _isNotificationScheduledSent =
        snapshotData['isNotificationScheduledSent'] as bool?;
    _isNotificationTodaySent = snapshotData['isNotificationTodaySent'] as bool?;
    _isPending = snapshotData['isPending'] as bool?;
    _merchantName = snapshotData['merchantName'] as String?;
    _merchantId = snapshotData['merchantId'] as String?;
    _merchantWebsite = snapshotData['merchantWebsite'] as String?;
    _merchantLogo = snapshotData['merchantLogo'] as String?;
    _goaldName = snapshotData['goaldName'] as String?;
    _accountName = snapshotData['accountName'] as String?;
    _date = snapshotData['date'] as String?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _occurrenceKey = castToType<int>(snapshotData['occurrenceKey']);
    _institutionName = snapshotData['institutionName'] as String?;
    _isRemoved = snapshotData['isRemoved'] as bool?;
    _updatedAt = snapshotData['updatedAt'] as DateTime?;
    _isConfirmed = snapshotData['isConfirmed'] as bool?;
    _note = snapshotData['note'] as String?;
    _isRealTransaction = snapshotData['isRealTransaction'] as bool?;
    _authorizedDate = snapshotData['authorizedDate'] as String?;
    _creditCardName = snapshotData['creditCardName'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('documents');

  static Stream<DocumentsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DocumentsRecord.fromSnapshot(s));

  static Future<DocumentsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DocumentsRecord.fromSnapshot(s));

  static DocumentsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DocumentsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DocumentsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DocumentsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DocumentsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DocumentsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDocumentsRecordData({
  String? type,
  bool? isIncome,
  String? description,
  double? amount,
  bool? isRecurrent,
  String? frequency,
  DocumentReference? userRef,
  String? recurrenceId,
  int? frequencyCode,
  int? notificationAt,
  bool? isOtherExpenses,
  bool? isSave,
  bool? isExpenses,
  bool? isEvent,
  String? source,
  String? plaidTransactionId,
  String? plaidAccountId,
  String? isoCurrencyCode,
  String? personalFinanceCategoryPrimary,
  String? personalFinanceCategoryDetailed,
  DateTime? lastPlaidSyncAt,
  bool? isGoal,
  bool? isInternalTransfer,
  String? transferPairId,
  String? linkedAccountId,
  String? transferId,
  String? subtype,
  bool? isNotificationScheduledSent,
  bool? isNotificationTodaySent,
  bool? isPending,
  String? merchantName,
  String? merchantId,
  String? merchantWebsite,
  String? merchantLogo,
  String? goaldName,
  String? accountName,
  String? date,
  DateTime? createdAt,
  int? occurrenceKey,
  String? institutionName,
  bool? isRemoved,
  DateTime? updatedAt,
  bool? isConfirmed,
  String? note,
  bool? isRealTransaction,
  String? authorizedDate,
  String? creditCardName,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'type': type,
      'isIncome': isIncome,
      'description': description,
      'amount': amount,
      'isRecurrent': isRecurrent,
      'frequency': frequency,
      'userRef': userRef,
      'recurrenceId': recurrenceId,
      'frequencyCode': frequencyCode,
      'notificationAt': notificationAt,
      'isOtherExpenses': isOtherExpenses,
      'isSave': isSave,
      'isExpenses': isExpenses,
      'isEvent': isEvent,
      'source': source,
      'plaidTransactionId': plaidTransactionId,
      'plaidAccountId': plaidAccountId,
      'isoCurrencyCode': isoCurrencyCode,
      'personalFinanceCategoryPrimary': personalFinanceCategoryPrimary,
      'personalFinanceCategoryDetailed': personalFinanceCategoryDetailed,
      'lastPlaidSyncAt': lastPlaidSyncAt,
      'isGoal': isGoal,
      'isInternalTransfer': isInternalTransfer,
      'transferPairId': transferPairId,
      'linkedAccountId': linkedAccountId,
      'transferId': transferId,
      'subtype': subtype,
      'isNotificationScheduledSent': isNotificationScheduledSent,
      'isNotificationTodaySent': isNotificationTodaySent,
      'isPending': isPending,
      'merchantName': merchantName,
      'merchantId': merchantId,
      'merchantWebsite': merchantWebsite,
      'merchantLogo': merchantLogo,
      'goaldName': goaldName,
      'accountName': accountName,
      'date': date,
      'createdAt': createdAt,
      'occurrenceKey': occurrenceKey,
      'institutionName': institutionName,
      'isRemoved': isRemoved,
      'updatedAt': updatedAt,
      'isConfirmed': isConfirmed,
      'note': note,
      'isRealTransaction': isRealTransaction,
      'authorizedDate': authorizedDate,
      'creditCardName': creditCardName,
    }.withoutNulls,
  );

  return firestoreData;
}

class DocumentsRecordDocumentEquality implements Equality<DocumentsRecord> {
  const DocumentsRecordDocumentEquality();

  @override
  bool equals(DocumentsRecord? e1, DocumentsRecord? e2) {
    return e1?.type == e2?.type &&
        e1?.isIncome == e2?.isIncome &&
        e1?.description == e2?.description &&
        e1?.amount == e2?.amount &&
        e1?.isRecurrent == e2?.isRecurrent &&
        e1?.frequency == e2?.frequency &&
        e1?.userRef == e2?.userRef &&
        e1?.recurrenceId == e2?.recurrenceId &&
        e1?.frequencyCode == e2?.frequencyCode &&
        e1?.notificationAt == e2?.notificationAt &&
        e1?.isOtherExpenses == e2?.isOtherExpenses &&
        e1?.isSave == e2?.isSave &&
        e1?.isExpenses == e2?.isExpenses &&
        e1?.isEvent == e2?.isEvent &&
        e1?.source == e2?.source &&
        e1?.plaidTransactionId == e2?.plaidTransactionId &&
        e1?.plaidAccountId == e2?.plaidAccountId &&
        e1?.isoCurrencyCode == e2?.isoCurrencyCode &&
        e1?.personalFinanceCategoryPrimary ==
            e2?.personalFinanceCategoryPrimary &&
        e1?.personalFinanceCategoryDetailed ==
            e2?.personalFinanceCategoryDetailed &&
        e1?.lastPlaidSyncAt == e2?.lastPlaidSyncAt &&
        e1?.isGoal == e2?.isGoal &&
        e1?.isInternalTransfer == e2?.isInternalTransfer &&
        e1?.transferPairId == e2?.transferPairId &&
        e1?.linkedAccountId == e2?.linkedAccountId &&
        e1?.transferId == e2?.transferId &&
        e1?.subtype == e2?.subtype &&
        e1?.isNotificationScheduledSent == e2?.isNotificationScheduledSent &&
        e1?.isNotificationTodaySent == e2?.isNotificationTodaySent &&
        e1?.isPending == e2?.isPending &&
        e1?.merchantName == e2?.merchantName &&
        e1?.merchantId == e2?.merchantId &&
        e1?.merchantWebsite == e2?.merchantWebsite &&
        e1?.merchantLogo == e2?.merchantLogo &&
        e1?.goaldName == e2?.goaldName &&
        e1?.accountName == e2?.accountName &&
        e1?.date == e2?.date &&
        e1?.createdAt == e2?.createdAt &&
        e1?.occurrenceKey == e2?.occurrenceKey &&
        e1?.institutionName == e2?.institutionName &&
        e1?.isRemoved == e2?.isRemoved &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.isConfirmed == e2?.isConfirmed &&
        e1?.note == e2?.note &&
        e1?.isRealTransaction == e2?.isRealTransaction &&
        e1?.authorizedDate == e2?.authorizedDate &&
        e1?.creditCardName == e2?.creditCardName;
  }

  @override
  int hash(DocumentsRecord? e) => const ListEquality().hash([
        e?.type,
        e?.isIncome,
        e?.description,
        e?.amount,
        e?.isRecurrent,
        e?.frequency,
        e?.userRef,
        e?.recurrenceId,
        e?.frequencyCode,
        e?.notificationAt,
        e?.isOtherExpenses,
        e?.isSave,
        e?.isExpenses,
        e?.isEvent,
        e?.source,
        e?.plaidTransactionId,
        e?.plaidAccountId,
        e?.isoCurrencyCode,
        e?.personalFinanceCategoryPrimary,
        e?.personalFinanceCategoryDetailed,
        e?.lastPlaidSyncAt,
        e?.isGoal,
        e?.isInternalTransfer,
        e?.transferPairId,
        e?.linkedAccountId,
        e?.transferId,
        e?.subtype,
        e?.isNotificationScheduledSent,
        e?.isNotificationTodaySent,
        e?.isPending,
        e?.merchantName,
        e?.merchantId,
        e?.merchantWebsite,
        e?.merchantLogo,
        e?.goaldName,
        e?.accountName,
        e?.date,
        e?.createdAt,
        e?.occurrenceKey,
        e?.institutionName,
        e?.isRemoved,
        e?.updatedAt,
        e?.isConfirmed,
        e?.note,
        e?.isRealTransaction,
        e?.authorizedDate,
        e?.creditCardName
      ]);

  @override
  bool isValidKey(Object? o) => o is DocumentsRecord;
}
