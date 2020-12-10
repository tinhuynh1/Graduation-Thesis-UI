import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/data/repo/user_repo.dart';
import 'package:Food_Order/models/coupon/coupon_details.dart';
import 'package:Food_Order/module/account/rewards/coupon_bloc.dart';
import 'package:Food_Order/shared/widget/appbar.dart';
import 'package:Food_Order/shared/widget/skeleton_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DetailCouponPage extends StatelessWidget {
  final int id;

  const DetailCouponPage({Key key, this.id}) : super(key: key);
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
        child: DetailCouponScreen(
          id: id,
        ));
  }
}

class DetailCouponScreen extends StatefulWidget {
  final int id;

  const DetailCouponScreen({Key key, this.id}) : super(key: key);
  @override
  _DetailCouponScreenState createState() => _DetailCouponScreenState();
}

class _DetailCouponScreenState extends State<DetailCouponScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: CouponBloc.getInstance(userRepo: Provider.of(context)),
      child: Consumer<CouponBloc>(
        builder: (context, bloc, child) => Container(
          child: StreamProvider<Object>.value(
            value: bloc.getCouponDetailUser(widget.id),
            initialData: null,
            catchError: (context, error) {
              return error;
            },
            child: Consumer<Object>(builder: (context, data, child) {
              if (data == null) {
                return Scaffold(
                  appBar: AppBarCustom(
                    text: '',
                  ),
                  backgroundColor: Color(0xfff0eff4),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        padding: EdgeInsets.all(10),
                        child: SkeletonContainer.square(
                          height: 150,
                          width: 150,
                        ),
                      ),
                      Container(
                        child: SkeletonContainer.square(
                          height: 20,
                          width: 150,
                        ),
                      ),
                      Container(
                        child: SkeletonContainer.square(
                          height: 20,
                          width: double.infinity,
                        ),
                      ),
                      Container(
                        child: SkeletonContainer.square(
                          height: 20,
                          width: 100,
                        ),
                      ),
                    ],
                  ),
                  bottomNavigationBar: Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 25),
                    height: MediaQuery.of(context).size.height / 12,
                    child: SkeletonContainer.square(
                      width: double.infinity,
                      height: 50,
                    ),
                  ),
                );
              }
              var couponDetails = data as CouponDetail;
              return Scaffold(
                backgroundColor: Color(0xfff0eff4),
                appBar: AppBarCustom(
                  text: couponDetails.name,
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      padding: EdgeInsets.all(10),
                      height: 150,
                      width: 150,
                      child: ClipRRect(
                        child: Image.network(
                          couponDetails.qrCode,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          couponDetails.code.toUpperCase(),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                              Clipboard.setData(
                                  new ClipboardData(text: couponDetails.code));
                              Scaffold.of(context).showSnackBar(new SnackBar(
                                content: new Text("Copied to Clipboard"),
                              ));
                            },
                            child: Text('Copy'))
                      ],
                    ),
                    Text('Thời hạn sử dụng 01-11-2020 đến 30-11-220'),
                    Text('Áp dụng: Đặt hàng online'),
                    Text(couponDetails.description),
                  ],
                ),
                bottomNavigationBar: Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 25),
                  height: MediaQuery.of(context).size.height / 12,
                  child: FlatButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Đặt hàng ngay',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.red,
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
