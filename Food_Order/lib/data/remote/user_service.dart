import 'package:Food_Order/network/app_client.dart';
import 'package:dio/dio.dart';

class UserService {
  Future<Response> signIn(String phone) {
    return AppClient.instance.dio.post('/user/sign-in', data: {
      'phone': phone,
    });
  }
}
