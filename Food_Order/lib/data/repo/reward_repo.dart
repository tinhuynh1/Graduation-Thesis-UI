import 'dart:async';

import 'package:Food_Order/data/remote/reward_service.dart';
import 'package:Food_Order/data/repo/rest_error.dart';
import 'package:Food_Order/models/category_rewards.dart';
import 'package:Food_Order/models/detail_reward.dart';
import 'package:Food_Order/models/exchange_response.dart';
import 'package:Food_Order/models/reward.dart';
import 'package:dio/dio.dart';

import 'package:flutter/widgets.dart';

class RewardRepo {
  RewardService _rewardService;
  RewardRepo({@required RewardService rewardService})
      : _rewardService = rewardService;
  Future<List<CategoryReeards>> getListCategoryRewards() async {
    var c = Completer<List<CategoryReeards>>();
    try {
      var response = await _rewardService.getListCategoryReward();
      var listRewardCategory =
          CategoryReeards.parseRewardCategoryList(response.data);
      print(response.toString());
      c.complete(listRewardCategory);
    } on DioError {
      c.completeError(RestError.fromData('Loi list reward category'));
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<List<Rewards>> getListRewards() async {
    var c = Completer<List<Rewards>>();
    try {
      var response = await _rewardService.getListDetailReward();
      var listReward = Rewards.parseRewardList(response.data);
      print(response.toString());
      c.complete(listReward);
    } on DioError {
      c.completeError(RestError.fromData('Loi list reward '));
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<DetailReward> getDetailReward(int id) async {
    var c = Completer<DetailReward>();
    try {
      var response = await _rewardService.getDetailReward(id);
      var detaiCoupon = DetailReward.fromJson((response.data["data"]));
      c.complete(detaiCoupon);
    } on DioError {
      c.completeError(RestError.fromData('Không có dữ liệu'));
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<ExchangeResponse> exchange(int rewardId) async {
    var c = Completer<ExchangeResponse>();
    try {
      var response = await _rewardService.exchange(rewardId);
      var exchangeResponse = ExchangeResponse.fromJson(response.data);

      c.complete(exchangeResponse);
    } on DioError {
      c.completeError('Đã có lỗi xảy ra');
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<List<Rewards>> getMyCoupon() async {
    var c = Completer<List<Rewards>>();
    try {
      var response = await _rewardService.getListDetailReward();
      var listReward = Rewards.parseRewardList(response.data);
      print(response.toString());
      c.complete(listReward);
    } on DioError {
      c.completeError(RestError.fromData('Loi list reward '));
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }
}
