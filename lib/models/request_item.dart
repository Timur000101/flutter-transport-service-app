import 'car.dart';

class RequestItem {
  int id;
  Car car;
  String about;
  dynamic service;
  dynamic subservice;
  int owner;
  List<dynamic> orderImg;

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
    car = Car.fromJson(json['car']);
    about = json['about'];
    service = json['service'];
    subservice = json['subservice'];
    owner = json['owner'];
    orderImg = json['order_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['car'] = this.car.toJson();
    data['about'] = this.about;
    data['service'] = this.service;
    data['subservice'] = this.subservice;
    data['owner'] = this.owner;
    data['order_img'] = this.orderImg;
    return data;
  }
}
