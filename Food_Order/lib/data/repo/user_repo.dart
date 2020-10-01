import 'dart:convert';
import 'dart:async';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/data/spref/spref.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:Food_Order/shared/model/user_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class UserRepo {
  UserService _userService;
  UserRepo({@required UserService userService}) : _userService = userService;
  Future<UserData> signIn(String phone) async {
    var c = Completer<UserData>();
    try {
      var response = await _userService.signIn(phone);
      var userData = UserData.fromJson(response.data['data']);
      if (userData != null) {
        SPref.instance.set(SPrefCache.KEY_TOKEN, userData.token);
        c.complete(userData);
      }
    } on DioError catch (e) {
      c.completeError('Dang nhap that bai');
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }
}
