import 'dart:async';
import 'package:Food_Order/base/base_bloc.dart';
import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/data/repo/order_repo.dart';
import 'package:Food_Order/data/spref/spref.dart';
import 'package:Food_Order/data/state/attribute_state.dart';
import 'package:Food_Order/data/state/list_topping_state.dart';
import 'package:Food_Order/data/state/method_state.dart';
import 'package:Food_Order/data/state/order_state.dart';
import 'package:Food_Order/data/state/product_cart_state.dart';
import 'package:Food_Order/data/state/topping_state.dart';
import 'package:Food_Order/data/state/total_state.dart';
import 'package:Food_Order/event/create_order_event.dart';
import 'package:Food_Order/event/delete_item_event.dart';
import 'package:Food_Order/event/note_order_detail_event.dart';
import 'package:Food_Order/event/order_event.dart';
import 'package:Food_Order/event/order_fail_event.dart';
import 'package:Food_Order/event/order_success_event.dart';
import 'package:Food_Order/models/amount_response.dart';
import 'package:Food_Order/models/cart.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:flutter/widgets.dart';

class OrderBloc extends BaseBloc with ChangeNotifier {
  final OrderRepo _orderRepo;
  OrderBloc({@required OrderRepo orderRepo}) : _orderRepo = orderRepo;
  double totalToppingPrice = 0;
  List<bool> listCheck = [];
  List<int> listTopping = new List();
  List<String> listToppingName = new List();
  List<double> listToppingPrice = new List();
  var state = RemoteState(1);
  var value = AttributeState(0);
  var listValue = ToppingState([], 0);
  var total = TotalState(0);
  var lenght = ListToppingState(0);
  var valueMethod = MethodState(false);
  var product = ProductCartState(null);
  final eventController = StreamController<RemoteEvent>();

  final stateController = StreamController<RemoteState>.broadcast();
  final valueController = StreamController<AttributeState>.broadcast();
  final toppingController = StreamController<ToppingState>.broadcast();
  final totalController = StreamController<TotalState>.broadcast();
  final lengthController = StreamController<ListToppingState>.broadcast();
  final productCartController = StreamController<ProductCartState>.broadcast();
  final listCheckController = StreamController<List<bool>>.broadcast();
  final valueMethodController = StreamController<MethodState>.broadcast();
  @override
  void dispatchEvent(BaseEvent event) {
    //chon so luong
    if (event is IncrementEvent) {
      state = RemoteState(state.quantity + event.increment);
      if (event.product.listProductOption == null) {
        total = TotalState(
            (event.product.price + totalToppingPrice) * state.quantity);
      } else {
        total = TotalState((event.product.listProductOption[value.value].price +
                totalToppingPrice) *
            state.quantity);
      }
    } else if (event is DecrementEvent) {
      if (state.quantity == 1) {
        RemoteState(1);
        // total = TotalState((event.product.listProductOption[value.value].price +
        //         totalToppingPrice) *
        //     state.quantity);
        if (event.product.listProductOption == null) {
          total = TotalState((event.product.price + totalToppingPrice));
        } else {
          total = TotalState(
              (event.product.listProductOption[value.value].price +
                  totalToppingPrice));
        }
      } else {
        state = RemoteState(state.quantity - event.decrement);
        if (event.product.listProductOption == null) {
          total = TotalState(
              (event.product.price + totalToppingPrice) * state.quantity);
        } else {
          total = TotalState(
              (event.product.listProductOption[value.value].price +
                      totalToppingPrice) *
                  state.quantity);
        }
      }
    }
    //chon size
    if (event is SelectAttributeValueEvent) {
      value = AttributeState(event.value);
      total = TotalState((event.product.listProductOption[value.value].price +
              totalToppingPrice) *
          state.quantity);
    }
    //chon topping
    if (event is CheckToppingEvent) {
      totalToppingPrice = 0;
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
      print(listToppingPrice.toString());
      for (int i = 0; i < listToppingPrice.length; i++) {
        totalToppingPrice += listToppingPrice[i];
      }
      print(totalToppingPrice);
      if (event.product.listProductOption == null) {
        total = TotalState(
            (event.product.price + totalToppingPrice) * state.quantity);
      } else {
        total = TotalState((event.product.listProductOption[value.value].price +
                totalToppingPrice) *
            state.quantity);
      }
    }
    //set lenght
    if (event is SetLengthListToppingEvent) {
      listToppingPrice.clear();
      listTopping.clear();
      lenght = ListToppingState(event.length);
      listCheck = List.generate(event.length, (int index) => false);
      listValue = ToppingState(listCheck, 0);
      total = TotalState(event.product.price);
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
          attributeId: event.productId,
          total: event.total));
    }
    if (event is UpdateCartEvent) {
      product = ProductCartState(event.product);
      print('update' + event.product.productName + ' to cart');
      ListProduct.listProduct[event.index] = (Cart(
        product: event.product,
        quantity: state.quantity,
        atrributeId: value.value,
        listTopping: listTopping,
        listToppingName: listToppingName,
        listToppingPrice: listToppingPrice,
        attributeId: event.attributeId,
        total: event.total,
      ));
    }
    if (event is CreateOrderEvent) {
      handleCreateOrder(event);
    }

    if (event is NoteOrderDetailEvent) {
      print(event.index.toString() + event.note);
      ListProduct.listProduct[event.index].note = event.note;
    }
    if (event is DeleteItemEvent) {
      print('Delete item ' + event.index.toString());
      ListProduct.listProduct.removeAt(event.index);
    }
    if (event is ToggleMethodEvent) {
      print(event.value);
      valueMethod = MethodState(event.value);
    }

    stateController.sink.add(state);
    valueController.sink.add(value);
    toppingController.sink.add(listValue);
    totalController.sink.add(total);
    lengthController.sink.add(lenght);
    productCartController.add(product);
    valueMethodController.sink.add(valueMethod);
  }

  Stream<AmountResponse> amount() {
    return Stream<AmountResponse>.fromFuture(
      _orderRepo.amountA(),
    );
  }

  handleCreateOrder(event) {
    Future.delayed(Duration(seconds: 1), () {
      CreateOrderEvent e = event as CreateOrderEvent;
      _orderRepo
          .order(
              e.receiverName,
              e.phoneNumber,
              e.amount,
              e.note,
              e.discountCodeId,
              e.address,
              e.orderType,
              e.branchId,
              e.paymentMethod)
          .then(
        (customerData) {
          SPref.instance.set(SPrefCache.KEY_LASTODER, customerData.toString());
          print('Dat hang thanh cong: ' + customerData.toString());
          processEventSink.add(OrderSuccessEvent(customerData));
        },
        onError: (e) {
          print(e);
          print("Fail----------------------------------");
          //btnSink.add(true); //Khi có kết quả thì enable nút sign-in trở lại
          loadingSink.add(false); // hide loading
          processEventSink
              .add(OrderFailEvent(e.toString())); // thông báo kết quả
        },
      );
    });
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
    valueMethodController.close();
  }
}
