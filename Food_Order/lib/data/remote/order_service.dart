import 'package:Food_Order/network/app_client.dart';
import 'package:dio/dio.dart';

const apiKey = "AIzaSyBJAGy5XN6RxaHa5E4btSBxsbveOK4dXZA";

class OrderService {
  Future<Response> order() {
    return AppClient.instance.dio.post('/customer/order/create', data: {
      'address': 'KTX khu A',
      'orderType': 'DELIVERY',
      "latitude": 10.8510224,
      "longitude": 106.7700655,
      "note": "khong co",
      "listOrderDetail": [
        {
          "productId": 12,
          "quantity": 2,
          "listToppingId": [1, 2, 3]
        }
      ]
    });
  }
}
