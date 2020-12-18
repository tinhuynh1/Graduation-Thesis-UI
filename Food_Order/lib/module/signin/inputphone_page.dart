import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/data/repo/user_repo.dart';
import 'package:Food_Order/event/signin_fail_event.dart';
import 'package:Food_Order/event/signin_success_event.dart';
import 'package:Food_Order/event/singin_event.dart';
import 'package:Food_Order/module/main/main_page.dart';
import 'package:Food_Order/module/signin/otp_page.dart';
import 'package:Food_Order/module/signin/signin_bloc.dart';
import 'package:Food_Order/shared/widget/bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputPhone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [
        Provider.value(
          value: UserService(),
        ),
        ProxyProvider<UserService, UserRepo>(
          update: (context, userService, previous) =>
              UserRepo(userService: userService),
        ),
      ],
      bloc: [],
      child: SignInFormWidget(),
    );
  }
}

class SignInFormWidget extends StatefulWidget {
  @override
  _SignInFormWidgetState createState() => _SignInFormWidgetState();
}

class _SignInFormWidgetState extends State<SignInFormWidget> {
  final TextEditingController _txtPhoneController = TextEditingController();
  handleEvent(BaseEvent event) {
    if (event is SignInSuccessEvent) {
      // /Navigator.pushReplacementNamed(context, '/home');
      return;
    }

    if (event is SignInFailEvent) {
      final snackBar = SnackBar(
        content: Text(event.errMessage),
        backgroundColor: Colors.red,
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignInBloc(userRepo: Provider.of(context)),
      child: Consumer<SignInBloc>(
        builder: (context, bloc, child) {
          return BlocListener<SignInBloc>(
            listener: handleEvent,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
              ),
              body: Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Chào bạn,',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Nhập số điện thoại để tiếp tục',
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      height: 45.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          FlatButton(
                            height: double.infinity,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Colors.grey)),
                            color: Colors.white,
                            padding: EdgeInsets.all(8.0),
                            onPressed: () {},
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: Image.asset(
                                      "assets/resources_images_flag_vietnam.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                            child: _buildPhoneField(bloc),
                          )
                        ],
                      ),
                    ),
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
        },
      ),
    );
  }

  Widget _buildPhoneField(SignInBloc bloc) {
    return TextFormField(
      controller: _txtPhoneController,
      onChanged: (text) {
        bloc.phoneSink.add(text);
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
        hintText: 'Số điện thoại',
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
                    SignInEvent(
                      phone: parsePhoneNumber(_txtPhoneController.text),
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OTPPage()),
                  );
                }
              : null,
          child: Text(
            'Tiếp tục',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Colors.red,
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
            MaterialPageRoute(builder: (context) => MainPageScreen()),
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

  String parsePhoneNumber(String phoneNumber) {
    var countryNumber = phoneNumber.substring(1);
    print(countryNumber);
    return "+84" + countryNumber;
  }
}
