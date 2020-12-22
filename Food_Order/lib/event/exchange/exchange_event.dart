import 'package:Food_Order/base/base_event.dart';
import 'package:flutter/widgets.dart';

class ExchangeEvent extends BaseEvent {
  int rewardId;

  ExchangeEvent({
    @required this.rewardId,
  });
}
