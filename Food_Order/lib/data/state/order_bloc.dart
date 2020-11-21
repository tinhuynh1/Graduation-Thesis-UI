import 'dart:async';

import 'package:Food_Order/data/state/attribute_state.dart';
import 'package:Food_Order/data/state/list_topping_state.dart';
import 'package:Food_Order/data/state/order_state.dart';
import 'package:Food_Order/data/state/topping_state.dart';
import 'package:Food_Order/data/state/total_state.dart';
import 'package:Food_Order/event/order_event.dart';

class RemoteBloc {
  List<bool> listCheck = [];
  var state = RemoteState(1);
  var value = AttributeState(0);
  var listValue = ToppingState([
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ], 0);
  var total = TotalState(0);
  var lenght = ListToppingState(0);
  final eventController = StreamController<RemoteEvent>();

  // 1 cái quản lý state, đảm nhận nhiệm vụ truyền state đến UI
  final stateController = StreamController<RemoteState>.broadcast();
  final valueController = StreamController<AttributeState>.broadcast();
  final toppingController = StreamController<ToppingState>.broadcast();
  final totalController = StreamController<TotalState>.broadcast();
  final lengthController = StreamController<ListToppingState>.broadcast();
  final listCheckController = StreamController<List<bool>>.broadcast();
  RemoteBloc() {
    // lắng nghe khi eventController push event mới
    eventController.stream.listen((RemoteEvent event) {
      if (event is IncrementEvent) {
        state = RemoteState(state.quantity + event.increment);
      } else if (event is DecrementEvent) {
        if (state.quantity == 1) {
          RemoteState(1);
        } else
          state = RemoteState(state.quantity - event.decrement);
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
        //listCheck = new List(event.length);
        listCheck = List.generate(event.length, (int index) => false);
        //print(event.length);
      }

      stateController.sink.add(state);
      valueController.sink.add(value);
      toppingController.sink.add(listValue);
      totalController.sink.add(total);
      lengthController.sink.add(lenght);
    });
  }
  void dispose() {
    stateController.close();
    valueController.close();
    toppingController.close();
    totalController.close();
    eventController.close();
    lengthController.close();
    listCheckController.close();
  }
}
