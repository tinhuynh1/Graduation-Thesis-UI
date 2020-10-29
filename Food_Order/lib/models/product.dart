import 'package:Food_Order/models/category.dart';

class Product {
  Category category;
  int productId;
  String productName;
  String productImage;
  double price;

  Product({
    this.category,
    this.productId,
    this.productName,
    this.productImage,
    this.price,
  });

  static List<Product> parseProductList(map) {
    var list = map['data'] as List;
    return list.map((product) => Product.fromJson(product)).toList();
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        category: json["category"] ?? '',
        productId: json["productId"],
        productName: json["productName"],
        productImage: json["productImage"],
        price: double.tryParse(json['price'].toString()) ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "productId": productId,
        "productName": productName,
        "productImage": productImage,
        "price": price,
      };
}
