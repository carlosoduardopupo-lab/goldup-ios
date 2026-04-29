import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BankAccountsRecord extends FirestoreRecord {
  BankAccountsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "itemId" field.
  String? _itemId;
  String get itemId => _itemId ?? '';
  bool hasItemId() => _itemId != null;

  // "plaidAccountId" field.
  String? _plaidAccountId;
  String get plaidAccountId => _plaidAccountId ?? '';
  bool hasPlaidAccountId() => _plaidAccountId != null;

  // "persistentAccountId" field.
  String? _persistentAccountId;
  String get persistentAccountId => _persistentAccountId ?? '';
  bool hasPersistentAccountId() => _persistentAccountId != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "officialName" field.
  String? _officialName;
  String get officialName => _officialName ?? '';
  bool hasOfficialName() => _officialName != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "subtype" field.
  String? _subtype;
  String get subtype => _subtype ?? '';
  bool hasSubtype() => _subtype != null;

  // "mask" field.
  String? _mask;
  String get mask => _mask ?? '';
  bool hasMask() => _mask != null;

  // "availableBalance" field.
  double? _availableBalance;
  double get availableBalance => _availableBalance ?? 0.0;
  bool hasAvailableBalance() => _availableBalance != null;

  // "currentBalance" field.
  double? _currentBalance;
  double get currentBalance => _currentBalance ?? 0.0;
  bool hasCurrentBalance() => _currentBalance != null;

  // "limitBalance" field.
  double? _limitBalance;
  double get limitBalance => _limitBalance ?? 0.0;
  bool hasLimitBalance() => _limitBalance != null;

  // "isoCurrencyCode" field.
  String? _isoCurrencyCode;
  String get isoCurrencyCode => _isoCurrencyCode ?? '';
  bool hasIsoCurrencyCode() => _isoCurrencyCode != null;

  // "unofficialCurrencyCode" field.
  String? _unofficialCurrencyCode;
  String get unofficialCurrencyCode => _unofficialCurrencyCode ?? '';
  bool hasUnofficialCurrencyCode() => _unofficialCurrencyCode != null;

  // "env" field.
  String? _env;
  String get env => _env ?? '';
  bool hasEnv() => _env != null;

  // "source" field.
  String? _source;
  String get source => _source ?? '';
  bool hasSource() => _source != null;

  // "verificationStatus" field.
  String? _verificationStatus;
  String get verificationStatus => _verificationStatus ?? '';
  bool hasVerificationStatus() => _verificationStatus != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "updatedAt" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "bankLogo" field.
  String? _bankLogo;
  String get bankLogo => _bankLogo ?? '';
  bool hasBankLogo() => _bankLogo != null;

  // "isChequingAccount" field.
  bool? _isChequingAccount;
  bool get isChequingAccount => _isChequingAccount ?? false;
  bool hasIsChequingAccount() => _isChequingAccount != null;

  // "institutionId" field.
  String? _institutionId;
  String get institutionId => _institutionId ?? '';
  bool hasInstitutionId() => _institutionId != null;

  // "institutionName" field.
  String? _institutionName;
  String get institutionName => _institutionName ?? '';
  bool hasInstitutionName() => _institutionName != null;

  // "isSavingAccount" field.
  bool? _isSavingAccount;
  bool get isSavingAccount => _isSavingAccount ?? false;
  bool hasIsSavingAccount() => _isSavingAccount != null;

  // "isCreditAccount" field.
  bool? _isCreditAccount;
  bool get isCreditAccount => _isCreditAccount ?? false;
  bool hasIsCreditAccount() => _isCreditAccount != null;

  void _initializeFields() {
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _itemId = snapshotData['itemId'] as String?;
    _plaidAccountId = snapshotData['plaidAccountId'] as String?;
    _persistentAccountId = snapshotData['persistentAccountId'] as String?;
    _name = snapshotData['name'] as String?;
    _officialName = snapshotData['officialName'] as String?;
    _type = snapshotData['type'] as String?;
    _subtype = snapshotData['subtype'] as String?;
    _mask = snapshotData['mask'] as String?;
    _availableBalance = castToType<double>(snapshotData['availableBalance']);
    _currentBalance = castToType<double>(snapshotData['currentBalance']);
    _limitBalance = castToType<double>(snapshotData['limitBalance']);
    _isoCurrencyCode = snapshotData['isoCurrencyCode'] as String?;
    _unofficialCurrencyCode = snapshotData['unofficialCurrencyCode'] as String?;
    _env = snapshotData['env'] as String?;
    _source = snapshotData['source'] as String?;
    _verificationStatus = snapshotData['verificationStatus'] as String?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _updatedAt = snapshotData['updatedAt'] as DateTime?;
    _bankLogo = snapshotData['bankLogo'] as String?;
    _isChequingAccount = snapshotData['isChequingAccount'] as bool?;
    _institutionId = snapshotData['institutionId'] as String?;
    _institutionName = snapshotData['institutionName'] as String?;
    _isSavingAccount = snapshotData['isSavingAccount'] as bool?;
    _isCreditAccount = snapshotData['isCreditAccount'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('bank_accounts');

  static Stream<BankAccountsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => BankAccountsRecord.fromSnapshot(s));

  static Future<BankAccountsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => BankAccountsRecord.fromSnapshot(s));

  static BankAccountsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      BankAccountsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static BankAccountsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      BankAccountsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'BankAccountsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is BankAccountsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createBankAccountsRecordData({
  DocumentReference? userRef,
  String? itemId,
  String? plaidAccountId,
  String? persistentAccountId,
  String? name,
  String? officialName,
  String? type,
  String? subtype,
  String? mask,
  double? availableBalance,
  double? currentBalance,
  double? limitBalance,
  String? isoCurrencyCode,
  String? unofficialCurrencyCode,
  String? env,
  String? source,
  String? verificationStatus,
  DateTime? createdAt,
  DateTime? updatedAt,
  String? bankLogo,
  bool? isChequingAccount,
  String? institutionId,
  String? institutionName,
  bool? isSavingAccount,
  bool? isCreditAccount,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userRef': userRef,
      'itemId': itemId,
      'plaidAccountId': plaidAccountId,
      'persistentAccountId': persistentAccountId,
      'name': name,
      'officialName': officialName,
      'type': type,
      'subtype': subtype,
      'mask': mask,
      'availableBalance': availableBalance,
      'currentBalance': currentBalance,
      'limitBalance': limitBalance,
      'isoCurrencyCode': isoCurrencyCode,
      'unofficialCurrencyCode': unofficialCurrencyCode,
      'env': env,
      'source': source,
      'verificationStatus': verificationStatus,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'bankLogo': bankLogo,
      'isChequingAccount': isChequingAccount,
      'institutionId': institutionId,
      'institutionName': institutionName,
      'isSavingAccount': isSavingAccount,
      'isCreditAccount': isCreditAccount,
    }.withoutNulls,
  );

  return firestoreData;
}

