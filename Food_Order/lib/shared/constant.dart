import 'dart:async';
import 'dart:convert';

import 'package:Food_Order/data/spref/spref.dart';
import 'package:Food_Order/models/cart.dart';
import 'package:Food_Order/models/customer.dart';
import 'package:Food_Order/models/location/location.dart';
import 'package:Food_Order/models/product/parent_category.dart';
import 'package:Food_Order/models/store.dart';

class SPrefCache {
  static const KEY_TOKEN = 'key_token';
  static const KEY_USER = 'key_user';
  static const KEY_SMSNONCE = 'key_sms_nonce';
  static const KEY_PHONENUMBER = 'key_phone_number';
  static const KEY_SIGNUP = "key_sign_up";
  static const KEY_USERNAME = 'key_user_name';
  static const KEY_CUSTOMER = 'key_customer';
  static const KEY_PRODUCT = 'key_product';
  static const KEY_FBTOKEN = "key_fbtoken";
  static const KEY_CURRENTLOACTION = "key_location";
  static const KEY_LASTODER = 'key_last_order';
}

class ListProduct {
  static var listProduct = new List<Cart>();
}

class InfoUser {
  static Customer infoUser;
  static bool isLogin;
  // static String name;
}

class Product {
  static List<ParentCategory> category;
}

class CouponApply {
  static int couponId;
}

class CurrentLocation {
  static Location location;
}

class Branchs {
  static List<Store> listStore;
}

class Address {
  static String adr;
  static double lat;
  static double lng;
  static String detailsAdr;
}

class Helper {
  static Future<Customer> getInfo() async {
    var c = Completer<Customer>();
    Map<String, dynamic> userMap;
    try {
      var userStr = await SPref.instance.getValue(SPrefCache.KEY_USER);
      if (userStr != null) {
        userMap = jsonDecode(userStr) as Map<String, dynamic>;
      }

      if (userMap != null) {
        final Customer user = Customer.fromJson(userMap);
        print(user);
        InfoUser.infoUser = user;
        c.complete(user);
      }
    } catch (e) {
      print(e.response.data);
      c.completeError(e);
    }
    return c.future;
  }

  static Future<List<ParentCategory>> getListParentCategory() async {
    var c = Completer<List<ParentCategory>>();
    Map<String, dynamic> parentCategoryMap;
    try {
      var userStr = await SPref.instance.getValue(SPrefCache.KEY_PRODUCT);
      if (userStr != null) {
        parentCategoryMap = jsonDecode(userStr) as Map<String, dynamic>;
      }
      if (parentCategoryMap != null) {
        final List<ParentCategory> user =
            ParentCategory.parseParentCategoryList(parentCategoryMap);
        Product.category = user;
        print(user.length);

        c.complete(user);
      }
    } catch (e) {
      print('------------------');
      print(e.response.data);
      c.completeError(e);
    }
    return c.future;
  }
}
