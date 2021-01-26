import 'package:Food_Order/base/base_event.dart';

class OrderFailEvent extends BaseEvent {
  final String errMessage;
  OrderFailEvent(this.errMessage);
}
