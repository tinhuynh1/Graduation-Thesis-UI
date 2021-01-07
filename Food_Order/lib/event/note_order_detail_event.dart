import 'package:Food_Order/base/base_event.dart';

class NoteOrderDetailEvent extends BaseEvent {
  final int index;
  final String note;
  NoteOrderDetailEvent(this.note, this.index);
}
