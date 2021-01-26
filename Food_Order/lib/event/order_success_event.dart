import 'package:Food_Order/base/base_event.dart';

class OrderSuccessEvent extends BaseEvent {
  final int orderId;
  OrderSuccessEvent(this.orderId);
}
