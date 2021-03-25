import 'car.dart';

class  Order{
  int id;
  Car car;
  String stoPhone;
  String stoName;
  int price;
  String time;
  dynamic subservice;
  String distance;

  Order({
    this.id,
    this.car,
    this.stoPhone,
    this.stoName,
    this.price,
    this.time,
    this.subservice,
    this.distance,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    car = Car.fromJson(json['order']['car']);
    stoName = json['cto']['cto_name'];
    stoPhone = json['cto']['phone'];
    price = json['price'];
    time = json['time'];
    subservice = json['order']['subservice'];
    distance = json['distance_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['car'] = this.car.toJson();
    data['stoName'] = this.stoName;
    data['stoPhone'] = this.stoPhone;
    data['price'] = this.price;
    data['time'] = this.time;
    data['subservice'] = this.subservice;
    data['distance'] = this.distance;
    return data;
  }

}