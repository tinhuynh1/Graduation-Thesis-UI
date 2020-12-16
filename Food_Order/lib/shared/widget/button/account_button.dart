import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  const AccountButton({
    Key key,
    this.text,
    this.iconData,
    this.page,
  }) : super(key: key);
  final IconData iconData;
  final String text;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.0,
      child: FlatButton(
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return page;
                },
              ),
            );
          },
          child: Row(
            children: <Widget>[
              Icon(
                iconData,
                color: Colors.grey,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: TextStyle(fontWeight: FontWeight.normal),
              )
            ],
          )),
    );
  }
}
