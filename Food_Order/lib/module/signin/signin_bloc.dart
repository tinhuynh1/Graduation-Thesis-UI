import 'dart:async';

import 'package:Food_Order/base/base_bloc.dart';
import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/data/repo/user_repo.dart';
import 'package:Food_Order/event/signin_fail_event.dart';
import 'package:Food_Order/event/signin_success_event.dart';
import 'package:Food_Order/event/singin_event.dart';
import 'package:Food_Order/event/verify_otp_event.dart';
import 'package:Food_Order/event/verify_otp_fail_event.dart';
import 'package:Food_Order/event/verify_otp_success_event.dart';
import 'package:Food_Order/models/user.dart';
import 'package:Food_Order/shared/widget/validation.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class SignInBloc extends BaseBloc with ChangeNotifier {
  final _phoneSubject = BehaviorSubject<String>();
  final _btnSubject = BehaviorSubject<bool>();
  final _userSubject = BehaviorSubject<User>();
  final _otpSubject = BehaviorSubject<String>();

  final UserRepo _userRepo;
  SignInBloc({@required UserRepo userRepo}) : _userRepo = userRepo;
  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case SignInEvent:
        handleSignIn(event);
        break;
      case VerifyOTPEvent:
        handleOTP(event);
        break;
    }
  }

  var phoneValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    if (Validation.isPhoneValid(phone)) {
      sink.add(null);
      return;
    }
    sink.add('Phone invalid');
  });
  Stream<String> get phoneStream =>
      _phoneSubject.stream.transform(phoneValidation);
  Sink<String> get phoneSink => _phoneSubject.sink;
  Sink<String> get optSink => _otpSubject.sink;
  Stream<bool> get btnStream => _btnSubject.stream;
  Sink<bool> get btnSink => _btnSubject.sink;

  handleSignIn(event) {
    btnSink.add(false); //Khi bắt đầu call api thì disable nút sign-in
    loadingSink.add(true); // show loading

    Future.delayed(Duration(seconds: 1), () {
      SignInEvent e = event as SignInEvent;
      _userRepo.signIn(e.phone).then(
        (smsData) {
          processEventSink.add(SignInSuccessEvent(smsData));
        },
        onError: (e) {
          print(e);
          btnSink.add(true); //Khi có kết quả thì enable nút sign-in trở lại
          loadingSink.add(false); // hide loading
          processEventSink
              .add(SignInFailEvent(e.toString())); // thông báo kết quả
        },
      );
    });
  }

  handleOTP(event) {
    btnSink.add(false); //Khi bắt đầu call api thì disable nút sign-in
    loadingSink.add(true); // show loading

    Future.delayed(Duration(seconds: 1), () {
      VerifyOTPEvent e = event as VerifyOTPEvent;
      _userRepo.verifyOTP(e.otp).then(
        (userData) {
          processEventSink.add(VerifyOTPSuccessEvent(userData));
        },
        onError: (e) {
          print(e);
          btnSink.add(true); //Khi có kết quả thì enable nút sign-in trở lại
          loadingSink.add(false); // hide loading
          processEventSink
              .add(VerifyOTPFailEvent(e.toString())); // thông báo kết quả
        },
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _phoneSubject.close();
    _btnSubject.close();
    _userSubject.close();
    _otpSubject.close();
    super.dispose();
  }
}