class BankAccountsRecordDocumentEquality
    implements Equality<BankAccountsRecord> {
  const BankAccountsRecordDocumentEquality();

  @override
  bool equals(BankAccountsRecord? e1, BankAccountsRecord? e2) {
    return e1?.userRef == e2?.userRef &&
        e1?.itemId == e2?.itemId &&
        e1?.plaidAccountId == e2?.plaidAccountId &&
        e1?.persistentAccountId == e2?.persistentAccountId &&
        e1?.name == e2?.name &&
        e1?.officialName == e2?.officialName &&
        e1?.type == e2?.type &&
        e1?.subtype == e2?.subtype &&
        e1?.mask == e2?.mask &&
        e1?.availableBalance == e2?.availableBalance &&
        e1?.currentBalance == e2?.currentBalance &&
        e1?.limitBalance == e2?.limitBalance &&
        e1?.isoCurrencyCode == e2?.isoCurrencyCode &&
        e1?.unofficialCurrencyCode == e2?.unofficialCurrencyCode &&
        e1?.env == e2?.env &&
        e1?.source == e2?.source &&
        e1?.verificationStatus == e2?.verificationStatus &&
        e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.bankLogo == e2?.bankLogo &&
        e1?.isChequingAccount == e2?.isChequingAccount &&
        e1?.institutionId == e2?.institutionId &&
        e1?.institutionName == e2?.institutionName &&
        e1?.isSavingAccount == e2?.isSavingAccount &&
        e1?.isCreditAccount == e2?.isCreditAccount;
  }

  @override
  int hash(BankAccountsRecord? e) => const ListEquality().hash([
        e?.userRef,
        e?.itemId,
        e?.plaidAccountId,
        e?.persistentAccountId,
        e?.name,
        e?.officialName,
        e?.type,
        e?.subtype,
        e?.mask,
        e?.availableBalance,
        e?.currentBalance,
        e?.limitBalance,
        e?.isoCurrencyCode,
        e?.unofficialCurrencyCode,
        e?.env,
        e?.source,
        e?.verificationStatus,
        e?.createdAt,
        e?.updatedAt,
        e?.bankLogo,
        e?.isChequingAccount,
        e?.institutionId,
        e?.institutionName,
        e?.isSavingAccount,
        e?.isCreditAccount
      ]);

  @override
  bool isValidKey(Object? o) => o is BankAccountsRecord;
}
