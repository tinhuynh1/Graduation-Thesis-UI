class Product {
  int productId;
  String productName;
  String image;
  double price;

  Product({
    this.productId,
    this.productName,
    this.image,
    this.price,
  });

  static List<Product> parseProductList(map) {
    var list = map['data'] as List;
    return list.map((product) => Product.fromJson(product)).toList();
  }

  factory Product.fromJson(Map<String, dynamic> map) => Product(
        productId: map["productId"],
        productName: map["productName"],
        image: map["image"],
        price: double.tryParse(map['price'].toString()) ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "productImage": image,
        "price": price,
      };
}
