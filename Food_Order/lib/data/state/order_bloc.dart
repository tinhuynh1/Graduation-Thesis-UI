import 'dart:async';
import 'package:Food_Order/base/base_bloc.dart';
import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/data/state/attribute_state.dart';
import 'package:Food_Order/data/state/list_topping_state.dart';
import 'package:Food_Order/data/state/order_state.dart';
import 'package:Food_Order/data/state/product_cart_state.dart';
import 'package:Food_Order/data/state/topping_state.dart';
import 'package:Food_Order/data/state/total_state.dart';
import 'package:Food_Order/event/order_event.dart';
import 'package:Food_Order/models/cart.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:flutter/widgets.dart';

class OrderBloc extends BaseBloc with ChangeNotifier {
  List<bool> listCheck = [];
  List<int> listTopping = new List();
  List<String> listToppingName = new List();
  List<double> listToppingPrice = new List();
  var state = RemoteState(1);
  var value = AttributeState(0);
  var listValue = ToppingState([], 0);
  var total = TotalState(0);
  var lenght = ListToppingState(0);
  var product = ProductCartState(null);
  final eventController = StreamController<RemoteEvent>();

  final stateController = StreamController<RemoteState>.broadcast();
  final valueController = StreamController<AttributeState>.broadcast();
  final toppingController = StreamController<ToppingState>.broadcast();
  final totalController = StreamController<TotalState>.broadcast();
  final lengthController = StreamController<ListToppingState>.broadcast();
  final productCartController = StreamController<ProductCartState>.broadcast();
  final listCheckController = StreamController<List<bool>>.broadcast();

  @override
  void dispatchEvent(BaseEvent event) {
    if (event is IncrementEvent) {
      state = RemoteState(state.quantity + event.increment);
    } else if (event is DecrementEvent) {
      if (state.quantity == 1) {
        RemoteState(1);
      } else {
        state = RemoteState(state.quantity - event.decrement);
      }
    }
    if (event is SelectAttributeValueEvent) {
      value = AttributeState(event.value);
      if (value.value == 1) {
        total = TotalState(20.000);
      }
    }
    if (event is CheckToppingEvent) {
      listCheck[event.index] = event.value;
      listValue = ToppingState(listCheck, event.index);
      if (event.value == true) {
        listTopping.add(event.id);
        listToppingName.add(event.toppingName);
        listToppingPrice.add(event.toppingPrice);
      }
      if (event.value == false) {
        listTopping.remove(event.id);
        listToppingName.remove(event.toppingName);
        listToppingPrice.remove(event.toppingPrice);
      }
      print(listToppingName.toString());
      print(listTopping.toString());
    }
    if (event is SetLengthListToppingEvent) {
      lenght = ListToppingState(event.length);
      listCheck = List.generate(event.length, (int index) => false);
      listValue = ToppingState(listCheck, 0);
    }
    if (event is AddProductToCartEvent) {
      product = ProductCartState(event.product);
      print('add ' + event.product.productName + ' to cart');
      ListProduct.listProduct.add(Cart(
        product: event.product,
        quantity: state.quantity,
        atrributeId: value.value,
        listTopping: listTopping,
        listToppingName: listToppingName,
        listToppingPrice: listToppingPrice,
        totalPrice: event.totalPrice,
      ));
    }
    stateController.sink.add(state);
    valueController.sink.add(value);
    toppingController.sink.add(listValue);
    totalController.sink.add(total);
    lengthController.sink.add(lenght);
    productCartController.add(product);
  }

  @override
  void dispose() {
    super.dispose();
    productCartController.close();
    stateController.close();
    valueController.close();
    toppingController.close();
    totalController.close();
    eventController.close();
    lengthController.close();
    listCheckController.close();
  }
}
