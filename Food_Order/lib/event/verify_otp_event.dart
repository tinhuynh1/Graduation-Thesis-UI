import 'package:Food_Order/base/base_event.dart';
import 'package:flutter/widgets.dart';

class VerifyOTPEvent extends BaseEvent {
  // /String smsNonce;
  String otp;

  VerifyOTPEvent({@required this.otp});
}
