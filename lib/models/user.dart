class User {
  String? id;
  String? name;
  String? email;
  String? accessToken;
  String? refreshToken;

  User({this.id, this.name, this.email, this.accessToken, this.refreshToken});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ;
    name = json['name'];
    email = json['email'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    return data;
  }
}