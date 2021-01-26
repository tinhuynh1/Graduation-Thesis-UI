import 'dart:async';

import 'package:Food_Order/data/remote/order_service.dart';
import 'package:Food_Order/data/repo/rest_error.dart';
import 'package:Food_Order/models/amount_response.dart';
import 'package:dio/dio.dart';

import 'package:flutter/widgets.dart';

class OrderRepo {
  OrderService _orderService;
  OrderRepo({@required OrderService orderService})
      : _orderService = orderService;
  Future<int> order(
      String receiverName,
      String phoneNumber,
      int amount,
      String note,
      int discountCodeId,
      String address,
      String orderType,
      String branchId,
      String paymentMethod) async {
    var c = Completer<int>();
    try {
      var response = await _orderService.order(
          receiverName,
          phoneNumber,
          amount,
          note,
          discountCodeId,
          address,
          orderType,
          branchId,
          paymentMethod);
      int orderId = response.data['data']['orderId'];
      print(response.toString());
      c.complete(orderId);
    } on DioError {
      c.completeError('Đã có lỗi xảy ra!  Thử lại sau');
    } catch (e) {
      c.completeError('loi roi!!!!');
    }
    return c.future;
  }

  Future<bool> amount() async {
    var c = Completer<bool>();
    try {
      var response = await _orderService.amount();
      print(response.toString());
      c.complete(true);
    } on DioError {
      c.completeError(RestError.fromData('Lỗi amount đơn hàng '));
    } catch (e) {
      print('loi roi abe oi');
      c.completeError(e);
    }
    return c.future;
  }

  Future<AmountResponse> amountA() async {
    var c = Completer<AmountResponse>();
    try {
      var response = await _orderService.amount();
      var amountResponse = AmountResponse.fromJson(response.data['data']);
      print(response.toString());
      c.complete(amountResponse);
    } on DioError {
      c.completeError(RestError.fromData('Lỗi amount đơn hàng '));
    } catch (e) {
      print('loi roi abe oi');
      c.completeError(e);
    }
    return c.future;
  }
}
