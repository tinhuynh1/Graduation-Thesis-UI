import 'dart:async';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/data/spref/spref.dart';
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
        SPref.instance.setBool(SPrefCache.KEY_SIGNUP, userData.isSignUp);
        c.complete(userData);
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
}
