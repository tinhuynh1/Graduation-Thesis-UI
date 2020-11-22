import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/module/account/detail_info/deatail_user.dart';
import 'package:Food_Order/module/account/info_account_page.dart';
import 'package:Food_Order/module/signin/signin_page.dart';
import 'package:Food_Order/module/store/detail_branch_page.dart';
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
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0.5),
              padding: EdgeInsets.only(
                left: 20,
              ),
              color: Colors.white,
              height: 100,
              child: Row(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(70),
                      child: Image(
                        image: NetworkImage(
                            "https://s3.amazonaws.com/uifaces/faces/twitter/sulaqo/128.jpg"),
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "UserName",
                          style: TextStyle(color: Colors.black, fontSize: 15),
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
            Container(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailUserPage()),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailBranchPage()),
                      );
                    },
                    iconData: Icons.settings,
                    text: "Cài đặt",
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
