import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/models/store.dart';

class PickUpStoreEvent extends BaseEvent {
  PickUpStoreEvent(this.value, this.store);
  final int value;
  final Store store;
}
