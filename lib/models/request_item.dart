import 'car.dart';

class RequestItem {
  int id;
  Car car;
  String about;
  Map<String,String> service;
  Map<String,String> subservice;
  int owner;
  List<Map<String,String>> orderImg;

  RequestItem({
    this.id,
    this.about,
    this.service,
    this.subservice,
    this.owner,
    this.orderImg
  });

  RequestItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    about = json['about'];
    service = json['service'];
    subservice = json['subservice'];
    owner = json['owner'];
    orderImg = json['order_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['about'] = this.about;
    data['service'] = this.service;
    data['subservice'] = this.subservice;
    data['owner'] = this.owner;
    data['order_img'] = this.orderImg;
    return data;
  }
}
