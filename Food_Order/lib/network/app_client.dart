import 'package:dio/dio.dart';

class AppClient {
  static BaseOptions _options = new BaseOptions(
    baseUrl: "http://192.168.1.238:8080",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  static Dio _dio = Dio(_options);

  AppClient._internal() {
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }
  static final AppClient instance = AppClient._internal();

  Dio get dio => _dio;
}
