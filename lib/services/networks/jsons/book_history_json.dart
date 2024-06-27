import 'package:jny_self_services_library/services/networks/jsons/book_json.dart';

class BookHistoryJson {
  String? status;
  int? statusCode;
  BookHistoryDataJson? bookHistoryDataJson;

  BookHistoryJson({this.status, this.statusCode, this.bookHistoryDataJson});

  BookHistoryJson.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    bookHistoryDataJson = json['data'] != null ? BookHistoryDataJson.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['status_code'] = statusCode;
    if (bookHistoryDataJson != null) {
      data['data'] = bookHistoryDataJson!.toJson();
    }
    return data;
  }
}

class BookHistoryDataJson {
  BookDataJson? book;
  List<LoanHistories>? loanHistories;

  BookHistoryDataJson({this.book, this.loanHistories});

  BookHistoryDataJson.fromJson(Map<String, dynamic> json) {
    book = json['book'] != null ? BookDataJson.fromJson(json['book']) : null;
    if (json['loan_histories'] != null) {
      loanHistories = <LoanHistories>[];
      json['loan_histories'].forEach((v) {
        loanHistories!.add(LoanHistories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (book != null) {
      data['book'] = book!.toJson();
    }
    if (loanHistories != null) {
      data['loan_histories'] =
          loanHistories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LoanHistories {
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
  Student? student;
  Employee? employee;

  LoanHistories({
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
    this.student,
    this.employee,
  });

  LoanHistories.fromJson(Map<String, dynamic> json) {
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
    student =
    json['student'] != null ? Student.fromJson(json['student']) : null;
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
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
    if (student != null) {
      data['student'] = student!.toJson();
    }
    if (employee != null) {
      data['employee'] = employee!.toJson();
    }
    return data;
  }
}

class Student {
  int? id;
  String? nis;
  String? name;
  String? className;

  Student({this.id, this.nis, this.name, this.className});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nis = json['nis'];
    name = json['name'];
    className = json['class_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nis'] = nis;
    data['name'] = name;
    data['class_name'] = className;
    return data;
  }
}

class Employee {
  int? id;
  String? nik;
  String? name;

  Employee({this.id, this.nik, this.name});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nik = json['nik'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nik'] = nik;
    data['name'] = name;
    return data;
  }
}