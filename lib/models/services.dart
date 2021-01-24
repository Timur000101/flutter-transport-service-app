// import 'dart:convert';

class Services {
  String model;
  int pk;
  bool checked;
  Fields fields;

  Services({this.model, this.pk, this.fields, this.checked});

  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(
        model: json["model"],
        pk: json["pk"],
        checked: false,
        fields: Fields.fromJson(json["fields"]));
  }

  Map<String, dynamic> toJson() {
    return {
      "model": model,
      "pk": pk,
      "checked": checked,
      "fields": fields.toJson(),
    };
  }
}

class Fields {
  String name;
  String service;

  Fields({
    this.name,
    this.service,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        name: json["name"],
        service: json["service"],
      );
//  == null ? null : json["service"]
  Map<String, dynamic> toJson() => {
        "name": name,
        "service": service,
      };
}

//  == null ? null : service


