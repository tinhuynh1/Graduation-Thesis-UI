import 'dart:async';

import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/base/base_bloc.dart';
import 'package:Food_Order/data/repo/user_repo.dart';
import 'package:Food_Order/data/state/tab_index_state.dart';
import 'package:Food_Order/event/select_body_event.dart';
import 'package:Food_Order/models/customer.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseBloc with ChangeNotifier {
  final UserRepo _userRepo;
  var index = TabIndexState(0);
  final _infoUser = BehaviorSubject<String>();
  final _isLogin = BehaviorSubject<bool>();
  final _index = BehaviorSubject<int>();
  final indexController = StreamController<TabIndexState>.broadcast();

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
      case SelectBodyEvent:
        handleSelectBody(event);
    }
  }

  handleSelectBody(event) {
    SelectBodyEvent e = event as SelectBodyEvent;
    print(e.index.toString());
    indexSink.add(e.index);
    index = TabIndexState(e.index);
    indexController.sink.add(index);
  }

  Stream<Customer> getInfoUser() {
    print('call API get Info');
    return Stream<Customer>.fromFuture(_userRepo.getUserInfo());
  }

  Stream<bool> sendFBToken(String token) {
    print('call API sendFBToken');
    return Stream<bool>.fromFuture(_userRepo.sendFBToken(token));
  }

  Stream<int> get indexStream => _index.stream;
  Sink<int> get indexSink => _index.sink;

  Stream<String> get infoUserStream => _infoUser.stream;
  Sink<String> get infoUserSink => _infoUser.sink;

  Stream<bool> get isLoginStream => _isLogin.stream;
  Sink<bool> get isLoginSink => _isLogin.sink;

  @override
  void dispose() {
    super.dispose();
    _infoUser.close();
    _isLogin.close();
    _index.close();
    indexController.close();
    print("homepage close");
  }
}
