class BorrowedDetailJson {
  String? status;
  int? statusCode;
  List<BorrowedDetailDataJson>? borrowedDetailDataJson;

  BorrowedDetailJson({this.status, this.statusCode, this.borrowedDetailDataJson});

  BorrowedDetailJson.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      borrowedDetailDataJson = <BorrowedDetailDataJson>[];
      json['data'].forEach((v) {
        borrowedDetailDataJson!.add(BorrowedDetailDataJson.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['status_code'] = statusCode;
    if (borrowedDetailDataJson != null) {
      data['data'] = borrowedDetailDataJson!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BorrowedDetailDataJson {
  int? id;
  String? itemListId;
  int? studentId;
  int? employeeId;
  String? fromDate;
  String? untilDate;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? status;
  List<BorrowedBooksDataJson>? books;

  BorrowedDetailDataJson({
    this.id,
    this.itemListId,
    this.studentId,
    this.employeeId,
    this.fromDate,
    this.untilDate,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.books,
  });

  BorrowedDetailDataJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemListId = json['item_list_id'];
    studentId = json['student_id'];
    employeeId = json['employee_id'];
    fromDate = json['from_date'];
    untilDate = json['until_date'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    if (json['books'] != null) {
      books = <BorrowedBooksDataJson>[];
      json['books'].forEach((v) {
        books!.add(BorrowedBooksDataJson.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item_list_id'] = itemListId;
    data['student_id'] = studentId;
    data['employee_id'] = employeeId;
    data['from_date'] = fromDate;
    data['until_date'] = untilDate;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['status'] = status;
    if (books != null) {
      data['books'] = books!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BorrowedBooksDataJson {
  int? id;
  int? bibliographyId;
  int? collectionTypeId;
  int? locationId;
  int? librarySupplierId;
  String? itemCode;
  String? status;
  String? callNumber;
  String? inventoryCode;
  String? shelfLocation;
  String? orderNumber;
  String? orderDate;
  String? receivedDate;
  bool? source;
  String? invoiceDate;
  String? currency;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  bool? isAvailable;
  String? rfidTag;
  String? url;
  Bibliography? bibliography;

  BorrowedBooksDataJson({
    this.id,
    this.bibliographyId,
    this.collectionTypeId,
    this.locationId,
    this.librarySupplierId,
    this.itemCode,
    this.status,
    this.callNumber,
    this.inventoryCode,
    this.shelfLocation,
    this.orderNumber,
    this.orderDate,
    this.receivedDate,
    this.source,
    this.invoiceDate,
    this.currency,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.isAvailable,
    this.rfidTag,
    this.url,
    this.bibliography,
  });

  BorrowedBooksDataJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bibliographyId = json['bibliography_id'];
    collectionTypeId = json['collection_type_id'];
    locationId = json['location_id'];
    librarySupplierId = json['library_supplier_id'];
    itemCode = json['item_code'];
    status = json['status'];
    callNumber = json['call_number'];
    inventoryCode = json['inventory_code'];
    shelfLocation = json['shelf_location'];
    orderNumber = json['order_number'];
    orderDate = json['order_date'];
    receivedDate = json['received_date'];
    source = json['source'];
    invoiceDate = json['invoice_date'];
    currency = json['currency'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isAvailable = json['is_available'];
    rfidTag = json['rfid_tag'];
    url = json['url'];
    bibliography = json['bibliography'] != null
        ? Bibliography.fromJson(json['bibliography'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bibliography_id'] = bibliographyId;
    data['collection_type_id'] = collectionTypeId;
    data['location_id'] = locationId;
    data['library_supplier_id'] = librarySupplierId;
    data['item_code'] = itemCode;
    data['status'] = status;
    data['call_number'] = callNumber;
    data['inventory_code'] = inventoryCode;
    data['shelf_location'] = shelfLocation;
    data['order_number'] = orderNumber;
    data['order_date'] = orderDate;
    data['received_date'] = receivedDate;
    data['source'] = source;
    data['invoice_date'] = invoiceDate;
    data['currency'] = currency;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_available'] = isAvailable;
    data['rfid_tag'] = rfidTag;
    data['url'] = url;
    if (bibliography != null) {
      data['bibliography'] = bibliography!.toJson();
    }
    return data;
  }
}

class Bibliography {
  int? id;
  String? title;
  String? authorNames;
  List<Authors>? authors;
  String? authorId;
  String? isbnOrIssn;
  CollectionType? collectionType;
  Publisher? publisher;
  String? publishingYear;
  Publisher? publishingPlace;
  String? subjectNames;
  List<Subjects>? subjects;
  String? subjectId;
  Publisher? language;
  String? callNumber;
  String? notes;

  Bibliography({
    this.id,
    this.title,
    this.authorNames,
    this.authors,
    this.authorId,
    this.isbnOrIssn,
    this.collectionType,
    this.publisher,
    this.publishingYear,
    this.publishingPlace,
    this.subjectNames,
    this.subjects,
    this.subjectId,
    this.language,
    this.callNumber,
    this.notes,
  });

  Bibliography.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    authorNames = json['author_names'];
    if (json['authors'] != null) {
      authors = <Authors>[];
      json['authors'].forEach((v) {
        authors!.add(Authors.fromJson(v));
      });
    }
    authorId = json['author_id'];
    isbnOrIssn = json['isbn_or_issn'];
    collectionType = json['collection_type'] != null
        ? CollectionType.fromJson(json['collection_type'])
        : null;
    publisher = json['publisher'] != null
        ? Publisher.fromJson(json['publisher'])
        : null;
    publishingYear = json['publishing_year'];
    publishingPlace = json['publishing_place'] != null
        ? Publisher.fromJson(json['publishing_place'])
        : null;
    subjectNames = json['subject_names'];
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(Subjects.fromJson(v));
      });
    }
    subjectId = json['subject_id'];
    language = json['language'] != null
        ? Publisher.fromJson(json['language'])
        : null;
    callNumber = json['call_number'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['author_names'] = authorNames;
    if (authors != null) {
      data['authors'] = authors!.map((v) => v.toJson()).toList();
    }
    data['author_id'] = authorId;
    data['isbn_or_issn'] = isbnOrIssn;
    if (collectionType != null) {
      data['collection_type'] = collectionType!.toJson();
    }
    if (publisher != null) {
      data['publisher'] = publisher!.toJson();
    }
    data['publishing_year'] = publishingYear;
    if (publishingPlace != null) {
      data['publishing_place'] = publishingPlace!.toJson();
    }
    data['subject_names'] = subjectNames;
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    data['subject_id'] = subjectId;
    if (language != null) {
      data['language'] = language!.toJson();
    }
    data['call_number'] = callNumber;
    data['notes'] = notes;
    return data;
  }
}

class Authors {
  int? id;
  String? name;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Authors({
    this.id,
    this.name,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  Authors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class CollectionType {
  int? id;
  String? name;
  String? description;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  CollectionType({
    this.id,
    this.name,
    this.description,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  CollectionType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Publisher {
  int? id;
  String? name;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Publisher({
    this.id,
    this.name,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  Publisher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Subjects {
  int? id;
  String? name;
  String? classificationCode;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Subjects({
    this.id,
    this.name,
    this.classificationCode,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  Subjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    classificationCode = json['classification_code'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['classification_code'] = classificationCode;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}