class AllBookJson {
  String? status;
  int? statusCode;
  List<BookDataJson>? bookDataJson;

  AllBookJson({this.status, this.statusCode, this.bookDataJson});

  AllBookJson.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      bookDataJson = <BookDataJson>[];
      json['data'].forEach((v) {
        bookDataJson!.add(BookDataJson.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['status_code'] = statusCode;
    if (bookDataJson != null) {
      data['data'] = bookDataJson!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SpecificBookJson {
  String? status;
  int? statusCode;
  BookDataJson? bookDataJson;

  SpecificBookJson({this.status, this.statusCode, this.bookDataJson});

  SpecificBookJson.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    bookDataJson = json['data'] != null ? BookDataJson.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['status_code'] = statusCode;
    if(bookDataJson != null) {
      data['data'] = bookDataJson!.toJson();
    }
    return data;
  }
}

class BookDataJson {
  int? id;
  String? title;
  String? isbnOrIssn;
  String? publishingYear;
  String? subjectId;
  int? languageId;
  String? subjectName;
  String? languageName;
  bool? isAvailable;
  String? rfidTag;
  String? code;
  String? location;
  String? type;
  String? authorNames;
  String? publisher;
  String? mediaPath;

  BookDataJson({
    this.id,
    this.title,
    this.isbnOrIssn,
    this.publishingYear,
    this.subjectId,
    this.languageId,
    this.subjectName,
    this.languageName,
    this.isAvailable,
    this.rfidTag,
    this.code,
    this.location,
    this.type,
    this.authorNames,
    this.publisher,
    this.mediaPath
  });

  BookDataJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isbnOrIssn = json['isbn_or_issn'];
    publishingYear = json['publishing_year'];
    subjectId = json['subject_id'];
    languageId = json['language_id'];
    subjectName = json['subject_name'];
    languageName = json['language_name'];
    isAvailable = json['is_available'];
    rfidTag = json['rfid_tag'];
    code = json['code'];
    location = json['location'];
    type = json['type'];
    authorNames = json['author_names'];
    publisher = json['publisher'];
    mediaPath = json['media_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['isbn_or_issn'] = isbnOrIssn;
    data['publishing_year'] = publishingYear;
    data['subject_id'] = subjectId;
    data['language_id'] = languageId;
    data['subject_name'] = subjectName;
    data['language_name'] = languageName;
    data['is_available'] = isAvailable;
    data['rfid_tag'] = rfidTag;
    data['code'] = code;
    data['location'] = location;
    data['type'] = type;
    data['author_names'] = authorNames;
    data['publisher'] = publisher;
    data['media_path'] = mediaPath;
    return data;
  }
}