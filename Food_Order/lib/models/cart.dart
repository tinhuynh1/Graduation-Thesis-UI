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
      this.note});
  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "productId": product.listProductOption != null
            ? product.listProductOption[atrributeId].productId
            : product.productId,
        "listToppingId": List<dynamic>.from(listTopping.map((x) => x)),
        "note": note,
      };
}
