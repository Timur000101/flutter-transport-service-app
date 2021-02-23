class UserDetail {
  int id;
  String phone;
  String avatar;
  Null email;
  String nickname;
  String secondPhone;
  String thirdPhone;
  String ctoName;
  String ctoLogo;
  Null ctoAddress;

  UserDetail(
      {this.id,
        this.phone,
        this.avatar,
        this.email,
        this.nickname,
        this.secondPhone,
        this.thirdPhone,
        this.ctoName,
        this.ctoLogo,
        this.ctoAddress});

  UserDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    avatar = json['avatar'];
    email = json['email'];
    nickname = json['nickname'];
    secondPhone = json['second_phone'];
    thirdPhone = json['third_phone'];
    ctoName = json['cto_name'];
    ctoLogo = json['cto_logo'];
    ctoAddress = json['cto_address'];
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
    data['cto_name'] = this.ctoName;
    data['cto_logo'] = this.ctoLogo;
    data['cto_address'] = this.ctoAddress;
    return data;
  }
}