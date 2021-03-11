class Message {
  int id;
  String text;
  bool isReaded;
  int user;

  Message({this.id, this.text, this.isReaded, this.user});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    isReaded = json['is_readed'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['is_readed'] = this.isReaded;
    data['user'] = this.user;
    return data;
  }
}