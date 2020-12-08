import 'dart:async';
import 'dart:ffi';

import 'package:Food_Order/data/remote/order_service.dart';
import 'package:Food_Order/data/repo/rest_error.dart';
import 'package:dio/dio.dart';

import 'package:flutter/widgets.dart';

class OrderRepo {
  OrderService _orderService;
  OrderRepo({@required OrderService orderService})
      : _orderService = orderService;
  Future<bool> order1() async {
    var c = Completer<bool>();
    print('------------------------');
    try {
      await _orderService.order();
      c.complete(true);
    } on DioError {
      c.completeError(RestError.fromData('Lỗi confirm đơn hàng'));
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }
}
