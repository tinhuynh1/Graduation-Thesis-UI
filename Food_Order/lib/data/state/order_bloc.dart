import 'dart:async';

import 'package:Food_Order/data/state/attribute_state.dart';
import 'package:Food_Order/data/state/order_state.dart';
import 'package:Food_Order/data/state/topping_state.dart';
import 'package:Food_Order/data/state/total_state.dart';
import 'package:Food_Order/event/order_event.dart';
import 'package:Food_Order/models/product/product.dart';

class RemoteBloc {
  var state = RemoteState(1);
  var value = AttributeState(0);
  var isCheck = ToppingState(false, 0);
  var total = TotalState(0);
  final eventController = StreamController<RemoteEvent>();

  // 1 cái quản lý state, đảm nhận nhiệm vụ truyền state đến UI
  final stateController = StreamController<RemoteState>.broadcast();
  final valueController = StreamController<AttributeState>.broadcast();
  final toppingController = StreamController<ToppingState>.broadcast();
  final totalController = StreamController<TotalState>.broadcast();
  RemoteBloc() {
    // lắng nghe khi eventController push event mới
    eventController.stream.listen((RemoteEvent event) {
      // người ta thường tách hàm này ra 1 hàm riêng và đặt tên là: mapEventToState
      // đúng như cái tên, hàm này nhận event xử lý và cho ra output là state

      if (event is IncrementEvent) {
        // nếu eventController vừa add vào 1 IncrementEvent thì chúng ta xử lý tăng âm lượng
        state = RemoteState(state.quantity + event.increment);
      } else if (event is DecrementEvent) {
        // xử lý giảm âm lượng
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
        isCheck = ToppingState(event.isCheck, event.id);
      }
      if (event is TotalEvent) {
        if (state.quantity == 1) {
          total = TotalState(30.000);
        }
      }
      // add state mới vào stateController để bên UI nhận được
      stateController.sink.add(state);
      valueController.sink.add(value);
      toppingController.sink.add(isCheck);
      totalController.sink.add(total);
    });
  }
  void dispose() {
    stateController.close();
    eventController.close();
  }
}
