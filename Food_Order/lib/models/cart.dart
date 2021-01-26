import 'package:Food_Order/models/product/product_cart_response.dart';
import 'package:Food_Order/models/product/product_details.dart';

class Cart {
  ProductDetails product;
  int quantity;
  int productId;
  int atrributeId;
  List<int> listTopping;
  List<String> listToppingName;
  List<double> listToppingPrice;
  int attributeId;
  double total;
  String note;
  ProductCartResponse productCart;
  Cart(
      {this.product,
      this.productId,
      this.quantity,
      this.atrributeId,
      this.listTopping,
      this.listToppingName,
      this.listToppingPrice,
      this.attributeId,
      this.total,
      this.note,
      this.productCart});
  factory Cart.fromJson(Map<String, dynamic> map) => Cart(
        quantity: map["quantity"],
        total: double.tryParse(map['amount'].toString()) ?? 0,
        productCart: map["product"] != null
            ? ProductCartResponse.fromJson(map["product"])
            : null,
      );
  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "productId": product.listProductOption != null
            ? product.listProductOption[atrributeId].productId
            : product.productId,
        "listToppingId": List<dynamic>.from(listTopping.map((x) => x)),
        "note": note,
      };
}
