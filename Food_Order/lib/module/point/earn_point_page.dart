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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EarnPointPage extends StatelessWidget {
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
      child: EarnPointScreen(),
    );
  }
}

class EarnPointScreen extends StatefulWidget {
  @override
  _EarnPointScreenState createState() => _EarnPointScreenState();
}

class _EarnPointScreenState extends State<EarnPointScreen> {
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
                var listCoupon = data as List<Coupon>;
                return Scaffold(
                  appBar: AppBarCustom(text: 'Mã thành viên'),
                  backgroundColor: Color(0xfff0eff4),
                  body: InfoUser.isLogin == true
                      ? SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red,
                                  ),
                                  height: 180,
                                  width: MediaQuery.of(context).size.width,
                                  child: Container(
                                      color: Colors.white,
                                      margin:
                                          EdgeInsets.only(bottom: 20, top: 60),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 20),
                                        child: Center(
                                          child: Image(
                                            image: NetworkImage(
                                                InfoUser.infoUser.barCode),
                                          ),
                                        ),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Text(
                                      'Đưa mã này cho nhân viên khi thanh toán'),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Text('Coupon của bạn'),
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
                            Text(
                                'Mã thành viên dùng để tích điểm và để đổi những phần quà'),
                            Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height / 18,
                              margin:
                                  EdgeInsets.only(left: 15, right: 15, top: 10),
                              //padding: EdgeInsets.only(left: 15, right: 15, top: 10),
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
