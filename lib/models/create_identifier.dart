class CreateIdentifier {
  String ctoName;
  String key;
  String ctoLogo;
  Null ctoAddress;

  CreateIdentifier({this.ctoName, this.key, this.ctoLogo, this.ctoAddress});

  CreateIdentifier.fromJson(Map<String, dynamic> json) {
    ctoName = json['cto_name'];
    key = json['key'];
    ctoLogo = json['cto_logo'];
    ctoAddress = json['cto_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cto_name'] = this.ctoName;
    data['key'] = this.key;
    data['cto_logo'] = this.ctoLogo;
    data['cto_address'] = this.ctoAddress;
    return data;
  }
}