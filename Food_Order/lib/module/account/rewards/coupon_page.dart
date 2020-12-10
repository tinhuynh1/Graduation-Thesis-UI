import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/data/repo/user_repo.dart';
import 'package:Food_Order/models/coupon/coupon.dart';
import 'package:Food_Order/module/account/rewards/coupon_bloc.dart';
import 'package:Food_Order/module/account/rewards/detail_coupon.dart';
import 'package:Food_Order/module/signin/signin_page.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:Food_Order/shared/widget/appbar.dart';
import 'package:Food_Order/shared/widget/coupon_widget.dart';
import 'package:Food_Order/shared/widget/skeleton_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CouponPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [
        Provider.value(
          value: UserService(),
        ),
        ProxyProvider<UserService, UserRepo>(
          update: (context, userService, previous) =>
              UserRepo(userService: userService),
        )
      ],
      bloc: [],
      child: CouponScreen(),
    );
  }
}

class CouponScreen extends StatefulWidget {
  @override
  _CouponScreenState createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: CouponBloc.getInstance(userRepo: Provider.of(context)),
      child: Consumer<CouponBloc>(
        builder: (context, bloc, child) => Container(
          child: StreamProvider<Object>.value(
            value: bloc.getListCouponUser(),
            initialData: null,
            catchError: (context, error) {
              return error;
            },
            child: Consumer<Object>(builder: (context, data, child) {
              if (data == null) {
                return Scaffold(
                  appBar: AppBar(
                    bottom: PreferredSize(
                        child: Container(
                          color: Colors.grey,
                          height: 1,
                        ),
                        preferredSize: Size.fromHeight(1.0)),
                    elevation: 0.0,
                    iconTheme: IconThemeData(
                      color: Colors.black54,
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.white,
                    title: Text(
                      'Coupon của bạn',
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ),
                  backgroundColor: Color(0xfff0eff4),
                  body: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SkeletonContainer.square(
                          height: MediaQuery.of(context).size.height / 8.2,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SkeletonContainer.square(
                          height: MediaQuery.of(context).size.height / 8.2,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SkeletonContainer.square(
                          height: MediaQuery.of(context).size.height / 8.2,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ],
                  ),
                );
              }
              var listcoupon = data as List<Coupon>;
              return Scaffold(
                appBar: AppBarCustom(
                  text: 'Coupon của bạn',
                ),
                backgroundColor: Color(0xfff0eff4),
                body: InfoUser.isLogin == true
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              color: Colors.white,
                              height: 45,
                              child: TextFormField(
                                cursorColor: Colors.green[500],
                                autofocus: true,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.qr_code_scanner),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[300]),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 10.0),
                                  hintText: 'Nhập mã khuyến mãi',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                ),
                              ),
                            ),
                            ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: listcoupon.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailCouponPage(
                                            id: listcoupon[index]
                                                .discountCodeId)),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Ticket(
                                    image: listcoupon[index].image,
                                    name: listcoupon[index].name,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/forbiden.png'),
                            fit: BoxFit.cover,
                          ),
                          Text('Tạo tài khoản để nhận nhiều coupon ưu đãi'),
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 18,
                            margin:
                                EdgeInsets.only(left: 15, right: 15, top: 10),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return SignInPage();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                'Đăng nhập để tiếp tục',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
