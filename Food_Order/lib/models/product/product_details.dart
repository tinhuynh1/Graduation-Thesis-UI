import 'package:Food_Order/models/product/attribute.dart';
import 'package:Food_Order/models/product/product_options.dart';
import 'package:Food_Order/models/product/topping.dart';

class ProductDetails {
  Attribute attribute;
  DateTime createDate;
  String description;
  String image;
  List<ProductOption> listProductOption;
  List<Topping> listTopping;
  double price;
  int productId;
  String productName;
  String productType;
  DateTime updateDate;
  ProductDetails(
      {this.attribute,
      this.description,
      this.createDate,
      this.image,
      this.listProductOption,
      this.listTopping,
      this.price,
      this.productId,
      this.productName,
      this.productType,
      this.updateDate});
  factory ProductDetails.fromJson(Map<String, dynamic> map) => ProductDetails(
        attribute: map["attribute"] != null
            ? Attribute.fromJson(map["attribute"])
            : null,
        createDate: DateTime.parse(map["createDate"].toString()),
        description: map["description"],
        image: map["image"],
        listProductOption: map["listProductOption"] != null
            ? map['listProductOption']
                .map<ProductOption>((map) => ProductOption.fromJson(map))
                .toList()
            : null,
        listTopping: map["listTopping"] != null
            ? map['listTopping']
                .map<Topping>((map) => Topping.fromJson(map))
                .toList()
            : null,
        price: double.tryParse(map['price'].toString()) ?? 0,
        productId: map["productId"],
        productName: map["productName"],
        productType: map["productType"],
        updateDate: DateTime.parse(map["updateDate"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "attribute": attribute,
        "description": description,
        "image": image,
        "listProductOption": listProductOption,
        "listTopping": listTopping,
        "price": price,
        "productId": productId,
        "productName": productName,
        "productType": productType,
        "updateDate": updateDate,
      };
}
