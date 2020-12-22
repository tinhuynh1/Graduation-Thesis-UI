import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/base/base_bloc.dart';
import 'package:Food_Order/data/repo/reward_repo.dart';
import 'package:Food_Order/event/exchange/exchange_event.dart';
import 'package:Food_Order/event/exchange/exchange_fail_event.dart';
import 'package:Food_Order/event/exchange/exchange_successfully_event.dart';
import 'package:Food_Order/models/category_rewards.dart';
import 'package:Food_Order/models/detail_reward.dart';
import 'package:Food_Order/models/reward.dart';

import 'package:flutter/material.dart';

class RewardBloc extends BaseBloc with ChangeNotifier {
  final RewardRepo _rewardRepo;

  static RewardBloc _instance;

  // static RewardBloc getInstance({
  //   @required RewardRepo rewardRepo,
  // }) {
  //   if (_instance == null) {
  //     _instance = RewardBloc._internal(
  //       rewardRepo: rewardRepo,
  //     );
  //   }
  //   return _instance;
  // }

  RewardBloc({
    @required RewardRepo rewardRepo,
  }) : _rewardRepo = rewardRepo;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case ExchangeEvent:
        handleExchange(event);
        break;
    }
  }

  handleExchange(event) {
    ExchangeEvent e = event as ExchangeEvent;
    print('Exchange: ' + e.rewardId.toString());
    _rewardRepo.exchange(e.rewardId).then((data) {
      if (data.code == 200) {
        processEventSink.add(
            ExchangeSuccessEvent('Đổi quà thành công')); // thông báo kết quả
      } else {
        processEventSink.add(ExchangeFailEvent(data.message));
      }
    }, onError: (e) {
      processEventSink.add(ExchangeFailEvent(e.toString()));
    });
  }

  Stream<List<CategoryReeards>> getListCategoryReward() {
    return Stream<List<CategoryReeards>>.fromFuture(
        _rewardRepo.getListCategoryRewards());
  }

  Stream<List<Rewards>> getListReward() {
    return Stream<List<Rewards>>.fromFuture(_rewardRepo.getListRewards());
  }

  Stream<DetailReward> getDetailReward(int id) {
    return Stream<DetailReward>.fromFuture(_rewardRepo.getDetailReward(id));
  }

  @override
  void dispose() {
    super.dispose();

    print("homepage close");
  }
}
