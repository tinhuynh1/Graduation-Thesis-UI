import 'package:Food_Order/data/spref/spref.dart';
import 'package:Food_Order/module/main/main_page.dart';
import 'package:Food_Order/module/signin/create_info_page.dart';
import 'package:Food_Order/module/splash/splash_page.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
  if (await SPref.instance.getValue(SPrefCache.KEY_TOKEN) != null) {
    InfoUser.isLogin = true;
    InfoUser.infoUser = await Helper.getInfo();
    Product.category = await Helper.getListParentCategory();
  } else {
    InfoUser.isLogin = false;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        //brightness: Brightness.light,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => SplashPage(),
        '/home': (context) => MainPageScreen(),
        '/create-info': (context) => CreateInfoPage(),
      },
    );
  }
}
