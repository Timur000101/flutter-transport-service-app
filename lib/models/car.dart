class Car{
  int id;
  String name;
  int year;
  double size;
  double milage;
  int user;

  Car({this.id, this.name, this.year, this.size, this.milage, this.user});

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    year = json['year'];
    size = json['size'];
    milage = json['milage'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['year'] = this.year;
    data['size'] = this.size;
    data['milage'] = this.milage;
    data['user'] = this.user;
    return data;
  }

}