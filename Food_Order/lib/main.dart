import 'package:Food_Order/module/main/main_page.dart';
import 'package:Food_Order/module/signin/create_info_page.dart';
import 'package:Food_Order/module/splash/splash_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => SplashPage(),
        '/home': (context) => MainPageScreen(),
         '/create-info': (context) => CreateInfoPage(),
      },
    );
  }
}
