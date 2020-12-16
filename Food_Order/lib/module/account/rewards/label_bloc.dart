import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/base/base_bloc.dart';
import 'package:Food_Order/data/repo/user_repo.dart';
import 'package:Food_Order/event/quantity_event.dart';
import 'package:Food_Order/models/coupon/coupon.dart';
import 'package:Food_Order/models/coupon/coupon_details.dart';
import 'package:Food_Order/models/label.dart';

import 'package:flutter/material.dart';

class LabelBloc extends BaseBloc with ChangeNotifier {
  final UserRepo _userRepo;

  static LabelBloc _instance;

  static LabelBloc getInstance({
    @required UserRepo userRepo,
  }) {
    if (_instance == null) {
      _instance = LabelBloc._internal(
        userRepo: userRepo,
      );
    }
    return _instance;
  }

  LabelBloc._internal({
    @required UserRepo userRepo,
  }) : _userRepo = userRepo;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case QuantityEvent:
        break;
    }
  }

  Stream<List<Label>> getListLabel() {
    return Stream<List<Label>>.fromFuture(_userRepo.getListLabel());
  }

  @override
  void dispose() {
    super.dispose();

    print("homepage close");
  }
}
