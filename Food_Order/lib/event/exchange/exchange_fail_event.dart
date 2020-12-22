import 'package:Food_Order/base/base_event.dart';

class ExchangeFailEvent extends BaseEvent {
  final String errMessage;
  ExchangeFailEvent(this.errMessage);
}
