class SubjectListJson {
  String? status;
  int? statusCode;
  List<SubjectListDataJson>? subjectListDataJson;

  SubjectListJson({this.status, this.statusCode, this.subjectListDataJson});

  SubjectListJson.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      subjectListDataJson = <SubjectListDataJson>[];
      json['data'].forEach((v) {
        subjectListDataJson!.add(SubjectListDataJson.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['status_code'] = statusCode;
    if (subjectListDataJson != null) {
      data['data'] = subjectListDataJson!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubjectListDataJson {
  int? id;
  String? name;
  String? classificationCode;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  SubjectListDataJson({
    this.id,
    this.name,
    this.classificationCode,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  SubjectListDataJson.fromJson(Map<String, dynamic> json) {
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