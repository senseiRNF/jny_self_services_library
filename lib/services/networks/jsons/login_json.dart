class LoginJson {
  String? status;
  int? statusCode;
  LoginDataJson? loginData;

  LoginJson({this.status, this.statusCode, this.loginData});

  LoginJson.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    loginData = json['data'] != null ? LoginDataJson.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['status_code'] = statusCode;
    if (loginData != null) {
      data['data'] = loginData!.toJson();
    }
    return data;
  }
}

class LoginDataJson {
  int? id;
  String? username;
  String? name;
  String? email;
  bool? isActive;
  String? lastLogin;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? companyId;
  bool? changePassword;
  LoginEmployeeDataJson? loginEmployeeData;
  String? accessToken;
  String? tokenType;
  String? expiresAt;

  LoginDataJson({
    this.id,
    this.username,
    this.name,
    this.email,
    this.isActive,
    this.lastLogin,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.companyId,
    this.changePassword,
    this.loginEmployeeData,
    this.accessToken,
    this.tokenType,
    this.expiresAt,
  });

  LoginDataJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    email = json['email'];
    isActive = json['is_active'];
    lastLogin = json['last_login'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    companyId = json['company_id'];
    changePassword = json['change_password'];
    loginEmployeeData = json['employee'] != null
        ? LoginEmployeeDataJson.fromJson(json['employee'])
        : null;
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresAt = json['expires_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['name'] = name;
    data['email'] = email;
    data['is_active'] = isActive;
    data['last_login'] = lastLogin;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['company_id'] = companyId;
    data['change_password'] = changePassword;
    if (loginEmployeeData != null) {
      data['employee'] = loginEmployeeData!.toJson();
    }
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['expires_at'] = expiresAt;
    return data;
  }
}

class LoginEmployeeDataJson {
  int? id;
  int? userId;
  int? companyId;
  String? nik;
  String? name;
  String? email;
  String? gender;
  String? placeOfBirth;
  String? dob;
  int? religionId;
  String? isLocalOrExpat;
  String? ktp;
  String? passportNo;
  String? passportExpiredDate;
  int? jobLevelId;
  int? positionId;
  String? hiredDate;
  String? isTeacherOfStaff;
  String? isEmploymentStatus;
  String? phoneNumber;
  String? mobileNumber;
  String? addressKtp;
  String? schoolEmail;
  String? maritalStatus;
  bool? active;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? divisionId;
  int? departmentId;
  int? countryId;
  int? provinceId;
  int? regencyId;
  int? districtId;
  bool? resign;
  int? coordinatorId;
  String? genderTitle;
  String? deviceToken;
  String? qr;

  LoginEmployeeDataJson({
    this.id,
    this.userId,
    this.companyId,
    this.nik,
    this.name,
    this.email,
    this.gender,
    this.placeOfBirth,
    this.dob,
    this.religionId,
    this.isLocalOrExpat,
    this.ktp,
    this.passportNo,
    this.passportExpiredDate,
    this.jobLevelId,
    this.positionId,
    this.hiredDate,
    this.isTeacherOfStaff,
    this.isEmploymentStatus,
    this.phoneNumber,
    this.mobileNumber,
    this.addressKtp,
    this.schoolEmail,
    this.maritalStatus,
    this.active,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.divisionId,
    this.departmentId,
    this.countryId,
    this.provinceId,
    this.regencyId,
    this.districtId,
    this.resign,
    this.coordinatorId,
    this.genderTitle,
    this.deviceToken,
    this.qr,
  });

  LoginEmployeeDataJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    companyId = json['company_id'];
    nik = json['nik'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    placeOfBirth = json['place_of_birth'];
    dob = json['dob'];
    religionId = json['religion_id'];
    isLocalOrExpat = json['is_local_or_expat'];
    ktp = json['ktp'];
    passportNo = json['passport_no'];
    passportExpiredDate = json['passport_expired_date'];
    jobLevelId = json['job_level_id'];
    positionId = json['position_id'];
    hiredDate = json['hired_date'];
    isTeacherOfStaff = json['is_teacher_of_staff'];
    isEmploymentStatus = json['is_employment_status'];
    phoneNumber = json['phone_number'];
    mobileNumber = json['mobile_number'];
    addressKtp = json['address_ktp'];
    schoolEmail = json['school_email'];
    maritalStatus = json['marital_status'];
    active = json['active'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    divisionId = json['division_id'];
    departmentId = json['department_id'];
    countryId = json['country_id'];
    provinceId = json['province_id'];
    regencyId = json['regency_id'];
    districtId = json['district_id'];
    resign = json['resign'];
    coordinatorId = json['coordinator_id'];
    genderTitle = json['gender_title'];
    deviceToken = json['device_token'];
    qr = json['qr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['company_id'] = companyId;
    data['nik'] = nik;
    data['name'] = name;
    data['email'] = email;
    data['gender'] = gender;
    data['place_of_birth'] = placeOfBirth;
    data['dob'] = dob;
    data['religion_id'] = religionId;
    data['is_local_or_expat'] = isLocalOrExpat;
    data['ktp'] = ktp;
    data['passport_no'] = passportNo;
    data['passport_expired_date'] = passportExpiredDate;
    data['job_level_id'] = jobLevelId;
    data['position_id'] = positionId;
    data['hired_date'] = hiredDate;
    data['is_teacher_of_staff'] = isTeacherOfStaff;
    data['is_employment_status'] = isEmploymentStatus;
    data['phone_number'] = phoneNumber;
    data['mobile_number'] = mobileNumber;
    data['address_ktp'] = addressKtp;
    data['school_email'] = schoolEmail;
    data['marital_status'] = maritalStatus;
    data['active'] = active;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['division_id'] = divisionId;
    data['department_id'] = departmentId;
    data['country_id'] = countryId;
    data['province_id'] = provinceId;
    data['regency_id'] = regencyId;
    data['district_id'] = districtId;
    data['resign'] = resign;
    data['coordinator_id'] = coordinatorId;
    data['gender_title'] = genderTitle;
    data['device_token'] = deviceToken;
    data['qr'] = qr;
    return data;
  }
}