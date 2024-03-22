class LanguageListJson {
  String? status;
  int? statusCode;
  List<LanguageListDataJson>? languageListDataJson;

  LanguageListJson({this.status, this.statusCode, this.languageListDataJson});

  LanguageListJson.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      languageListDataJson = <LanguageListDataJson>[];
      json['data'].forEach((v) {
        languageListDataJson!.add(LanguageListDataJson.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['status_code'] = statusCode;
    if (languageListDataJson != null) {
      data['data'] = languageListDataJson!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LanguageListDataJson {
  int? id;
  String? name;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  LanguageListDataJson({this.id, this.name, this.deletedAt, this.createdAt, this.updatedAt});

  LanguageListDataJson.fromJson(Map<String, dynamic> json) {
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