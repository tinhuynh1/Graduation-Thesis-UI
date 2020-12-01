import 'package:Food_Order/models/cart.dart';
import 'package:Food_Order/models/customer.dart';
import 'package:Food_Order/models/product/product_details.dart';

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
}
