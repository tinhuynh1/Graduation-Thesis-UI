import 'dart:convert';

import 'package:Food_Order/network/app_client.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:dio/dio.dart';

class OrderService {
  Future<Response> order(
      String receiverName,
      String phoneNumber,
      int amount,
      String note,
      int discountCodeId,
      String address,
      String orderType,
      String branchId,
      String paymentMethod) {
    return AppClient.instance.dio.post('/customer/order/create', data: {
      "discounCodeId": discountCodeId,
      "address": address,
      "orderType": orderType,
      "latitude": Address.lat,
      "longitude": Address.lng,
      "branchId": branchId,
      "paymentMethod": paymentMethod,
      "note": note,
      "amount": amount,
      "shipFee": 0,
      "receiverName": receiverName,
      "phoneNumber": phoneNumber,
      "listOrderDetail": jsonDecode(
          jsonEncode(ListProduct.listProduct.map((e) => e.toJson()).toList()))
    });
  }

  Future<Response> amount() {
    return AppClient.instance.dio.post('/customer/amount', data: {
      "discountCodeId": CouponApply.couponId,
      "listCartDetail": jsonDecode(
          jsonEncode(ListProduct.listProduct.map((e) => e.toJson()).toList()))
    });
  }
}
