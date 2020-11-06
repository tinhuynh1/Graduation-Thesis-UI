import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/models/customer.dart';

class CreateInfoUserSuccessEvent extends BaseEvent {
  final Customer customerData;
  CreateInfoUserSuccessEvent(this.customerData);
}
