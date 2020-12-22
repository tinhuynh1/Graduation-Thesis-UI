import 'dart:convert';

import 'package:Food_Order/network/app_client.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:dio/dio.dart';

class OrderService {
  Future<Response> order() {
    return AppClient.instance.dio.post('/customer/order/create', data: {
      'address': Address.detailsAdr,
      'orderType': 'DELIVERY',
      "latitude": Address.lat,
      "longitude": Address.lng,
      "note": "khong co",
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
