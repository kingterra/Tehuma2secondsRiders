class AddressUID {
  String? adreesuid;

  AddressUID({
    this.adreesuid,
  });

  AddressUID.fromjson(Map<String, dynamic> json)
  {
    adreesuid = json['adressID'];
  }

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['adressID'] = this.adreesuid;
    return data;
  }
}
