import 'package:Food_Order/shared/style/btn_style.dart';
import 'package:flutter/material.dart';

import '../app_color.dart';

class NormalButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  NormalButton({@required this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 200,
      height: 45,
      child: RaisedButton(
        onPressed: onPressed,
        color: Colors.red,
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
