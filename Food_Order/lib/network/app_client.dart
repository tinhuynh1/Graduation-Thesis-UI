import 'package:Food_Order/data/spref/spref.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:dio/dio.dart';

class AppClient {
  static BaseOptions _options = new BaseOptions(
    baseUrl: "http://192.168.43.225:8080",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  static Dio _dio = Dio(_options);

  AppClient._internal() {
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options myOption) async {
      var token = await SPref.instance.get(SPrefCache.KEY_TOKEN);
      if (token != null) {
        myOption.headers["Authorization"] = "Bearer " + token;
      }

      return myOption;
    }));
    //_dio.interceptors.add(LogInterceptor(responseBody: true));
  }
  static final AppClient instance = AppClient._internal();

  Dio get dio => _dio;
}
