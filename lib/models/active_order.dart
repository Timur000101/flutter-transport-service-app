class ActiveOrder {
  int id;
  Car car;
  String about;
  Service service;
  Service subservice;
  int owner;
  List<OrderImg> orderImg;
  bool inWork;
  bool isFinished;

  ActiveOrder(
      {this.id,
        this.car,
        this.about,
        this.service,
        this.subservice,
        this.owner,
        this.orderImg,
        this.inWork,
        this.isFinished});

  ActiveOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    car = json['car'] != null ? new Car.fromJson(json['car']) : null;
    about = json['about'];
    service =
    json['service'] != null ? new Service.fromJson(json['service']) : null;
    subservice = json['subservice'] != null
        ? new Service.fromJson(json['subservice'])
        : null;
    owner = json['owner'];
    if (json['order_img'] != null) {
      orderImg = new List<OrderImg>();
      json['order_img'].forEach((v) {
        orderImg.add(new OrderImg.fromJson(v));
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
    if (this.subservice != null) {
      data['subservice'] = this.subservice.toJson();
    }
    data['owner'] = this.owner;
    if (this.orderImg != null) {
      data['order_img'] = this.orderImg.map((v) => v.toJson()).toList();
    }
    data['in_work'] = this.inWork;
    data['is_finished'] = this.isFinished;
    return data;
  }
}

class Car {
  int id;
  List<CarImg> carImg;
  String name;
  int year;
  double size;
  int milage;
  int user;

  Car(
      {this.id,
        this.carImg,
        this.name,
        this.year,
        this.size,
        this.milage,
        this.user});

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['car_img'] != null) {
      carImg = new List<CarImg>();
      json['car_img'].forEach((v) {
        carImg.add(new CarImg.fromJson(v));
      });
    }
    name = json['name'];
    year = json['year'];
    size = json['size'];
    milage = json['milage'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.carImg != null) {
      data['car_img'] = this.carImg.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['year'] = this.year;
    data['size'] = this.size;
    data['milage'] = this.milage;
    data['user'] = this.user;
    return data;
  }
}

class CarImg {
  String image;

  CarImg({this.image});

  CarImg.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}

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

class OrderImg {
  int id;
  String image;

  OrderImg({this.id, this.image});

  OrderImg.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}