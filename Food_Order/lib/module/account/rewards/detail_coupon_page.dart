import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/data/repo/user_repo.dart';
import 'package:Food_Order/event/select_body_event.dart';
import 'package:Food_Order/models/coupon/coupon_details.dart';
import 'package:Food_Order/module/account/rewards/coupon_bloc.dart';
import 'package:Food_Order/module/home/home_bloc.dart';
import 'package:Food_Order/module/main/main_page.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:Food_Order/shared/widget/appbar.dart';
import 'package:Food_Order/shared/widget/skeleton/loading_details_coupon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
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
    initializeDateFormatting('vi');
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
                return LoadingDetailCouponPage();
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
                    Text(_expireDateText(
                        couponDetails.startDate, couponDetails.endDate)),
                    Text(couponDetails.description),
                  ],
                ),
                bottomNavigationBar: ChangeNotifierProvider.value(
                  value: HomeBloc.getInstance(userRepo: Provider.of(context)),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 25),
                    height: MediaQuery.of(context).size.height / 12,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            return MainPage();
                          },
                        ));
                        HomeBloc.getInstance(userRepo: Provider.of(context))
                            .event
                            .add(SelectBodyEvent(1));
                        CouponApply.couponId = widget.id;
                      },
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
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  String _expireDateText(DateTime start, DateTime end) {
    var str = 'Thời hạn sử dụng ' +
        DateFormat.yMd('vi').format(start) +
        ' đến ' +
        DateFormat.yMd('vi').format(end);
    return str;
  }
}
