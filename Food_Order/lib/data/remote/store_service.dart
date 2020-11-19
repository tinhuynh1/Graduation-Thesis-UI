import 'package:Food_Order/network/app_client.dart';
import 'package:dio/dio.dart';

class StoreService {
  Future<Response> getStoreList() {
    return AppClient.instance.dio.get(
      '/customer/branch/list',
    );
  }
}
