import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  const AccountButton({
    Key key,
    this.text,
    this.press,
    this.iconData,
  }) : super(key: key);
  final IconData iconData;
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.0,
      child: FlatButton(
          color: Colors.white,
          onPressed: press,
          child: Row(
            children: <Widget>[
              Icon(
                iconData,
                color: Colors.grey,
              ),
              SizedBox(
                width: 10,
              ),
              Text(text)
            ],
          )),
    );
  }
}
