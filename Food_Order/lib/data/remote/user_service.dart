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
}
