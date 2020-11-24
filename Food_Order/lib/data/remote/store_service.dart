import 'package:Food_Order/network/app_client.dart';
import 'package:dio/dio.dart';

class StoreService {
  Future<Response> getStoreList() {
    return AppClient.instance.dio.post('/customer/branch/list',
        data: {'lat': 10.8699237, 'lng': 106.8016194});
  }
}
