import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GoaldsRecord extends FirestoreRecord {
  GoaldsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "startedDate" field.
  DateTime? _startedDate;
  DateTime? get startedDate => _startedDate;
  bool hasStartedDate() => _startedDate != null;

  // "finishedDate" field.
  DateTime? _finishedDate;
  DateTime? get finishedDate => _finishedDate;
  bool hasFinishedDate() => _finishedDate != null;

  // "updatedDate" field.
  DateTime? _updatedDate;
  DateTime? get updatedDate => _updatedDate;
  bool hasUpdatedDate() => _updatedDate != null;

  // "totalAmount" field.
  double? _totalAmount;
  double get totalAmount => _totalAmount ?? 0.0;
  bool hasTotalAmount() => _totalAmount != null;

  // "quotes" field.
  double? _quotes;
  double get quotes => _quotes ?? 0.0;
  bool hasQuotes() => _quotes != null;

  // "porcent" field.
  double? _porcent;
  double get porcent => _porcent ?? 0.0;
  bool hasPorcent() => _porcent != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "freuency" field.
  String? _freuency;
  String get freuency => _freuency ?? '';
  bool hasFreuency() => _freuency != null;

  // "autoContribution" field.
  double? _autoContribution;
  double get autoContribution => _autoContribution ?? 0.0;
  bool hasAutoContribution() => _autoContribution != null;

  // "isFrozen" field.
  bool? _isFrozen;
  bool get isFrozen => _isFrozen ?? false;
  bool hasIsFrozen() => _isFrozen != null;

  // "isComplited" field.
  bool? _isComplited;
  bool get isComplited => _isComplited ?? false;
  bool hasIsComplited() => _isComplited != null;

  // "currentAmount" field.
  double? _currentAmount;
  double get currentAmount => _currentAmount ?? 0.0;
  bool hasCurrentAmount() => _currentAmount != null;

  // "senderAccount" field.
  String? _senderAccount;
  String get senderAccount => _senderAccount ?? '';
  bool hasSenderAccount() => _senderAccount != null;

  // "resiverAccount" field.
  String? _resiverAccount;
  String get resiverAccount => _resiverAccount ?? '';
  bool hasResiverAccount() => _resiverAccount != null;

  // "ejecutionDates" field.
  List<DateTime>? _ejecutionDates;
  List<DateTime> get ejecutionDates => _ejecutionDates ?? const [];
  bool hasEjecutionDates() => _ejecutionDates != null;

  // "totalQuotesNumbers" field.
  int? _totalQuotesNumbers;
  int get totalQuotesNumbers => _totalQuotesNumbers ?? 0;
  bool hasTotalQuotesNumbers() => _totalQuotesNumbers != null;

  // "frequencyCode" field.
  int? _frequencyCode;
  int get frequencyCode => _frequencyCode ?? 0;
  bool hasFrequencyCode() => _frequencyCode != null;

  // "notificationAt" field.
  int? _notificationAt;
  int get notificationAt => _notificationAt ?? 0;
  bool hasNotificationAt() => _notificationAt != null;

  // "recurrentDocumentId" field.
  String? _recurrentDocumentId;
  String get recurrentDocumentId => _recurrentDocumentId ?? '';
  bool hasRecurrentDocumentId() => _recurrentDocumentId != null;

  // "transferId" field.
  String? _transferId;
  String get transferId => _transferId ?? '';
  bool hasTransferId() => _transferId != null;

  // "bank_accountsRef" field.
  DocumentReference? _bankAccountsRef;
  DocumentReference? get bankAccountsRef => _bankAccountsRef;
  bool hasBankAccountsRef() => _bankAccountsRef != null;

  void _initializeFields() {
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _startedDate = snapshotData['startedDate'] as DateTime?;
    _finishedDate = snapshotData['finishedDate'] as DateTime?;
    _updatedDate = snapshotData['updatedDate'] as DateTime?;
    _totalAmount = castToType<double>(snapshotData['totalAmount']);
    _quotes = castToType<double>(snapshotData['quotes']);
    _porcent = castToType<double>(snapshotData['porcent']);
    _name = snapshotData['name'] as String?;
    _description = snapshotData['description'] as String?;
    _status = snapshotData['status'] as String?;
    _freuency = snapshotData['freuency'] as String?;
    _autoContribution = castToType<double>(snapshotData['autoContribution']);
    _isFrozen = snapshotData['isFrozen'] as bool?;
    _isComplited = snapshotData['isComplited'] as bool?;
    _currentAmount = castToType<double>(snapshotData['currentAmount']);
    _senderAccount = snapshotData['senderAccount'] as String?;
    _resiverAccount = snapshotData['resiverAccount'] as String?;
    _ejecutionDates = getDataList(snapshotData['ejecutionDates']);
    _totalQuotesNumbers = castToType<int>(snapshotData['totalQuotesNumbers']);
    _frequencyCode = castToType<int>(snapshotData['frequencyCode']);
    _notificationAt = castToType<int>(snapshotData['notificationAt']);
    _recurrentDocumentId = snapshotData['recurrentDocumentId'] as String?;
    _transferId = snapshotData['transferId'] as String?;
    _bankAccountsRef = snapshotData['bank_accountsRef'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('goalds');

  static Stream<GoaldsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GoaldsRecord.fromSnapshot(s));

  static Future<GoaldsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GoaldsRecord.fromSnapshot(s));

  static GoaldsRecord fromSnapshot(DocumentSnapshot snapshot) => GoaldsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GoaldsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GoaldsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'GoaldsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GoaldsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGoaldsRecordData({
  DocumentReference? userRef,
  DateTime? startedDate,
  DateTime? finishedDate,
  DateTime? updatedDate,
  double? totalAmount,
  double? quotes,
  double? porcent,
  String? name,
  String? description,
  String? status,
  String? freuency,
  double? autoContribution,
  bool? isFrozen,
  bool? isComplited,
  double? currentAmount,
  String? senderAccount,
  String? resiverAccount,
  int? totalQuotesNumbers,
  int? frequencyCode,
  int? notificationAt,
  String? recurrentDocumentId,
  String? transferId,
  DocumentReference? bankAccountsRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userRef': userRef,
      'startedDate': startedDate,
      'finishedDate': finishedDate,
      'updatedDate': updatedDate,
      'totalAmount': totalAmount,
      'quotes': quotes,
      'porcent': porcent,
      'name': name,
      'description': description,
      'status': status,
      'freuency': freuency,
      'autoContribution': autoContribution,
      'isFrozen': isFrozen,
      'isComplited': isComplited,
      'currentAmount': currentAmount,
      'senderAccount': senderAccount,
      'resiverAccount': resiverAccount,
      'totalQuotesNumbers': totalQuotesNumbers,
      'frequencyCode': frequencyCode,
      'notificationAt': notificationAt,
      'recurrentDocumentId': recurrentDocumentId,
      'transferId': transferId,
      'bank_accountsRef': bankAccountsRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class GoaldsRecordDocumentEquality implements Equality<GoaldsRecord> {
  const GoaldsRecordDocumentEquality();

  @override
  bool equals(GoaldsRecord? e1, GoaldsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.userRef == e2?.userRef &&
        e1?.startedDate == e2?.startedDate &&
        e1?.finishedDate == e2?.finishedDate &&
        e1?.updatedDate == e2?.updatedDate &&
        e1?.totalAmount == e2?.totalAmount &&
        e1?.quotes == e2?.quotes &&
        e1?.porcent == e2?.porcent &&
        e1?.name == e2?.name &&
        e1?.description == e2?.description &&
        e1?.status == e2?.status &&
        e1?.freuency == e2?.freuency &&
        e1?.autoContribution == e2?.autoContribution &&
        e1?.isFrozen == e2?.isFrozen &&
        e1?.isComplited == e2?.isComplited &&
        e1?.currentAmount == e2?.currentAmount &&
        e1?.senderAccount == e2?.senderAccount &&
        e1?.resiverAccount == e2?.resiverAccount &&
        listEquality.equals(e1?.ejecutionDates, e2?.ejecutionDates) &&
        e1?.totalQuotesNumbers == e2?.totalQuotesNumbers &&
        e1?.frequencyCode == e2?.frequencyCode &&
        e1?.notificationAt == e2?.notificationAt &&
        e1?.recurrentDocumentId == e2?.recurrentDocumentId &&
        e1?.transferId == e2?.transferId &&
        e1?.bankAccountsRef == e2?.bankAccountsRef;
  }

  @override
  int hash(GoaldsRecord? e) => const ListEquality().hash([
        e?.userRef,
        e?.startedDate,
        e?.finishedDate,
        e?.updatedDate,
        e?.totalAmount,
        e?.quotes,
        e?.porcent,
        e?.name,
        e?.description,
        e?.status,
        e?.freuency,
        e?.autoContribution,
        e?.isFrozen,
        e?.isComplited,
        e?.currentAmount,
        e?.senderAccount,
        e?.resiverAccount,
        e?.ejecutionDates,
        e?.totalQuotesNumbers,
        e?.frequencyCode,
        e?.notificationAt,
        e?.recurrentDocumentId,
        e?.transferId,
        e?.bankAccountsRef
      ]);

  @override
  bool isValidKey(Object? o) => o is GoaldsRecord;
}
