import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NewsRecord extends FirestoreRecord {
  NewsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "content" field.
  String? _content;
  String get content => _content ?? '';
  bool hasContent() => _content != null;

  // "sourceUrl" field.
  String? _sourceUrl;
  String get sourceUrl => _sourceUrl ?? '';
  bool hasSourceUrl() => _sourceUrl != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  // "country" field.
  String? _country;
  String get country => _country ?? '';
  bool hasCountry() => _country != null;

  // "language" field.
  String? _language;
  String get language => _language ?? '';
  bool hasLanguage() => _language != null;

  // "isTrending" field.
  bool? _isTrending;
  bool get isTrending => _isTrending ?? false;
  bool hasIsTrending() => _isTrending != null;

  // "views" field.
  int? _views;
  int get views => _views ?? 0;
  bool hasViews() => _views != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "isActive" field.
  bool? _isActive;
  bool get isActive => _isActive ?? false;
  bool hasIsActive() => _isActive != null;

  // "readTime" field.
  int? _readTime;
  int get readTime => _readTime ?? 0;
  bool hasReadTime() => _readTime != null;

  // "isFeatured" field.
  bool? _isFeatured;
  bool get isFeatured => _isFeatured ?? false;
  bool hasIsFeatured() => _isFeatured != null;

  // "tags" field.
  List<String>? _tags;
  List<String> get tags => _tags ?? const [];
  bool hasTags() => _tags != null;

  // "imageUrl" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  bool hasImageUrl() => _imageUrl != null;

  // "userViewed" field.
  List<DocumentReference>? _userViewed;
  List<DocumentReference> get userViewed => _userViewed ?? const [];
  bool hasUserViewed() => _userViewed != null;

  // "sourceName" field.
  String? _sourceName;
  String get sourceName => _sourceName ?? '';
  bool hasSourceName() => _sourceName != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _description = snapshotData['description'] as String?;
    _content = snapshotData['content'] as String?;
    _sourceUrl = snapshotData['sourceUrl'] as String?;
    _category = snapshotData['category'] as String?;
    _country = snapshotData['country'] as String?;
    _language = snapshotData['language'] as String?;
    _isTrending = snapshotData['isTrending'] as bool?;
    _views = castToType<int>(snapshotData['views']);
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _isActive = snapshotData['isActive'] as bool?;
    _readTime = castToType<int>(snapshotData['readTime']);
    _isFeatured = snapshotData['isFeatured'] as bool?;
    _tags = getDataList(snapshotData['tags']);
    _imageUrl = snapshotData['imageUrl'] as String?;
    _userViewed = getDataList(snapshotData['userViewed']);
    _sourceName = snapshotData['sourceName'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('news');

  static Stream<NewsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => NewsRecord.fromSnapshot(s));

  static Future<NewsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => NewsRecord.fromSnapshot(s));

  static NewsRecord fromSnapshot(DocumentSnapshot snapshot) => NewsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NewsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NewsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NewsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NewsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createNewsRecordData({
  String? title,
  String? description,
  String? content,
  String? sourceUrl,
  String? category,
  String? country,
  String? language,
  bool? isTrending,
  int? views,
  DateTime? createdAt,
  bool? isActive,
  int? readTime,
  bool? isFeatured,
  String? imageUrl,
  String? sourceName,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'description': description,
      'content': content,
      'sourceUrl': sourceUrl,
      'category': category,
      'country': country,
      'language': language,
      'isTrending': isTrending,
      'views': views,
      'createdAt': createdAt,
      'isActive': isActive,
      'readTime': readTime,
      'isFeatured': isFeatured,
      'imageUrl': imageUrl,
      'sourceName': sourceName,
    }.withoutNulls,
  );

  return firestoreData;
}

class NewsRecordDocumentEquality implements Equality<NewsRecord> {
  const NewsRecordDocumentEquality();

  @override
  bool equals(NewsRecord? e1, NewsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.title == e2?.title &&
        e1?.description == e2?.description &&
        e1?.content == e2?.content &&
        e1?.sourceUrl == e2?.sourceUrl &&
        e1?.category == e2?.category &&
        e1?.country == e2?.country &&
        e1?.language == e2?.language &&
        e1?.isTrending == e2?.isTrending &&
        e1?.views == e2?.views &&
        e1?.createdAt == e2?.createdAt &&
        e1?.isActive == e2?.isActive &&
        e1?.readTime == e2?.readTime &&
        e1?.isFeatured == e2?.isFeatured &&
        listEquality.equals(e1?.tags, e2?.tags) &&
        e1?.imageUrl == e2?.imageUrl &&
        listEquality.equals(e1?.userViewed, e2?.userViewed) &&
        e1?.sourceName == e2?.sourceName;
  }

  @override
  int hash(NewsRecord? e) => const ListEquality().hash([
        e?.title,
        e?.description,
        e?.content,
        e?.sourceUrl,
        e?.category,
        e?.country,
        e?.language,
        e?.isTrending,
        e?.views,
        e?.createdAt,
        e?.isActive,
        e?.readTime,
        e?.isFeatured,
        e?.tags,
        e?.imageUrl,
        e?.userViewed,
        e?.sourceName
      ]);

  @override
  bool isValidKey(Object? o) => o is NewsRecord;
}
