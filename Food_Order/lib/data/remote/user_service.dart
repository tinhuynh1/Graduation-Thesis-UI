import 'package:Food_Order/network/app_client.dart';
import 'package:dio/dio.dart';

class UserService {
  Future<Response> signIn(String phone) {
    return AppClient.instance.dio.post('/customer/otp', data: {
      'phoneNumber': phone,
    });
  }

  Future<Response> verifyOTP(String smsNonce, String otp) {
    return AppClient.instance.dio.post('/customer/signin', data: {
      'smsNonce': smsNonce,
      'otp': otp,
    });
  }

  Future<Response> createInfoUser(String customerName, String dateOfBirth) {
    return AppClient.instance.dio.post('/customer/create', data: {
      'customerName': customerName,
      'dateOfBirth': dateOfBirth,
    });
  }

  Future<Response> getInfo() {
    return AppClient.instance.dio.get(
      '/customer/info',
    );
  }

  Future<Response> getListCoupon() {
    return AppClient.instance.dio.get(
      '/customer/coupon/list',
    );
  }

  Future<Response> getDetailCoupon(int id) {
    return AppClient.instance.dio.get(
      '/customer/coupon/get/$id',
    );
  }

  Future<Response> getListLabel() {
    return AppClient.instance.dio.get(
      '/customer/label/list',
    );
  }
}
