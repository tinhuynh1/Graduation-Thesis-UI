import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/data/repo/user_repo.dart';
import 'package:Food_Order/models/coupon/coupon.dart';
import 'package:Food_Order/module/account/rewards/coupon_bloc.dart';
import 'package:Food_Order/module/account/rewards/detail_coupon_page.dart';
import 'package:Food_Order/module/signin/signin_page.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:Food_Order/shared/widget/appbar.dart';
import 'package:Food_Order/shared/widget/card/coupon_card.dart';
import 'package:Food_Order/shared/widget/skeleton/loading_coupon_page.dart';
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
          child: StreamProvider.value(
            value: bloc.getListCouponUser(),
            initialData: null,
            catchError: (context, error) {
              return error;
            },
            child: Consumer<Object>(
              builder: (context, data, child) {
                if (data == null) return LoadingCouponPage();
                var listCoupon = data as List<Coupon>;
                return Scaffold(
                  appBar: AppBarCustom(
                    text: 'Coupon của bạn',
                  ),
                  backgroundColor: Color(0xfff0eff4),
                  body: InfoUser.isLogin == true
                      ? SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  color: Colors.white,
                                  height: 45,
                                  child: TextFormField(
                                    cursorColor: Colors.green[500],
                                    autofocus: false,
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
                                  itemCount: listCoupon.length,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailCouponPage(
                                                    id: listCoupon[index]
                                                        .discountCodeId)),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Ticket(
                                        image: listCoupon[index].image,
                                        name: listCoupon[index].name,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
              },
            ),
          ),
        ),
      ),
    );
  }
}
