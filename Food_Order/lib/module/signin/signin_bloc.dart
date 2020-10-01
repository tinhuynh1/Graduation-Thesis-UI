import 'package:Food_Order/base/base_bloc.dart';
import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/data/repo/user_repo.dart';
import 'package:Food_Order/event/singin_event.dart';
import 'package:flutter/widgets.dart';

class SignInBloc extends BaseBloc {
  final UserRepo _userRepo;
  SignInBloc({@required UserRepo userRepo}) : _userRepo = userRepo;
  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case SignInEvent:
        handleSignIn(event);
        break;
    }
  }

  handleSignIn(event) {
    SignInEvent e = event as SignInEvent;
    _userRepo.signIn(e.phone).then((userData) {
      print(userData);
    }, onError: (e) {
      print(e);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
