import 'package:Food_Order/base/base_event.dart';
import 'package:flutter/widgets.dart';

class SignInEvent extends BaseEvent {
  String phone;

  SignInEvent({
    @required this.phone,
  });
}
