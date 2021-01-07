import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/models/cart.dart';

class CreateOrderEvent extends BaseEvent {
  CreateOrderEvent({
    this.branchId,
    this.address,
    this.orderType,
    this.latitude,
    this.longtitude,
    this.note,
    this.listOrderDetail,
    this.receiverName,
    this.phoneNumber,
    this.amount,
    this.discountCodeId,
  });
  final String receiverName;
  final String phoneNumber;
  final String address;
  final int discountCodeId;
  final String orderType;
  final double latitude;
  final double longtitude;
  final String note;
  final List<Cart> listOrderDetail;
  final int amount;
  final String branchId;
}

class AmountEvent extends BaseEvent {
  AmountEvent(this.listOrderDetail);

  final List<Cart> listOrderDetail;
}
