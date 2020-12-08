import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/models/cart.dart';

class CreateOrderEvent extends BaseEvent {
  CreateOrderEvent(this.address, this.orderType, this.latitude, this.longitude,
      this.note, this.listOrderDetail);
  final String address;
  final String orderType;
  final double latitude;
  final double longitude;
  final String note;
  final List<Cart> listOrderDetail;
}
