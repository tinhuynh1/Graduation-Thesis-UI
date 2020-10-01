import 'package:Food_Order/shared/style/btn_style.dart';
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;

  SocialButton({@required this.onPressed, this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 160,
      height: 40,
      child: RaisedButton(
        onPressed: onPressed,
        color: color,
        shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
        child: Text(
          text,
          style: BtnStyle.normal(),
        ),
      ),
    );
  }
}
