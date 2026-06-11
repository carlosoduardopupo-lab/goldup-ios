import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserRecord extends FirestoreRecord {
  UserRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "isPremium" field.
  bool? _isPremium;
  bool get isPremium => _isPremium ?? false;
  bool hasIsPremium() => _isPremium != null;

  // "notificationAt" field.
  int? _notificationAt;
  int get notificationAt => _notificationAt ?? 0;
  bool hasNotificationAt() => _notificationAt != null;

  // "notificationAjustValue" field.
  int? _notificationAjustValue;
  int get notificationAjustValue => _notificationAjustValue ?? 0;
  bool hasNotificationAjustValue() => _notificationAjustValue != null;

  // "isBasic" field.
  bool? _isBasic;
  bool get isBasic => _isBasic ?? false;
  bool hasIsBasic() => _isBasic != null;

  // "IsBasicWhitAnunces" field.
  bool? _isBasicWhitAnunces;
  bool get isBasicWhitAnunces => _isBasicWhitAnunces ?? false;
  bool hasIsBasicWhitAnunces() => _isBasicWhitAnunces != null;

  // "isPilotoTest" field.
  bool? _isPilotoTest;
  bool get isPilotoTest => _isPilotoTest ?? false;
  bool hasIsPilotoTest() => _isPilotoTest != null;

  // "country" field.
  String? _country;
  String get country => _country ?? '';
  bool hasCountry() => _country != null;

  // "state" field.
  String? _state;
  String get state => _state ?? '';
  bool hasState() => _state != null;

  // "city" field.
  String? _city;
  String get city => _city ?? '';
  bool hasCity() => _city != null;

  // "zipCode" field.
  String? _zipCode;
  String get zipCode => _zipCode ?? '';
  bool hasZipCode() => _zipCode != null;

  // "locationUpdatedAt" field.
  DateTime? _locationUpdatedAt;
  DateTime? get locationUpdatedAt => _locationUpdatedAt;
  bool hasLocationUpdatedAt() => _locationUpdatedAt != null;

  // "language" field.
  String? _language;
  String get language => _language ?? '';
  bool hasLanguage() => _language != null;

  // "isDocumentCreated" field.
  bool? _isDocumentCreated;
  bool get isDocumentCreated => _isDocumentCreated ?? false;
  bool hasIsDocumentCreated() => _isDocumentCreated != null;

  // "isExpensesCreated" field.
  bool? _isExpensesCreated;
  bool get isExpensesCreated => _isExpensesCreated ?? false;
  bool hasIsExpensesCreated() => _isExpensesCreated != null;

  // "isGoalCreated" field.
  bool? _isGoalCreated;
  bool get isGoalCreated => _isGoalCreated ?? false;
  bool hasIsGoalCreated() => _isGoalCreated != null;

  // "isAccountsVinculated" field.
  bool? _isAccountsVinculated;
  bool get isAccountsVinculated => _isAccountsVinculated ?? false;
  bool hasIsAccountsVinculated() => _isAccountsVinculated != null;

  // "isIncomeCreated" field.
  bool? _isIncomeCreated;
  bool get isIncomeCreated => _isIncomeCreated ?? false;
  bool hasIsIncomeCreated() => _isIncomeCreated != null;

  // "isCreditScoreSet" field.
  bool? _isCreditScoreSet;
  bool get isCreditScoreSet => _isCreditScoreSet ?? false;
  bool hasIsCreditScoreSet() => _isCreditScoreSet != null;

  // "timeZone" field.
  String? _timeZone;
  String get timeZone => _timeZone ?? '';
  bool hasTimeZone() => _timeZone != null;

  // "isTransactionsVerificated" field.
  bool? _isTransactionsVerificated;
  bool get isTransactionsVerificated => _isTransactionsVerificated ?? false;
  bool hasIsTransactionsVerificated() => _isTransactionsVerificated != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _isPremium = snapshotData['isPremium'] as bool?;
    _notificationAt = castToType<int>(snapshotData['notificationAt']);
    _notificationAjustValue =
        castToType<int>(snapshotData['notificationAjustValue']);
    _isBasic = snapshotData['isBasic'] as bool?;
    _isBasicWhitAnunces = snapshotData['IsBasicWhitAnunces'] as bool?;
    _isPilotoTest = snapshotData['isPilotoTest'] as bool?;
    _country = snapshotData['country'] as String?;
    _state = snapshotData['state'] as String?;
    _city = snapshotData['city'] as String?;
    _zipCode = snapshotData['zipCode'] as String?;
    _locationUpdatedAt = snapshotData['locationUpdatedAt'] as DateTime?;
    _language = snapshotData['language'] as String?;
    _isDocumentCreated = snapshotData['isDocumentCreated'] as bool?;
    _isExpensesCreated = snapshotData['isExpensesCreated'] as bool?;
    _isGoalCreated = snapshotData['isGoalCreated'] as bool?;
    _isAccountsVinculated = snapshotData['isAccountsVinculated'] as bool?;
    _isIncomeCreated = snapshotData['isIncomeCreated'] as bool?;
    _isCreditScoreSet = snapshotData['isCreditScoreSet'] as bool?;
    _timeZone = snapshotData['timeZone'] as String?;
    _isTransactionsVerificated =
        snapshotData['isTransactionsVerificated'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('user');

  static Stream<UserRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserRecord.fromSnapshot(s));

  static Future<UserRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserRecord.fromSnapshot(s));

  static UserRecord fromSnapshot(DocumentSnapshot snapshot) => UserRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  bool? isPremium,
  int? notificationAt,
  int? notificationAjustValue,
  bool? isBasic,
  bool? isBasicWhitAnunces,
  bool? isPilotoTest,
  String? country,
  String? state,
  String? city,
  String? zipCode,
  DateTime? locationUpdatedAt,
  String? language,
  bool? isDocumentCreated,
  bool? isExpensesCreated,
  bool? isGoalCreated,
  bool? isAccountsVinculated,
  bool? isIncomeCreated,
  bool? isCreditScoreSet,
  String? timeZone,
  bool? isTransactionsVerificated,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'isPremium': isPremium,
      'notificationAt': notificationAt,
      'notificationAjustValue': notificationAjustValue,
      'isBasic': isBasic,
      'IsBasicWhitAnunces': isBasicWhitAnunces,
      'isPilotoTest': isPilotoTest,
      'country': country,
      'state': state,
      'city': city,
      'zipCode': zipCode,
      'locationUpdatedAt': locationUpdatedAt,
      'language': language,
      'isDocumentCreated': isDocumentCreated,
      'isExpensesCreated': isExpensesCreated,
      'isGoalCreated': isGoalCreated,
      'isAccountsVinculated': isAccountsVinculated,
      'isIncomeCreated': isIncomeCreated,
      'isCreditScoreSet': isCreditScoreSet,
      'timeZone': timeZone,
      'isTransactionsVerificated': isTransactionsVerificated,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserRecordDocumentEquality implements Equality<UserRecord> {
  const UserRecordDocumentEquality();

  @override
  bool equals(UserRecord? e1, UserRecord? e2) {
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.isPremium == e2?.isPremium &&
        e1?.notificationAt == e2?.notificationAt &&
        e1?.notificationAjustValue == e2?.notificationAjustValue &&
        e1?.isBasic == e2?.isBasic &&
        e1?.isBasicWhitAnunces == e2?.isBasicWhitAnunces &&
        e1?.isPilotoTest == e2?.isPilotoTest &&
        e1?.country == e2?.country &&
        e1?.state == e2?.state &&
        e1?.city == e2?.city &&
        e1?.zipCode == e2?.zipCode &&
        e1?.locationUpdatedAt == e2?.locationUpdatedAt &&
        e1?.language == e2?.language &&
        e1?.isDocumentCreated == e2?.isDocumentCreated &&
        e1?.isExpensesCreated == e2?.isExpensesCreated &&
        e1?.isGoalCreated == e2?.isGoalCreated &&
        e1?.isAccountsVinculated == e2?.isAccountsVinculated &&
        e1?.isIncomeCreated == e2?.isIncomeCreated &&
        e1?.isCreditScoreSet == e2?.isCreditScoreSet &&
        e1?.timeZone == e2?.timeZone &&
        e1?.isTransactionsVerificated == e2?.isTransactionsVerificated;
  }

  @override
  int hash(UserRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.isPremium,
        e?.notificationAt,
        e?.notificationAjustValue,
        e?.isBasic,
        e?.isBasicWhitAnunces,
        e?.isPilotoTest,
        e?.country,
        e?.state,
        e?.city,
        e?.zipCode,
        e?.locationUpdatedAt,
        e?.language,
        e?.isDocumentCreated,
        e?.isExpensesCreated,
        e?.isGoalCreated,
        e?.isAccountsVinculated,
        e?.isIncomeCreated,
        e?.isCreditScoreSet,
        e?.timeZone,
        e?.isTransactionsVerificated
      ]);

  @override
  bool isValidKey(Object? o) => o is UserRecord;
}
