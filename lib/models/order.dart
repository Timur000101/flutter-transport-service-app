class Order{
  String carName;
  String problemTitle;
  String stoName;
  String duration;
  String cost;
  String city;
  String range;

  Order(
    this.carName,
    this.problemTitle,
    this.stoName,
    this.duration,
    this.cost,
    this.city,
    this.range,
  );

  // Order.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   about = json['about'];
  //   service = json['service'];
  //   subservice = json['subservice'];
  //   owner = json['owner'];
  //   orderImg = json['order_img'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['about'] = this.about;
  //   data['service'] = this.service;
  //   data['subservice'] = this.subservice;
  //   data['owner'] = this.owner;
  //   data['order_img'] = this.orderImg;
  //   return data;
  // }

}