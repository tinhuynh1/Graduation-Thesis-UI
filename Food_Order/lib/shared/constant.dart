import 'dart:async';
import 'dart:convert';

import 'package:Food_Order/data/spref/spref.dart';
import 'package:Food_Order/models/cart.dart';
import 'package:Food_Order/models/customer.dart';

class SPrefCache {
  static const KEY_TOKEN = 'key_token';
  static const KEY_USER = 'key_user';
  static const KEY_SMSNONCE = 'key_sms_nonce';
  static const KEY_PHONENUMBER = 'key_phone_number';
  static const KEY_SIGNUP = "key_sign_up";
  static const KEY_USERNAME = 'key_user_name';
  static const KEY_CUSTOMER = 'key_customer';
  static const KEY_PRODUCT = 'key_product';
}

class ListProduct {
  static var listProduct = new List<Cart>();
}

class InfoUser {
  static Customer infoUser;
  static bool isLogin;
  // static String name;
}

class Helper {
  static Future<Customer> getInfo() async {
    var c = Completer<Customer>();
    Map<String, dynamic> userMap;
    try {
      var userStr = await SPref.instance.getValue(SPrefCache.KEY_USER);
      print('userStr is' + userStr);
      if (userStr != null) {
        userMap = jsonDecode(userStr) as Map<String, dynamic>;
      }

      if (userMap != null) {
        final Customer user = Customer.fromJson(userMap);
        print(user);
        print('---------------');
        InfoUser.infoUser = user;
        c.complete(user);
      }
    } catch (e) {
      print(e.response.data);
      c.completeError(e);
    }
    return c.future;
  }
}
