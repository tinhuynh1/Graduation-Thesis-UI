import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  @override
  Size get preferredSize => const Size.fromHeight(56);
  const AppBarCustom({Key key, this.text}) : super(key: key);
  @override
  AppBar build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
          child: Container(
            color: Colors.grey,
            height: 1,
          ),
          preferredSize: const Size.fromHeight(56)),
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.black54,
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Text(
        text,
        style: TextStyle(
            color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 15),
      ),
    );
  }
}
