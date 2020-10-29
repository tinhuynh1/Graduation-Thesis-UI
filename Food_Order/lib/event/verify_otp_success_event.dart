import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/models/user.dart';

class VerifyOTPSuccessEvent extends BaseEvent {
  final User userData;
  VerifyOTPSuccessEvent(this.userData);
}
