import 'package:Food_Order/base/base_event.dart';

class VerifyOTPFailEvent extends BaseEvent {
  final String errMessage;
  VerifyOTPFailEvent(this.errMessage);
}
