class Brand {
  String name;
  String pk;

  Brand(this.name, this.pk);

  // Brand(Map<String, dynamic> data) {
  //   name = data['fields']['name'];
  //   pk = data['pk'].toString();
  // }

  // factory Brand.fromJson(Map<String, dynamic> parsedJson){
  //   return Brand(
  //     name: parsedJson['fields']['name'],
  //     pk : parsedJson['pk'].toString(),
  //   );
  // }

}