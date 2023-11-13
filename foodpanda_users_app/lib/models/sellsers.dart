class Sellers
{
  String? sellerUID;
  String? sellerName;
  String? sellerAvaterUrl;
  String? sellerEmail;


  Sellers({
    this.sellerUID,
    this.sellerName,
    this.sellerAvaterUrl,
    this.sellerEmail,

  });
   //sacamos datos del json del firestore
  Sellers.fromjson(Map<String, dynamic> json)
  {
    sellerUID = json["sellerUID"];
    sellerName = json["sellerName"];
    sellerAvaterUrl = json["sellerAvaterUrl"];
    sellerEmail = json["sellerEmail"];
  }
  //metemos datos creando otro nuevo json
  Map<String, dynamic> tojson()
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["sellerUID"] = this.sellerUID;
    data["sellerName"] = this.sellerName;
    data["sellerAvaterUrl"] = this.sellerAvaterUrl;
    data["sellerEmail"] = this.sellerEmail;
    return data;
  }
}