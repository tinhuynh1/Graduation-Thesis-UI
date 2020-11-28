import 'dart:async';

import 'package:Food_Order/base/base_bloc.dart';
import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/data/state/attribute_state.dart';
import 'package:Food_Order/data/state/list_topping_state.dart';
import 'package:Food_Order/data/state/order_state.dart';
import 'package:Food_Order/data/state/topping_state.dart';
import 'package:Food_Order/data/state/total_state.dart';
import 'package:Food_Order/event/order_event.dart';
import 'package:flutter/widgets.dart';

class OrderBloc extends BaseBloc with ChangeNotifier {
  List<bool> listCheck = [];
  var state = RemoteState(1);
  var value = AttributeState(0);
  var listValue = ToppingState([], 0);
  var total = TotalState(0);
  var lenght = ListToppingState(0);
  final eventController = StreamController<RemoteEvent>();

  final stateController = StreamController<RemoteState>.broadcast();
  final valueController = StreamController<AttributeState>.broadcast();
  final toppingController = StreamController<ToppingState>.broadcast();
  final totalController = StreamController<TotalState>.broadcast();
  final lengthController = StreamController<ListToppingState>.broadcast();
  final listCheckController = StreamController<List<bool>>.broadcast();

  @override
  void dispatchEvent(BaseEvent event) {
    if (event is IncrementEvent) {
      state = RemoteState(state.quantity + event.increment);
      print('Increment Event');
    } else if (event is DecrementEvent) {
      if (state.quantity == 1) {
        RemoteState(1);
        print('Decrement Event');
      } else {
        state = RemoteState(state.quantity - event.decrement);
        print('Decrement Event');
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
      print(listCheck.toString());
    }
    if (event is TotalEvent) {
      if (state.quantity == 1) {
        total = TotalState(30.000);
      }
    }
    if (event is SetLengthListToppingEvent) {
      lenght = ListToppingState(event.length);
      listCheck = List.generate(event.length, (int index) => false);
      listValue = ToppingState(listCheck, 0);
    }

    stateController.sink.add(state);
    valueController.sink.add(value);
    toppingController.sink.add(listValue);
    totalController.sink.add(total);
    lengthController.sink.add(lenght);
  }

  @override
  void dispose() {
    super.dispose();
    stateController.close();
    valueController.close();
    toppingController.close();
    totalController.close();
    eventController.close();
    lengthController.close();
    listCheckController.close();
  }
}
