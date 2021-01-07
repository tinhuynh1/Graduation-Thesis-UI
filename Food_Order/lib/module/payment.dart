import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/data/repo/user_repo.dart';
import 'package:Food_Order/shared/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatelessWidget {
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
        )
      ],
      bloc: [],
      child: PaymentScreen(),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom(
          text: 'Thanh toán',
        ),
        backgroundColor: Color(0xfff0eff4),
        body: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                height: 56,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.money,
                    ),
                    Text('Thanh toán khi nhận hàng'),
                    Spacer(),
                    Icon(Icons.check_circle, color: Colors.red),
                  ],
                ),
              ),
              Divider(color: Colors.grey),
              Container(
                height: 56,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.money,
                    ),
                    Text('MoMo'),
                  ],
                ),
              ),
              Divider(color: Colors.grey)
            ],
          ),
        ));
  }
}
