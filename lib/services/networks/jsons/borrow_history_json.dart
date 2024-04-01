class BorrowHistoryJson {
  String? status;
  int? statusCode;
  List<BorrowHistoryDataJson>? borrowHistoryDataJson;

  BorrowHistoryJson({this.status, this.statusCode, this.borrowHistoryDataJson});

  BorrowHistoryJson.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      borrowHistoryDataJson = <BorrowHistoryDataJson>[];
      json['data'].forEach((v) {
        borrowHistoryDataJson!.add(BorrowHistoryDataJson.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['status_code'] = statusCode;
    if (borrowHistoryDataJson != null) {
      data['data'] = borrowHistoryDataJson!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BorrowHistoryDataJson {
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
  List<Items>? items;

  BorrowHistoryDataJson({
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
    this.items
  });

  BorrowHistoryDataJson.fromJson(Map<String, dynamic> json) {
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
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
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
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? url;
  String? title;

  Items({this.url, this.title});

  Items.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['title'] = title;
    return data;
  }
}