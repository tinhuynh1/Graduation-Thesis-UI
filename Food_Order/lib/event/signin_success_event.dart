import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/models/sms.dart';

class SignInSuccessEvent extends BaseEvent {
  final Sms smsData;
  SignInSuccessEvent(this.smsData);
}
