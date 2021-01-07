import 'package:Food_Order/network/app_client.dart';
import 'package:dio/dio.dart';

class ProductService {
  Future<Response> getParentCategoryList() {
    return AppClient.instance.dio.get(
      '/customer/product/get',
    );
  }

  Future<Response> getDetailsProductById(int id) {
    return AppClient.instance.dio.get(
      '/customer/product/get/$id',
    );
  }

  Future<Response> getComments(int id) {
    return AppClient.instance.dio.get(
      '/customer/comment/$id',
    );
  }

  Future<Response> commentProdcuct(int productId, String content) {
    return AppClient.instance.dio.post('/customer/comment',
        data: {"productId": productId, "content": content});
  }

  Future<Response> getAllProduct() {
    return AppClient.instance.dio.get(
      '/customer/product/all',
    );
  }
}
