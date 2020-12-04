import 'package:Food_Order/models/product/product.dart';

class Category {
  int categoryId;
  String categoryName;
  List<Product> listProduct;
  Category({this.categoryId, this.categoryName, this.listProduct});
  static List<Category> parseCategoryList(map) {
    var list = map['listChildrenCategory'] as List;
    return list.map((category) => Category.fromJson(category)).toList();
  }

  factory Category.fromJson(Map<String, dynamic> map) => Category(
        categoryId: map["categoryId"],
        categoryName: map["categoryName"],
        listProduct: map['listProduct'] != null
            ? map['listProduct']
                .map<Product>((map) => Product.fromJson(map))
                .toList()
            : null,
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
        "listProduct": List<dynamic>.from(listProduct.map((x) => x.toJson())),
      };
}
