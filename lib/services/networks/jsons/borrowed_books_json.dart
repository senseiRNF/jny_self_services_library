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
    if (bibliography != null) {
      data['bibliography'] = bibliography!.toJson();
    }
    return data;
  }
}

class Bibliography {
  int? id;
  String? title;
  String? authorId;
  int? collectionTypeId;
  int? locationId;
  int? frequencyId;
  int? publisherId;
  String? publishingYear;
  int? publishingPlaceId;
  String? subjectId;
  int? languageId;
  String? statement;
  String? edition;
  String? detailInfo;
  String? isbnOrIssn;
  String? collation;
  String? seriesTitle;
  String? callNumber;
  String? notes;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? color;
  String? color2;

  Bibliography({
    this.id,
    this.title,
    this.authorId,
    this.collectionTypeId,
    this.locationId,
    this.frequencyId,
    this.publisherId,
    this.publishingYear,
    this.publishingPlaceId,
    this.subjectId,
    this.languageId,
    this.statement,
    this.edition,
    this.detailInfo,
    this.isbnOrIssn,
    this.collation,
    this.seriesTitle,
    this.callNumber,
    this.notes,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.color,
    this.color2,
  });

  Bibliography.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    authorId = json['author_id'];
    collectionTypeId = json['collection_type_id'];
    locationId = json['location_id'];
    frequencyId = json['frequency_id'];
    publisherId = json['publisher_id'];
    publishingYear = json['publishing_year'];
    publishingPlaceId = json['publishing_place_id'];
    subjectId = json['subject_id'];
    languageId = json['language_id'];
    statement = json['statement'];
    edition = json['edition'];
    detailInfo = json['detail_info'];
    isbnOrIssn = json['isbn_or_issn'];
    collation = json['collation'];
    seriesTitle = json['series_title'];
    callNumber = json['call_number'];
    notes = json['notes'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    color = json['color'];
    color2 = json['color2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['author_id'] = authorId;
    data['collection_type_id'] = collectionTypeId;
    data['location_id'] = locationId;
    data['frequency_id'] = frequencyId;
    data['publisher_id'] = publisherId;
    data['publishing_year'] = publishingYear;
    data['publishing_place_id'] = publishingPlaceId;
    data['subject_id'] = subjectId;
    data['language_id'] = languageId;
    data['statement'] = statement;
    data['edition'] = edition;
    data['detail_info'] = detailInfo;
    data['isbn_or_issn'] = isbnOrIssn;
    data['collation'] = collation;
    data['series_title'] = seriesTitle;
    data['call_number'] = callNumber;
    data['notes'] = notes;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['color'] = color;
    data['color2'] = color2;
    return data;
  }
}