import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/module/account/info_account_page.dart';
import 'package:Food_Order/module/signin/signin_page.dart';
import 'package:Food_Order/shared/widget/account_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [
        Provider.value(
          value: UserService(),
        ),
      ],
      bloc: [],
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: Colors.orange,
            automaticallyImplyLeading: false,

            //elevation: 20.0,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Đăng nhập",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Column(
            children: <Widget>[
              AccountButton(
                press: () {},
                iconData: Icons.star,
                text: "Pewpew Rewards",
              ),
              AccountButton(
                press: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return InfoAccountPage();
                      },
                    ),
                  );
                },
                iconData: Icons.person,
                text: "Thông tin tài khoản",
              ),
              AccountButton(
                press: () {},
                iconData: Icons.music_note,
                text: "Nhạc đang phát",
              ),
              AccountButton(
                press: () {},
                iconData: Icons.history,
                text: "Lịch sử",
              ),
              AccountButton(
                press: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return SignInPage();
                      },
                    ),
                  );
                },
                iconData: Icons.help_center,
                text: "Giúp đỡ",
              ),
              AccountButton(
                press: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        //return SettingPage();
                      },
                    ),
                  );
                },
                iconData: Icons.settings,
                text: "Cài đặt",
              )
            ],
          ),
        ),
      ),
    );
  }
}
