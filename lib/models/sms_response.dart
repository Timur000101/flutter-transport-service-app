class SmsResponse {
  String key;
  int uid;
  String status;
  String nickname;

  SmsResponse({this.key, this.uid, this.status, this.nickname});

  SmsResponse.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    uid = json['uid'];
    status = json['status'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['uid'] = this.uid;
    data['status'] = this.status;
    data['nickname'] = this.nickname;
    return data;
  }
}
