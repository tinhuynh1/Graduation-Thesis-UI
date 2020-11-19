class ProductOption {
  int attributeProductValueId;
  String attributeValue;
  String createDate;
  double price;
  int productId;
  String productName;
  String productType;
  String status;
  String updateDate;

  ProductOption(
      {this.attributeProductValueId,
      this.attributeValue,
      this.createDate,
      this.price,
      this.productId,
      this.productName,
      this.productType,
      this.status,
      this.updateDate});
  factory ProductOption.fromJson(Map<String, dynamic> map) => ProductOption(
        attributeProductValueId: map["attributeProductValueId"],
        attributeValue: map["attributeValue"],
        createDate: map["createDate"],
        price: double.tryParse(map['price'].toString()) ?? 0,
        productName: map["productName"],
        productId: map["productId"],
        productType: map["productType"],
        status: map["status"],
        updateDate: map["updateDate"],
      );

  Map<String, dynamic> toJson() => {
        "attributeProductValueId": attributeProductValueId,
        "attributeValue": attributeValue,
        "createDate": createDate,
        "price": price,
        "productName": productName,
        "productId": productId,
        "productType": productType,
        "status": status,
        "updateDate": updateDate,
      };
}
