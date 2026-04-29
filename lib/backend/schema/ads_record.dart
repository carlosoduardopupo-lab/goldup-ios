import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AdsRecord extends FirestoreRecord {
  AdsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "clickUrl" field.
  String? _clickUrl;
  String get clickUrl => _clickUrl ?? '';
  bool hasClickUrl() => _clickUrl != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "isActive" field.
  bool? _isActive;
  bool get isActive => _isActive ?? false;
  bool hasIsActive() => _isActive != null;

  // "priority" field.
  int? _priority;
  int get priority => _priority ?? 0;
  bool hasPriority() => _priority != null;

  // "country" field.
  String? _country;
  String get country => _country ?? '';
  bool hasCountry() => _country != null;

  // "language" field.
  String? _language;
  String get language => _language ?? '';
  bool hasLanguage() => _language != null;

  // "startDate" field.
  DateTime? _startDate;
  DateTime? get startDate => _startDate;
  bool hasStartDate() => _startDate != null;

  // "endDate" field.
  DateTime? _endDate;
  DateTime? get endDate => _endDate;
  bool hasEndDate() => _endDate != null;

  // "maxImpressions" field.
  int? _maxImpressions;
  int get maxImpressions => _maxImpressions ?? 0;
  bool hasMaxImpressions() => _maxImpressions != null;

  // "currentImpressions" field.
  int? _currentImpressions;
  int get currentImpressions => _currentImpressions ?? 0;
  bool hasCurrentImpressions() => _currentImpressions != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "imageUrl" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  bool hasImageUrl() => _imageUrl != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _clickUrl = snapshotData['clickUrl'] as String?;
    _type = snapshotData['type'] as String?;
    _isActive = snapshotData['isActive'] as bool?;
    _priority = castToType<int>(snapshotData['priority']);
    _country = snapshotData['country'] as String?;
    _language = snapshotData['language'] as String?;
    _startDate = snapshotData['startDate'] as DateTime?;
    _endDate = snapshotData['endDate'] as DateTime?;
    _maxImpressions = castToType<int>(snapshotData['maxImpressions']);
    _currentImpressions = castToType<int>(snapshotData['currentImpressions']);
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _imageUrl = snapshotData['imageUrl'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('ads');

  static Stream<AdsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AdsRecord.fromSnapshot(s));

  static Future<AdsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AdsRecord.fromSnapshot(s));

  static AdsRecord fromSnapshot(DocumentSnapshot snapshot) => AdsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AdsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AdsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AdsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AdsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAdsRecordData({
  String? title,
  String? clickUrl,
  String? type,
  bool? isActive,
  int? priority,
  String? country,
  String? language,
  DateTime? startDate,
  DateTime? endDate,
  int? maxImpressions,
  int? currentImpressions,
  DateTime? createdAt,
  String? imageUrl,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'clickUrl': clickUrl,
      'type': type,
      'isActive': isActive,
      'priority': priority,
      'country': country,
      'language': language,
      'startDate': startDate,
      'endDate': endDate,
      'maxImpressions': maxImpressions,
      'currentImpressions': currentImpressions,
      'createdAt': createdAt,
      'imageUrl': imageUrl,
    }.withoutNulls,
  );

  return firestoreData;
}

class AdsRecordDocumentEquality implements Equality<AdsRecord> {
  const AdsRecordDocumentEquality();

  @override
  bool equals(AdsRecord? e1, AdsRecord? e2) {
    return e1?.title == e2?.title &&
        e1?.clickUrl == e2?.clickUrl &&
        e1?.type == e2?.type &&
        e1?.isActive == e2?.isActive &&
        e1?.priority == e2?.priority &&
        e1?.country == e2?.country &&
        e1?.language == e2?.language &&
        e1?.startDate == e2?.startDate &&
        e1?.endDate == e2?.endDate &&
        e1?.maxImpressions == e2?.maxImpressions &&
        e1?.currentImpressions == e2?.currentImpressions &&
        e1?.createdAt == e2?.createdAt &&
        e1?.imageUrl == e2?.imageUrl;
  }

  @override
  int hash(AdsRecord? e) => const ListEquality().hash([
        e?.title,
        e?.clickUrl,
        e?.type,
        e?.isActive,
        e?.priority,
        e?.country,
        e?.language,
        e?.startDate,
        e?.endDate,
        e?.maxImpressions,
        e?.currentImpressions,
        e?.createdAt,
        e?.imageUrl
      ]);

  @override
  bool isValidKey(Object? o) => o is AdsRecord;
}
