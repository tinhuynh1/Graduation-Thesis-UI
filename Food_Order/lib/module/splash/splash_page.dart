import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/product_service.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/data/repo/product_repo.dart';
import 'package:Food_Order/data/repo/rest_error.dart';
import 'package:Food_Order/data/repo/user_repo.dart';
import 'package:Food_Order/data/spref/spref.dart';
import 'package:Food_Order/models/product/parent_category.dart';
import 'package:Food_Order/module/account/rewards/coupon_bloc.dart';
import 'package:Food_Order/module/home/home_bloc.dart';
import 'package:Food_Order/module/order/product_bloc.dart';
import 'package:Food_Order/shared/constant.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _startApp();
  }

  _startApp() {
    Future.delayed(
      Duration(seconds: 5),
      () async {
        final bloc = HomeBloc.getInstance(userRepo: Provider.of(context));
        final couponBloc =
            CouponBloc.getInstance(userRepo: Provider.of(context));
        var token = await SPref.instance.get(SPrefCache.KEY_TOKEN);
        if (token != null) {
          bloc.getInfoUser();
          couponBloc.getListCouponUser();
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
