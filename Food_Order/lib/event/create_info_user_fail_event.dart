import 'package:Food_Order/base/base_event.dart';

class CreateInfoUserFailEvent extends BaseEvent {
  final String errMessage;
  CreateInfoUserFailEvent(this.errMessage);
}
