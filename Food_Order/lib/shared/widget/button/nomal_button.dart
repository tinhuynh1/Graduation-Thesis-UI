import 'package:Food_Order/shared/style/btn_style.dart';
import 'package:flutter/material.dart';

class NomalButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  NomalButton({@required this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle(color: Colors.red),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(color: Colors.red),
      ),
    );
  }
}
