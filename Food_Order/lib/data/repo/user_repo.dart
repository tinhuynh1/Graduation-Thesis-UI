import 'dart:async';
import 'dart:convert';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/data/spref/spref.dart';
import 'package:Food_Order/models/customer.dart';
import 'package:Food_Order/models/sms.dart';
import 'package:Food_Order/models/user.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class UserRepo {
  UserService _userService;
  String _smsNonce;

  UserRepo({@required UserService userService}) : _userService = userService;
  Future<Sms> signIn(String phone) async {
    var c = Completer<Sms>();
    try {
      var response = await _userService.signIn(phone);
      var smsData = Sms.fromJson(response.data["data"]);
      _smsNonce = smsData.smsNonce;
      if (smsData != null) {
        SPref.instance.set(SPrefCache.KEY_SMSNONCE, smsData.smsNonce);
        SPref.instance.set(SPrefCache.KEY_PHONENUMBER, phone);
        c.complete(smsData);
      }
    } on DioError {
      c.completeError('Đăng nhập thất bại');
    } catch (e) {
      print(e.response.data);
      c.completeError(e);
    }
    //print(phone);
    return c.future;
  }

  Future<User> verifyOTP(String otp) async {
    var smsNonce = await SPref.instance.getValue(SPrefCache.KEY_SMSNONCE);
    var c = Completer<User>();
    try {
      var response = await _userService.verifyOTP(smsNonce, otp);
      var userData = User.fromJson(response.data["data"]);
      if (userData != null) {
        SPref.instance.set(SPrefCache.KEY_TOKEN, userData.token);
        SPref.instance.set(SPrefCache.KEY_SIGNUP, userData.isSignUp.toString());
        SPref.instance.set(SPrefCache.KEY_USER, jsonEncode(userData.customer));
        InfoUser.isLogin = true;
        InfoUser.infoUser = await Helper.getInfo();
        c.complete(userData);
      }
    } on DioError {
      c.completeError('User la customer');
    } catch (e) {
      print(e.response.data);
      c.completeError(e);
    }
    return c.future;
  }

  Future<Customer> createInfoUser(
      String customerName, String dateOfBirth) async {
    var c = Completer<Customer>();
    try {
      var response =
          await _userService.createInfoUser(customerName, dateOfBirth);
      var customerData = Customer.fromJson((response.data["data"]));
      if (customerData != null) {
        //SPref.instance.set(SPrefCache.KEY_USERNAME, customerData.customerName);
        SPref.instance.set(SPrefCache.KEY_USER, jsonEncode(customerData));
        InfoUser.isLogin = true;
        InfoUser.infoUser = await Helper.getInfo();
        c.complete(customerData);
      }
    } on DioError {
      c.completeError('Điền thông tin thất bại');
    } catch (e) {
      print(e.response.data);
      c.completeError(e);
    }
    return c.future;
  }

  Future<Customer> getUserInfo() async {
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
