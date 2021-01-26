import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/data/repo/user_repo.dart';
import 'package:Food_Order/event/select_body_event.dart';
import 'package:Food_Order/module/home/home_bloc.dart';
import 'package:Food_Order/module/main/main_page.dart';
import 'package:Food_Order/shared/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(di: [
      Provider.value(
        value: UserService(),
      ),
      ProxyProvider<UserService, UserRepo>(
        update: (context, userService, previous) =>
            UserRepo(userService: userService),
      )
    ], bloc: [], child: ConfirmOrderScreen());
  }
}

class ConfirmOrderScreen extends StatefulWidget {
  @override
  _ConfirmOrderScreenState createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarCustom(
        text: 'Xác nhận đơn hàng #HD1112021',
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check_rounded,
              color: Colors.green,
              size: 140,
            ),
            Text(
              'Đơn hàng của bạn đã được xác nhận',
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text('Thông tin đơn hàng'),
                  Row(
                    children: <Widget>[
                      Icon(Icons.person),
                      Text('Người nhận: ')
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.phone),
                      Text('Số điện thoại:')
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.calendar_today),
                      Text('Ngày đặt hàng:')
                    ],
                  ),
                  Row(
                    children: <Widget>[Icon(Icons.code), Text('Mã đơn hàng:')],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.delivery_dining),
                      Text('Hình thức nhận hàng:')
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                    width: double.infinity,
                    child: FlatButton(
                      height: 60,
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            return MainPage();
                          },
                        ));
                        HomeBloc.getInstance(userRepo: Provider.of(context))
                            .event
                            .add(SelectBodyEvent(1));
                      },
                      child: Text(
                        'Tiếp tục mua hàng.',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
