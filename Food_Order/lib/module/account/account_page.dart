import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/data/repo/user_repo.dart';
import 'package:Food_Order/data/spref/spref.dart';
import 'package:Food_Order/module/account/detail_info/deatail_user.dart';
import 'package:Food_Order/module/account/history_order_page.dart';
import 'package:Food_Order/module/account/rewards/rewards_info.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:Food_Order/shared/widget/button/account_button.dart';
import 'package:Food_Order/shared/widget/avatar.dart';
import 'package:Food_Order/shared/widget/button/log_out_button.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(di: [
      Provider.value(
        value: UserService(),
      ),
      ProxyProvider<UserService, UserRepo>(
        update: (context, userService, previous) =>
            UserRepo(userService: userService),
      ),
    ], bloc: [], child: AccountScreen());
  }
}

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0eff4),
      appBar: InfoUser.isLogin != true
          ? AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.red,
              title: Row(
                children: <Widget>[
                  Icon(Icons.person_rounded),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Đăng nhập'),
                ],
              ),
            )
          : null,
      body: Column(
        children: [
          InfoUser.isLogin == true
              ? GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return DetailUserPage();
                        },
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0.5),
                    padding: EdgeInsets.only(
                      left: 20,
                    ),
                    color: Colors.white,
                    height: 100,
                    child: Row(
                      children: <Widget>[
                        Avatar(
                          r: 70,
                          width: 60,
                          heigh: 60,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                (InfoUser.infoUser.customerName),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Khách hàng mới',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Container(),
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AccountButton(
                  page: RewardsPage(),
                  iconData: Icons.star,
                  text: "Pewpew Rewards",
                ),
                AccountButton(
                  page: DetailUserPage(),
                  iconData: Icons.person,
                  text: "Thông tin tài khoản",
                ),
                AccountButton(
                  iconData: Icons.history,
                  text: "Lịch sử",
                  page: HistoryOrderPage(),
                ),
                AccountButton(
                  iconData: Icons.help_center,
                  text: "Giúp đỡ",
                ),
                AccountButton(
                  iconData: Icons.settings,
                  text: "Cài đặt",
                ),
                InfoUser.isLogin == true
                    ? LogOutButton(
                        press: () {
                          InfoUser.isLogin = false;
                          SPref.instance.remove(SPrefCache.KEY_TOKEN);
                          setState(() {});

                          Navigator.pop(context, true);
                        },
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
