import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/data/repo/user_repo.dart';
import 'package:Food_Order/models/coupon/coupon.dart';
import 'package:Food_Order/module/account/rewards/coupon_bloc.dart';
import 'package:Food_Order/module/account/rewards/detail_coupon_page.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:Food_Order/shared/widget/card/coupon_card.dart';
import 'package:Food_Order/shared/widget/skeleton/loading_rewards_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCouponPage extends StatelessWidget {
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
      child: MyCouponScreen(),
    );
  }
}

class MyCouponScreen extends StatefulWidget {
  @override
  _MyCouponScreenState createState() => _MyCouponScreenState();
}

class _MyCouponScreenState extends State<MyCouponScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: CouponBloc.getInstance(userRepo: Provider.of(context)),
        child: Consumer<CouponBloc>(builder: (context, bloc, child) {
          return Scaffold(
              backgroundColor: Color(0xfff0eff4),
              body: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: StreamProvider.value(
                    value: bloc.getMyCoupon(),
                    initialData: null,
                    catchError: (context, error) {
                      return error;
                    },
                    child: Consumer<Object>(builder: (context, data, child) {
                      if (data == null) {
                        return LoadingRewardsPage();
                      }
                      var response = data as List<Coupon>;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: response.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailCouponPage(
                                          id: response[index].discountCodeId)),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Ticket(
                                  image: response[index].image,
                                  name: response[index].name,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ));
        }));
  }
}
