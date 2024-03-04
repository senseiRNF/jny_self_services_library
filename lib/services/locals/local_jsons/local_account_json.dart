class LocalAccountJson {
  String? userId;
  String? username;
  String? name;
  String? email;
  String? accessToken;

  LocalAccountJson({
    this.userId,
    this.username,
    this.name,
    this.email,
    this.accessToken,
  });

  LocalAccountJson.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    name = json['name'];
    email = json['email'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['username'] = username;
    data['name'] = name;
    data['email'] = email;
    data['access_token'] = accessToken;
    return data;
  }
}