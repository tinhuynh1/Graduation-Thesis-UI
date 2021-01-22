import 'package:Food_Order/base/base_event.dart';

class DeleteItemEvent extends BaseEvent {
  final int index;

  DeleteItemEvent(this.index);
}
