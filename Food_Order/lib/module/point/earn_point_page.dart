import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/module/account/rewards/detail_coupon.dart';
import 'package:Food_Order/module/signin/signin_page.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:Food_Order/shared/widget/appbar.dart';
import 'package:Food_Order/shared/widget/card/coupon_card.dart';
import 'package:flutter/material.dart';

class EarnPointPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [],
      bloc: [],
      child: Scaffold(
        appBar: AppBarCustom(text: 'Mã thành viên'),
        backgroundColor: Colors.grey.shade200,
        body: InfoUser.isLogin == true
            ? Padding(
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
                          margin: EdgeInsets.only(bottom: 20, top: 60),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: Center(
                              child: Image(
                                image: NetworkImage(InfoUser.infoUser.barCode),
                              ),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text('Đưa mã này cho nhân viên khi thanh toán'),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text('Coupon của bạn'),
                    ),
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: CouponList.listCoupon.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailCouponPage(
                                    id: CouponList
                                        .listCoupon[index].discountCodeId)),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Ticket(
                            image: CouponList.listCoupon[index].image,
                            name: CouponList.listCoupon[index].name,
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
                  Text(
                      'Mã thành viên dùng để tích điểm và để đổi những phần quà'),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 18,
                    margin: EdgeInsets.only(left: 15, right: 15, top: 10),
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
      ),
    );
  }
}
