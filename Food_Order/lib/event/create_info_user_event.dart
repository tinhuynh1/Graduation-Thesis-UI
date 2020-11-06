import 'package:Food_Order/base/base_event.dart';
import 'package:flutter/widgets.dart';

class CreateInfoUserEvent extends BaseEvent {
  String customerName;
  String dateOfBirth;

  CreateInfoUserEvent({
    @required this.customerName,
    @required this.dateOfBirth,
  });
}
