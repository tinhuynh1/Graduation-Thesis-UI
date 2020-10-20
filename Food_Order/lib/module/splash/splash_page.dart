import 'package:Food_Order/data/spref/spref.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _startApp();
  }

  _startApp() {
    Future.delayed(
      Duration(seconds: 3),
      () async {
        var token = await SPref.instance.get(SPrefCache.KEY_TOKEN);
        if (token != null) {
          Navigator.pushReplacementNamed(context, '/home');
          return;
        }
        Navigator.pushReplacementNamed(context, '/home');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(170.0),
          child: AppBar(
            flexibleSpace: Image(
              image: AssetImage('assets/resources_images_pattern.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        body: Center(
          child: Image.asset(
            'assets/logo.png',
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
