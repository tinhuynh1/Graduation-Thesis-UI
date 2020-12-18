import 'package:Food_Order/base/base_event.dart';

class SelectBodyEvent extends BaseEvent {
  SelectBodyEvent(this.index);
  final int index;
}
