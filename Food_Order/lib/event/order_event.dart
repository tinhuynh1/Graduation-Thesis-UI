import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/models/product/product_details.dart';

abstract class RemoteEvent extends BaseEvent {}

class IncrementEvent extends RemoteEvent {
  IncrementEvent(this.increment);

  final int increment;
}

class DecrementEvent extends RemoteEvent {
  DecrementEvent(this.decrement);

  final int decrement;
}

class SelectAttributeValueEvent extends RemoteEvent {
  SelectAttributeValueEvent(this.value);
  final int value;
}

class CheckToppingEvent extends RemoteEvent {
  CheckToppingEvent(
      this.value, this.index, this.id, this.toppingName, this.toppingPrice);
  final bool value;
  final int index;
  final int id;
  final String toppingName;
  final double toppingPrice;
}

class SetLengthListToppingEvent extends RemoteEvent {
  SetLengthListToppingEvent(this.length);
  final int length;
}

class AddProductToCartEvent extends RemoteEvent {
  AddProductToCartEvent(this.product, this.totalPrice);
  final ProductDetails product;
  final double totalPrice;
}
