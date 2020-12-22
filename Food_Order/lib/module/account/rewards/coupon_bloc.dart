import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/base/base_bloc.dart';
import 'package:Food_Order/data/repo/user_repo.dart';
import 'package:Food_Order/event/quantity_event.dart';
import 'package:Food_Order/models/coupon/coupon.dart';
import 'package:Food_Order/models/coupon/coupon_details.dart';

import 'package:flutter/material.dart';

class CouponBloc extends BaseBloc with ChangeNotifier {
  final UserRepo _userRepo;

  static CouponBloc _instance;

  static CouponBloc getInstance({
    @required UserRepo userRepo,
  }) {
    if (_instance == null) {
      _instance = CouponBloc._internal(
        userRepo: userRepo,
      );
    }
    return _instance;
  }

  CouponBloc._internal({
    @required UserRepo userRepo,
  }) : _userRepo = userRepo;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case QuantityEvent:
        break;
    }
  }

  Stream<List<Coupon>> getListCouponUser() {
    return Stream<List<Coupon>>.fromFuture(_userRepo.getListCoupon());
  }

  Stream<CouponDetail> getCouponDetailUser(int id) {
    return Stream<CouponDetail>.fromFuture(_userRepo.getCouponDetail(id));
  }

  Stream<List<Coupon>> getMyCoupon() {
    return Stream<List<Coupon>>.fromFuture(_userRepo.getMyCoupon());
  }

  @override
  void dispose() {
    super.dispose();

    print("homepage close");
  }
}
