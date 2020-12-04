import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/models/product/product_details.dart';

abstract class RemoteEvent extends BaseEvent {}

class IncrementEvent extends RemoteEvent {
  IncrementEvent(this.increment, this.product);

  final int increment;
  final ProductDetails product;
}

class DecrementEvent extends RemoteEvent {
  DecrementEvent(this.decrement, this.product);

  final int decrement;
  final ProductDetails product;
}

class SelectAttributeValueEvent extends RemoteEvent {
  SelectAttributeValueEvent(this.value, this.product);
  final int value;
  final ProductDetails product;
}

class CheckToppingEvent extends RemoteEvent {
  CheckToppingEvent(this.value, this.index, this.id, this.toppingName,
      this.toppingPrice, this.product);
  final bool value;
  final int index;
  final int id;
  final String toppingName;
  final double toppingPrice;
  final ProductDetails product;
}

class SetLengthListToppingEvent extends RemoteEvent {
  SetLengthListToppingEvent(this.length, this.product);
  final int length;
  final ProductDetails product;
}

class AddProductToCartEvent extends RemoteEvent {
  AddProductToCartEvent(this.product, this.attributeId, this.total);
  final ProductDetails product;
  final int attributeId;
  final double total;
}
