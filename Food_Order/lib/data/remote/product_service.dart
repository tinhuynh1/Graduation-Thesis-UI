import 'package:Food_Order/network/app_client.dart';
import 'package:dio/dio.dart';

class ProductService {
  Future<Response> getProductList() {
    return AppClient.instance.dio.get(
      '/product/list',
    );
  }
}
