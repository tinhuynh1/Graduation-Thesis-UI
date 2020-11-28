import 'package:Food_Order/base/base_event.dart';

class QuantityEvent extends BaseEvent {
  final int quantity;
  QuantityEvent(this.quantity);
}
