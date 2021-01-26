import 'package:Food_Order/models/cart.dart';
import 'package:Food_Order/models/status_order.dart';

class LastOrderResponse {
  String address;
  String orderCode;
  List<StatusOrder> listTransaction;
  String paymentMethod;
  String status;
  double totalAmount;
  String type;
  List<Cart> listOrderDetail;
  LastOrderResponse(
      {this.address,
      this.listTransaction,
      this.paymentMethod,
      this.orderCode,
      this.status,
      this.totalAmount,
      this.type,
      this.listOrderDetail});

  factory LastOrderResponse.fromJson(Map<String, dynamic> map) {
    return LastOrderResponse(
        address: map['address'],
        listTransaction: map["listTransaction"] != null
            ? map['listTransaction']
                .map<StatusOrder>((map) => StatusOrder.fromJson(map))
                .toList()
            : null,
        listOrderDetail: map["listOrderDetail"] != null
            ? map['listOrderDetail']
                .map<Cart>((map) => Cart.fromJson(map))
                .toList()
            : null,
        type: map['type'],
        orderCode: map['orderCode'],
        paymentMethod: map['paymentMethod']);
  }
}
