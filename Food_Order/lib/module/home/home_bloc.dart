import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/base/base_bloc.dart';
import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/data/repo/user_repo.dart';
import 'package:Food_Order/models/customer.dart';
import 'package:flutter/material.dart';

class HomeBloc extends BaseBloc with ChangeNotifier {
  final UserRepo _userRepo;

  static HomeBloc _instance;

  static HomeBloc getInstance({
    @required UserRepo userRepo,
  }) {
    if (_instance == null) {
      _instance = HomeBloc._internal(
        userRepo: userRepo,
      );
    }
    return _instance;
  }

  HomeBloc._internal({
    @required UserRepo userRepo,
  }) : _userRepo = userRepo;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
    }
  }

  Stream<Customer> getInfoUser() {
    return Stream<Customer>.fromFuture(
      _userRepo.getInfo(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print("homepage close");
  }
}
