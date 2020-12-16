import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/base/base_bloc.dart';
import 'package:Food_Order/data/repo/user_repo.dart';
import 'package:Food_Order/models/customer.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseBloc with ChangeNotifier {
  final UserRepo _userRepo;
  final _infoUser = BehaviorSubject<String>();
  final _isLogin = BehaviorSubject<bool>();

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
      // case GetInfoEvent:
      //   _handleShowInfo();
    }
  }

  Stream<Customer> getInfoUser() {
    print('call API get Info');
    return Stream<Customer>.fromFuture(_userRepo.getUserInfo());
  }

  Stream<String> get infoUserStream => _infoUser.stream;
  Sink<String> get infoUserSink => _infoUser.sink;

  Stream<bool> get isLoginStream => _isLogin.stream;
  Sink<bool> get isLoginSink => _isLogin.sink;

  @override
  void dispose() {
    super.dispose();
    _infoUser.close();
    _isLogin.close();
    print("homepage close");
  }
}
