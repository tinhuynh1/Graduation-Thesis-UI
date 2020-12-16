import 'dart:async';
import 'dart:convert';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/data/repo/rest_error.dart';
import 'package:Food_Order/data/spref/spref.dart';
import 'package:Food_Order/models/coupon/coupon.dart';
import 'package:Food_Order/models/coupon/coupon_details.dart';
import 'package:Food_Order/models/customer.dart';
import 'package:Food_Order/models/label.dart';
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
        SPref.instance
            .set(SPrefCache.KEY_USER, jsonEncode(userData.customer.toJson()));
        InfoUser.isLogin = true;
        InfoUser.infoUser = await Helper.getInfo();

        c.complete(userData);
      }
    } on DioError {
      c.completeError('User la customer');
    } catch (e) {
      print("--------");
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
    print("called");
    var c = Completer<Customer>();
    try {
      var response = await _userService.getInfo();
      final Customer user = Customer.fromJson(response.data['data']);
      SPref.instance.set(SPrefCache.KEY_USER, jsonEncode(user));
      print(response.data['data']);
      InfoUser.infoUser = await Helper.getInfo();
      c.complete(user);
    } on DioError {
      print('Sai ');
    } catch (e) {
      print(e.response.data);
      c.completeError(e);
    }
    return c.future;
  }

  Future<List<Coupon>> getListCoupon() async {
    print("List coupon called");
    var c = Completer<List<Coupon>>();
    try {
      var response = await _userService.getListCoupon();
      var couponList = Coupon.parseCouponList(response.data);
      CouponList.listCoupon = couponList;
      c.complete(couponList);
    } on DioError {
      c.completeError(RestError.fromData('Không có dữ liệu'));
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<CouponDetail> getCouponDetail(int id) async {
    var c = Completer<CouponDetail>();
    try {
      var response = await _userService.getDetailCoupon(id);
      var detaiCoupon = CouponDetail.fromJson((response.data["data"]));
      c.complete(detaiCoupon);
    } on DioError {
      c.completeError(RestError.fromData('Không có dữ liệu'));
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<List<Label>> getListLabel() async {
    var c = Completer<List<Label>>();
    try {
      var response = await _userService.getListLabel();
      var labelList = Label.parseLabelList(response.data);
      c.complete(labelList);
    } on DioError {
      c.completeError(RestError.fromData('Không có dữ liệu'));
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }
}
