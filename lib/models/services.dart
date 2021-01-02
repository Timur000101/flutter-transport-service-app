// To parse this JSON data, do
//
//     final services = servicesFromJson(jsonString);

import 'dart:convert';

List<Services> servicesFromJson(String str) => List<Services>.from(json.decode(str).map((x) => Services.fromJson(x)));

String servicesToJson(List<Services> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Services {
    Services({
        this.model,
        this.pk,
        this.fields,
    });

    Model model;
    int pk;
    Fields fields;

    factory Services.fromJson(Map<String, dynamic> json) => Services(
        model: modelValues.map[json["model"]],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    Fields({
        this.name,
        this.service,
    });

    String name;
    String service;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        name: json["name"],
        service: json["service"] == null ? null : json["service"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "service": service == null ? null : service,
    };
}

enum Model { SERVICES_SERVICE, SERVICES_SUBSERVICE }

final modelValues = EnumValues({
    "services.service": Model.SERVICES_SERVICE,
    "services.subservice": Model.SERVICES_SUBSERVICE
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
