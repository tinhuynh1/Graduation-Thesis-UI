import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/product_service.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/data/repo/product_repo.dart';
import 'package:Food_Order/data/repo/rest_error.dart';
import 'package:Food_Order/data/repo/user_repo.dart';
import 'package:Food_Order/data/spref/spref.dart';
import 'package:Food_Order/models/message.dart';
import 'package:Food_Order/models/product/parent_category.dart';
import 'package:Food_Order/module/home/home_bloc.dart';
import 'package:Food_Order/module/order/product_bloc.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [
        Provider.value(
          value: ProductService(),
        ),
        ProxyProvider<ProductService, ProductRepo>(
          update: (context, productService, previous) =>
              ProductRepo(productService: productService),
        ),
        Provider.value(
          value: UserService(),
        ),
        ProxyProvider<UserService, UserRepo>(
          update: (context, userService, previous) =>
              UserRepo(userService: userService),
        ),
      ],
      bloc: [],
      child: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseCloudMessaging_Listeners();

    _startApp();
  }

  void firebaseCloudMessaging_Listeners() {
    //if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      SPref.instance.set(SPrefCache.KEY_SMSNONCE, token);
      print('Fire base token is: ' + token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
              title: notification['title'], body: notification['body']));
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        final notification = message['data'];
        setState(() {
          messages.add(Message(
            title: '${notification['title']}',
            //title: 'abc',
            body: '${notification['body']}',
          ));
        });
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  _startApp() {
    Future.delayed(
      Duration(seconds: 5),
      () async {
        final bloc = HomeBloc.getInstance(userRepo: Provider.of(context));
        var token = await SPref.instance.get(SPrefCache.KEY_TOKEN);
        _firebaseMessaging.getToken().then((token) {
          bloc.sendFBToken(token);
        });

        if (token != null) {
          bloc.getInfoUser();
          Navigator.pushReplacementNamed(context, '/home');
          return;
        }
        Navigator.pushReplacementNamed(context, '/home');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: ProductBloc.getInstance(productRepo: Provider.of(context)),
      child: Consumer<ProductBloc>(
        builder: (context, bloc, child) => Container(
          child: StreamProvider.value(
            value: bloc.getParentCategoryList(),
            initialData: null,
            catchError: (context, error) {
              return error;
            },
            child: Consumer<Object>(builder: (context, data, child) {
              if (data is RestError) {
                bloc.getParentCategoryListCache();
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                    child: Image.asset(
                      'assets/logo_intro.jpg',
                      width: 180,
                      height: 180,
                    ),
                  ),
                );
              }
              Product.category = data as List<ParentCategory>;
              return Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Image.asset(
                    'assets/logo_intro.jpg',
                    width: 180,
                    height: 180,
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
