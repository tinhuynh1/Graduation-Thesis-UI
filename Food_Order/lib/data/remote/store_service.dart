import 'package:Food_Order/network/app_client.dart';
import 'package:dio/dio.dart';

class StoreService {
  Future<Response> getStoreList(double lat, double lng) {
    return AppClient.instance.dio
        .post('/customer/branch/list', data: {'lat': lat, 'lng': lng});
  }
}
