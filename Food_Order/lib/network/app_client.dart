import 'package:Food_Order/data/spref/spref.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:dio/dio.dart';

class AppClient {
  static BaseOptions _options = new BaseOptions(
    //baseUrl: "http://172.16.6.129:8080",
    baseUrl: "http://ee7ed42eee4c.ngrok.io",
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
  }
  static final AppClient instance = AppClient._internal();

  Dio get dio => _dio;
}
