import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/base/base_bloc.dart';
import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/data/repo/user_repo.dart';
import 'package:Food_Order/event/getInfoEvent.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseBloc with ChangeNotifier {
  final UserRepo _userRepo;
  final _infoUser = BehaviorSubject<String>();

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
      case GetInfoEvent:
        _handleShowInfo();
    }
  }

  _handleShowInfo() {
    print(_userRepo.getData());
    infoUserSink.add(_userRepo.getData());
  }

  Stream<String> get infoUserStream => _infoUser.stream;
  Sink<String> get infoUserSink => _infoUser.sink;
  @override
  void dispose() {
    super.dispose();
    _infoUser.close();
    print("homepage close");
  }
}
