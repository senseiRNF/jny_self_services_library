class LibraryMemberJson {
  String? status;
  int? statusCode;
  LibraryMemberData? libraryMemberData;

  LibraryMemberJson({this.status, this.statusCode, this.libraryMemberData});

  LibraryMemberJson.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    libraryMemberData = json['data'] != null ? LibraryMemberData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['status_code'] = statusCode;
    if (libraryMemberData != null) {
      data['data'] = libraryMemberData!.toJson();
    }
    return data;
  }
}

class LibraryMemberData {
  int? id;
  String? nis;
  String? nik;
  String? name;
  String? email;
  String? className;
  String? profilePic;
  int? mediaId;
  String? photoUrl;

  LibraryMemberData({
    this.id,
    this.nis,
    this.nik,
    this.name,
    this.email,
    this.className,
    this.profilePic,
    this.mediaId,
    this.photoUrl,
  });

  LibraryMemberData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nis = json['nis'];
    nik = json['nik'];
    name = json['name'];
    email = json['email'];
    className = json['class_name'];
    profilePic = json['profile_pic'];
    mediaId = json['media_id'];
    photoUrl = json['photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nis'] = nis;
    data['nik'] = nik;
    data['name'] = name;
    data['email'] = email;
    data['class_name'] = className;
    data['profile_pic'] = profilePic;
    data['media_id'] = mediaId;
    data['photo_url'] = photoUrl;
    return data;
  }
}