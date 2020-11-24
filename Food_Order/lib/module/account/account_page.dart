import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/module/account/detail_info/deatail_user.dart';
import 'package:Food_Order/module/account/rewards/rewards_info.dart';
import 'package:Food_Order/module/signin/signin_page.dart';
import 'package:Food_Order/shared/widget/account_button.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
                        image: AssetImage('assets/logo_intro.jpg'),
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
                          "Huynh Tin",
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AccountButton(
                    press: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return RewardsPage();
                          },
                        ),
                      );
                    },
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
                      _getCurrentLocation();
                    },
                    iconData: Icons.settings,
                    text: "Cài đặt",
                  ),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Xác nhận'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text('Bạn có chắc chắn muốn đăng xuất?'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'Đồng ý'.toUpperCase(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Hủy bỏ'.toUpperCase()),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                          padding: EdgeInsets.only(left: 15, top: 15),
                          child: Text('Đăng xuất'))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
