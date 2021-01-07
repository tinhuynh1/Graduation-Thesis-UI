import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/module/account/detail_info/edit_info.dart';
import 'package:Food_Order/module/signin/signin_page.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:Food_Order/shared/widget/appbar.dart';
import 'package:Food_Order/shared/widget/avatar.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DetailUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('vi');
    return PageContainer(
      di: [],
      bloc: [],
      child: Scaffold(
          backgroundColor: Color(0xfff0eff4),
          body: InfoUser.isLogin
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height / 3.8,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 340),
                              child: RawMaterialButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                constraints: BoxConstraints(),
                                fillColor: Colors.black54,
                                child: Icon(
                                  Icons.close,
                                  size: 30.0,
                                  color: Colors.white,
                                ),
                                shape: CircleBorder(),
                              ),
                            ),
                            Avatar(r: 70, width: 80, heigh: 80),
                            Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 10),
                              child: Text(InfoUser.infoUser.customerName),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.loyalty,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Thành viên mới')
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        children: <Widget>[
                          Text('Thông tin cá nhân'),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return EditInfoPage();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              'Đổi',
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height / 16,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Tên',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(InfoUser.infoUser.customerName),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height / 16,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Sinh nhật',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(DateFormat.yMd('vi')
                                    .format(InfoUser.infoUser.dateOfBirth))
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height / 16,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Số điện thoại',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(InfoUser.infoUser.phoneNumber),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : Scaffold(
                  appBar: AppBarCustom(
                    text: 'Thông tin thành viên',
                  ),
                  body: Column(
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/forbiden.png'),
                        fit: BoxFit.cover,
                      ),
                      Text('Bạn chưa đăng nhập'),
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 18,
                        margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return SignInPage();
                                },
                              ),
                            );
                          },
                          child: Text(
                            'Đăng nhập để tiếp tục',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                )),
    );
  }
}
