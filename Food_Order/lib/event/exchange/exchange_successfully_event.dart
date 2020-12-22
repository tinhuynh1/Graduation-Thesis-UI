import 'package:Food_Order/base/base_event.dart';

class ExchangeSuccessEvent extends BaseEvent {
  final String message;
  ExchangeSuccessEvent(this.message);
}
