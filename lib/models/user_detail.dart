class UserDetail {
  int id;
  String phone;
  String avatar;
  Null email;
  String nickname;

  UserDetail({this.id, this.phone, this.avatar, this.email, this.nickname});

  UserDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    avatar = json['avatar'];
    email = json['email'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    data['nickname'] = this.nickname;
    return data;
  }
}
