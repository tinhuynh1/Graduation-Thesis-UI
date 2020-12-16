import 'package:Food_Order/shared/constant.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double r;
  final double width;
  final double heigh;
  const Avatar({Key key, this.r, this.width, this.heigh}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InfoUser.infoUser.avatar == ''
        ? ClipRRect(
            borderRadius: BorderRadius.circular(r),
            child: Image(
              image: AssetImage('assets/logo_intro.jpg'),
              width: width,
              height: heigh,
              fit: BoxFit.cover,
            ))
        : ClipRRect(
            borderRadius: BorderRadius.circular(r),
            child: Image(
              image: AssetImage(InfoUser.infoUser.avatar),
              width: width,
              height: heigh,
              fit: BoxFit.cover,
            ));
  }
}
