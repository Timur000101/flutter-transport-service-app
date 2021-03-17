import 'package:sto_app/models/car.dart';

class ActiveOrderCustomer {
  int id;
  Car car;
  String about;
  Service service;
  String subservice;
  Owner owner;
  List<dynamic> orderImg;
  bool inWork;
  bool isFinished;

  ActiveOrderCustomer(
      {this.id,
        this.car,
        this.about,
        this.service,
        this.subservice,
        this.owner,
        this.orderImg,
        this.inWork,
        this.isFinished});

  ActiveOrderCustomer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    car = json['car'] != null ? new Car.fromJson(json['car']) : null;
    about = json['about'];
    service =
    json['service'] != null ? new Service.fromJson(json['service']) : null;
    subservice = json['subservice'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    if (json['order_img'] != null) {
      orderImg = new List<dynamic>();
      json['order_img'].forEach((v) {
        orderImg.add(v);
      });
    }
    inWork = json['in_work'];
    isFinished = json['is_finished'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.car != null) {
      data['car'] = this.car.toJson();
    }
    data['about'] = this.about;
    if (this.service != null) {
      data['service'] = this.service.toJson();
    }
    data['subservice'] = this.subservice;
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    if (this.orderImg != null) {
      data['order_img'] = this.orderImg.map((v) => v.toJson()).toList();
    }
    data['in_work'] = this.inWork;
    data['is_finished'] = this.isFinished;
    return data;
  }
}

// class Car {
//   int id;
//   List<CarImg> carImg;
//   String name;
//   int year;
//   int size;
//   int milage;
//   int user;
//
//   Car(
//       {this.id,
//         this.carImg,
//         this.name,
//         this.year,
//         this.size,
//         this.milage,
//         this.user});
//
//   Car.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     if (json['car_img'] != null) {
//       carImg = new List<CarImg>();
//       json['car_img'].forEach((v) {
//         carImg.add(new CarImg.fromJson(v));
//       });
//     }
//     name = json['name'];
//     year = json['year'];
//     size = json['size'];
//     milage = json['milage'];
//     user = json['user'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.carImg != null) {
//       data['car_img'] = this.carImg.map((v) => v.toJson()).toList();
//     }
//     data['name'] = this.name;
//     data['year'] = this.year;
//     data['size'] = this.size;
//     data['milage'] = this.milage;
//     data['user'] = this.user;
//     return data;
//   }
// }

// class CarImg {
//   String image;
//
//   CarImg({this.image});
//
//   CarImg.fromJson(Map<String, dynamic> json) {
//     image = json['image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['image'] = this.image;
//     return data;
//   }
// }

class Service {
  String name;

  Service({this.name});

  Service.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Owner {
  int id;
  String phone;
  String avatar;
  Null email;
  String nickname;
  Null secondPhone;
  Null thirdPhone;

  Owner(
      {this.id,
        this.phone,
        this.avatar,
        this.email,
        this.nickname,
        this.secondPhone,
        this.thirdPhone});

  Owner.fromJson(Map<String, dynamic> json) {
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