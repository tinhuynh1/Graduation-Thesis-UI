import 'dart:ffi';

import 'package:Food_Order/models/customer.dart';

class User {
  bool isSignUp;
  Customer customer;
  String token;

  User({this.isSignUp, this.customer, this.token});

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
        isSignUp: map["isSignUp"],
        customer: Customer.fromJson(map["customer"]),
        token: map["token"]);
  }
  Map<String, dynamic> toJson() => {
        "isSignUp": isSignUp,
        "customer": customer.toJson(),
        "token": token,
      };
}
