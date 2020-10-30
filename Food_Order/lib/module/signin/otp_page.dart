import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/data/repo/user_repo.dart';
import 'package:Food_Order/data/spref/spref.dart';
import 'package:Food_Order/event/verify_otp_event.dart';
import 'package:Food_Order/event/verify_otp_fail_event.dart';
import 'package:Food_Order/event/verify_otp_success_event.dart';
import 'package:Food_Order/module/main/main_page.dart';
import 'package:Food_Order/module/signin/create_info_page.dart';
import 'package:Food_Order/module/signin/inputphone_page.dart';
import 'package:Food_Order/module/signin/signin_bloc.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:Food_Order/shared/widget/bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OTPPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [
        Provider.value(
          value: UserService(),
        ),
        ProxyProvider<UserService, UserRepo>(
          builder: (context, userService, previous) =>
              UserRepo(userService: userService),
        ),
      ],
      bloc: [],
      child: OTPFormWidget(),
    );
  }
}

class OTPFormWidget extends StatefulWidget {
  @override
  _OTPFormWidgetState createState() => _OTPFormWidgetState();
}

class _OTPFormWidgetState extends State<OTPFormWidget> {
  final TextEditingController _txtOTPController = TextEditingController();
  handleEvent(BaseEvent event) async {
    if (event is VerifyOTPSuccessEvent) {
      //Navigator.pushReplacementNamed(context, '/create-info');
      stick();
      return;
    }

    if (event is VerifyOTPFailEvent) {
      final snackBar = SnackBar(
        content: Text(event.errMessage),
        backgroundColor: Colors.red,
      );
      //Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignInBloc(userRepo: Provider.of(context)),
      child: Consumer<SignInBloc>(builder: (context, bloc, child) {
        return BlocListener<SignInBloc>(
          listener: handleEvent,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
            ),
            body: Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      "Nhập mã xác thực gồm 4 số đã được gửi đến số điện thoại để tiếp tục"),
                  _buildOTPField(bloc),
                  Spacer(),
                  Container(
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          height: 50.0,
                          width: double.infinity,
                          //height: getProportionateScreenWidth(56),
                          child: buildButton(bloc),
                        ),
                        _buildFooter(context),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildOTPField(SignInBloc bloc) {
    return TextFormField(
      controller: _txtOTPController,
      onChanged: (text) {
        bloc.optSink.add(text);
      },
      cursorColor: Colors.green[500],
      autofocus: true,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).unselectedWidgetColor),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        hintText: 'Mã xác thực',
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
            borderSide: BorderSide(color: Colors.grey[200])),
      ),
    );
  }

  Widget buildButton(SignInBloc bloc) {
    return StreamProvider<bool>.value(
      initialData: true,
      value: bloc.btnStream,
      child: Consumer<bool>(
        builder: (context, enable, child) => FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: enable
              ? () {
                  bloc.event.add(
                    VerifyOTPEvent(
                      otp: _txtOTPController.text,
                    ),
                  );
                }
              : null,
          child: Text(
            'Tiếp tục',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Colors.orange,
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InputPhone()),
          );
        },
        child: Text(
          'Bỏ qua',
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  void stick() async {
    var isLogged = await SPref.instance.getValue(SPrefCache.KEY_SIGNUP);
    print(isLogged);
    if (isLogged != "true") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CreateInfoPage()),
    );
  }
}
