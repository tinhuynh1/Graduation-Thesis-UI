import 'package:Food_Order/network/app_client.dart';
import 'package:dio/dio.dart';

class RewardService {
  Future<Response> getListCategoryReward() {
    return AppClient.instance.dio.get(
      '/reward/category/list',
    );
  }

  Future<Response> getListDetailReward() {
    return AppClient.instance.dio.get(
      '/customer/reward/list',
    );
  }

  Future<Response> getDetailReward(int id) {
    return AppClient.instance.dio.get(
      '/reward/get/$id',
    );
  }

  Future<Response> exchange(int rewardId) {
    return AppClient.instance.dio
        .post('/customer/reward/exchange', data: {'rewardId': rewardId});
  }

  Future<Response> getMyCoupon() {
    return AppClient.instance.dio.get(
      '/customer/coupon/my',
    );
  }
}
