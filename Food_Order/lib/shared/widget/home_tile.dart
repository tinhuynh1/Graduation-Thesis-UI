import 'package:flutter/material.dart';

class HomeTitle extends StatefulWidget {
  final String text;
  HomeTitle({@required this.text});
  @override
  _HomeTitleState createState() => _HomeTitleState();
}

class _HomeTitleState extends State<HomeTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 10.0, 0, 0),
      child: Text(
        widget.text,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
