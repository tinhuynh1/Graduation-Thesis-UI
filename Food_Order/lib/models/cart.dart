import 'package:Food_Order/models/product/product_details.dart';

class Cart {
  ProductDetails product;
  int quantity;
  int atrributeId;
  List<int> listTopping;
  List<String> listToppingName;
  List<double> listToppingPrice;
  double totalPrice;
  Cart(
      {this.product,
      this.quantity,
      this.atrributeId,
      this.listTopping,
      this.listToppingName,
      this.listToppingPrice,
      this.totalPrice});
}
