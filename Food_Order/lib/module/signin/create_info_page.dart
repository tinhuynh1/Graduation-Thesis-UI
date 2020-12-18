import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/data/repo/user_repo.dart';
import 'package:Food_Order/event/create_info_user_event.dart';
import 'package:Food_Order/event/create_info_user_fail_event.dart';
import 'package:Food_Order/event/create_info_user_success_event.dart';
import 'package:Food_Order/module/signin/signin_bloc.dart';
import 'package:Food_Order/shared/widget/bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [
        Provider.value(
          value: UserService(),
        ),
        ProxyProvider<UserService, UserRepo>(
            update: (context, userService, previous) =>
                UserRepo(userService: userService)),
      ],
      bloc: [],
      child: CreateInfoFormWidget(),
    );
  }
}

class CreateInfoFormWidget extends StatefulWidget {
  @override
  _CreateInfoFormWidgetState createState() => _CreateInfoFormWidgetState();
}

class _CreateInfoFormWidgetState extends State<CreateInfoFormWidget> {
  final TextEditingController _txtFullNameController = TextEditingController();
  final TextEditingController _txtDateOfBirthController =
      TextEditingController();

  DateTime _dateTime;
  handleEvent(BaseEvent event) async {
    if (event is CreateInfoUserSuccessEvent) {
      Navigator.pushReplacementNamed(context, '/home');
      return;
    }

    if (event is CreateInfoUserFailEvent) {
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
                    'Chào bạn,',
                    style: TextStyle(fontSize: 25.0),
                  ),
                  Text(
                    'Họ và tên của bạn là?',
                  ),
                  _buildFullNameField(bloc),
                  Text(
                    'Ngày sinh của bạn là?',
                  ),
                  _buildDateOfBirthField(bloc),
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

  Widget _buildFullNameField(SignInBloc bloc) {
    return TextFormField(
      controller: _txtFullNameController,
      onChanged: (text) {
        bloc.fullNameCustomerSink.add(text);
      },
      cursorColor: Colors.green[500],
      autofocus: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).unselectedWidgetColor),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        hintText: 'Họ và tên',
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
            borderSide: BorderSide(color: Colors.grey[200])),
      ),
    );
  }

  Widget _buildDateOfBirthField(SignInBloc bloc) {
    return TextFormField(
      controller: _txtDateOfBirthController,
      onChanged: (text) {
        bloc.dateOfBirthSink.add(text);
      },
      cursorColor: Colors.green[500],
      autofocus: true,
      readOnly: true,
      onTap: () {
        showDatePicker(
                context: context,
                initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                firstDate: DateTime(1960),
                lastDate: DateTime(2021))
            .then((date) {
          setState(() {
            initializeDateFormatting('vi');
            _dateTime = date;
            _txtDateOfBirthController.text =
                DateFormat.yMd('vi').format(_dateTime);
          });
        });
      },
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).unselectedWidgetColor),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        hintText: 'DD/MM/YYYY',
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
          height: 60,
          minWidth: double.infinity,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: enable
              ? () {
                  bloc.event.add(
                    CreateInfoUserEvent(
                      customerName: _txtFullNameController.text,
                      dateOfBirth: _dateTime.toUtc().toIso8601String(),
                    ),
                  );
                }
              : null,
          child: Text(
            'Hoàn tất',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Colors.red,
        ),
      ),
    );
  }
}
