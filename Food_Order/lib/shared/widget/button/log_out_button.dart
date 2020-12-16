import 'package:flutter/material.dart';

class LogOutButton extends StatelessWidget {
  final Function press;

  const LogOutButton({Key key, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                    onPressed: press,
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
            child: Text('Đăng xuất')));
  }
}
