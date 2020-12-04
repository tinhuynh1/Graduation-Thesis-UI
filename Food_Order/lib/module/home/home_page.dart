import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/data/repo/user_repo.dart';
import 'package:Food_Order/data/spref/spref.dart';
import 'package:Food_Order/module/account/rewards/coupon_page.dart';
import 'package:Food_Order/module/account/rewards/rewards_page.dart';
import 'package:Food_Order/module/home/home_bloc.dart';
import 'package:Food_Order/module/main/main_page.dart';
import 'package:Food_Order/module/point/earn_point_page.dart';
import 'package:Food_Order/module/signin/signin_page.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:Food_Order/shared/ultil/cards.dart';
import 'package:Food_Order/shared/widget/home_tile.dart';
import 'package:Food_Order/shared/widget/slider_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [
        Provider.value(
          value: UserService(),
        ),
        ProxyProvider<UserService, UserRepo>(
            update: (context, userService, previous) =>
                UserRepo(userService: userService)),
      ],
      bloc: [],
      child: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: HomeBloc.getInstance(userRepo: Provider.of(context)),
      child: Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
            bottom: PreferredSize(
                child: Container(
                  color: Colors.grey[400],
                  height: 0.5,
                ),
                preferredSize: Size.fromHeight(1.0)),
            elevation: 0.0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: InfoUser.isLogin != true
                ? Row(
                    children: <Widget>[
                      Icon(
                        Icons.person_rounded,
                        color: Colors.grey,
                        size: 35.0,
                      ),
                      FlatButton(
                        onPressed: () async {
                          Product.category =
                              await Helper.getListParentCategory();
                          print(Product.category.length);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return SignInPage();
                              },
                            ),
                          );
                          // await printListProduct();

                          print("width is: " +
                              MediaQuery.of(context).size.width.toString());
                          print('Height is: ' +
                              MediaQuery.of(context).size.height.toString());
                        },
                        child: Text(
                          'Đăng nhập',
                          style: TextStyle(color: Colors.red),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                              color: Colors.red,
                            )),
                      )
                    ],
                  )
                : Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(70),
                        child: InfoUser.infoUser.avatar == ''
                            ? Image(
                                image: AssetImage('assets/logo_intro.jpg'),
                                width: 35,
                                height: 35,
                                fit: BoxFit.cover,
                              )
                            : Image(
                                image: NetworkImage(InfoUser.infoUser.avatar),
                                width: 35,
                                height: 35,
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              InfoUser.infoUser.customerName,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Khách hàng mới',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.loyalty,
                                  color: Colors.red,
                                  size: 14,
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(top: 25),
                color: Colors.white,
                height: 130,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  //item 1, item 2, item 3
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return EarnPointPage();
                            },
                          ),
                        );
                      },
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/scanpoint.png',
                              width: 60,
                            ),
                            Text(
                              'Tích điểm',
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return MainPage();
                            },
                          ),
                        );
                      },
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/order.png',
                              width: 60,
                            ),
                            Text(
                              'Đặt hàng',
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return CouponPage();
                            },
                          ),
                        );
                      },
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/Wallet-cuate.png',
                              width: 60,
                            ),
                            Text(
                              'Ví Coupon',
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ),
                    InfoUser.isLogin == true
                        ? GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return RewardsStorePage();
                                  },
                                ),
                              );
                            },
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/rewards.png',
                                    width: 60,
                                  ),
                                  Text(
                                    'Rewards',
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              HomeTitle(text: "Ưu đãi đặc biệt"),
              Container(
                padding: EdgeInsets.only(top: 10),
                height: 310,
                child: ListView.builder(
                  itemCount: cards == null ? 0 : cards.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    Map card = cards[index];
                    return SliderHome(
                      img: card['img'],
                      title: card['title'],
                      desc: card['desc'],
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              HomeTitle(text: "Cập nhật từ Nhà"),
              Container(
                padding: EdgeInsets.only(top: 10),
                height: 300,
                child: ListView.builder(
                  itemCount: cards == null ? 0 : cards.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    Map card = cards[index];
                    return SliderHome(
                      img: card['img'],
                      title: card['title'],
                      desc: card['desc'],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> printListProduct() async {
    var str = await SPref.instance.getValue(SPrefCache.KEY_PRODUCT);
    print(str);
  }
}
