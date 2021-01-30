class Brands {
  String model;
  int pk;
  Fields fields;

  Brands({this.model, this.pk, this.fields});

  factory Brands.fromJson(Map<String, dynamic> json) {
    return Brands(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]));
  }

  Map<String, dynamic> toJson() {
    return {
      "model": model,
      "pk": pk,
      "fields": fields.toJson(),
    };
  }
}

class Fields {
  String name;
  String brand;

  Fields({
    this.name,
    this.brand,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        name: json["name"],
        brand: json["brand"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "brand": brand,
      };
}
