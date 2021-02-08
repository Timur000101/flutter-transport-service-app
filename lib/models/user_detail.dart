class UserDetail {
  int id;
  String phone;
  String avatar;
  Null email;
  String nickname;
  Null secondPhone;
  Null thirdPhone;

  UserDetail({this.id, this.phone, this.avatar, this.email, this.nickname, this.secondPhone, this.thirdPhone});

  UserDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    avatar = json['avatar'];
    email = json['email'];
    nickname = json['nickname'];
    secondPhone = json['second_phone'];
    thirdPhone = json['third_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    data['nickname'] = this.nickname;
    data['second_phone'] = this.secondPhone;
    data['third_phone'] = this.thirdPhone;
    return data;
  }
}
