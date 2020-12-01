import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/data/repo/rest_error.dart';
import 'package:Food_Order/data/repo/user_repo.dart';
import 'package:Food_Order/data/spref/spref.dart';
import 'package:Food_Order/models/customer.dart';
import 'package:Food_Order/module/account/rewards/rewards_page.dart';
import 'package:Food_Order/module/home/home_bloc.dart';
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
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Consumer<HomeBloc>(
              builder: (context, bloc, child) => Container(
                child: StreamProvider<Object>.value(
                  value: bloc.infoUserStream,
                  initialData: null,
                  catchError: (context, error) {
                    return error;
                  },
                  child: Consumer<Object>(
                    builder: (context, data, child) {
                      if (data == null) {
                        //return Customer.fromJson(json.decode)
                        return Row(
                          children: <Widget>[
                            Icon(
                              Icons.person_rounded,
                              color: Colors.grey,
                              size: 35.0,
                            ),
                            FlatButton(
                              onPressed: () {
                                stick();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return SignInPage();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                "Đăng nhập",
                                style: TextStyle(color: Colors.red),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red),
                              ),
                            )
                          ],
                        );
                      }

                      if (data is RestError) {
                        return Center(
                          child: Container(
                            child: Text(
                              data.message,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        );
                      }
                      var infoUser = data as Customer;
                      return infoUser.customerName == ""
                          ? Row(
                              children: <Widget>[
                                Icon(
                                  Icons.person_rounded,
                                  color: Colors.grey,
                                  size: 35.0,
                                ),
                                FlatButton(
                                  onPressed: () {
                                    stick();
                                  },
                                  child: Text(
                                    "Đăng nhập",
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.orange),
                                  ),
                                )
                              ],
                            )
                          : Row(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(70),
                                  child: infoUser.avatar == ""
                                      ? Image(
                                          image: AssetImage(
                                              'assets/logo_intro.jpg'),
                                          width: 35,
                                          height: 35,
                                          fit: BoxFit.cover,
                                        )
                                      : Image(
                                          image: NetworkImage(infoUser.avatar),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        infoUser.customerName,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
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
                                            color: Colors.orange,
                                            size: 14,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                    },
                  ),
                ),
              ),
            ),
          ),
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
                      Container(
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/scan.jpg',
                              width: 60,
                            ),
                            Text(
                              'Tích điểm',
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/delivery.jpg',
                              width: 60,
                            ),
                            Text(
                              'Đặt hàng',
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/resources_images_intro_onboadingbg1.png',
                              width: 60,
                            ),
                            Text(
                              'Coupon',
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
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
                                'assets/rewards.jpg',
                                width: 60,
                              ),
                              Text(
                                'Rewards',
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ),
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
                    //padding: EdgeInsets.only(left: 10),
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
        ));
  }

  Future<Widget> buidAppBar() async {
    var isLogged = await SPref.instance.getValue(SPrefCache.KEY_SIGNUP);
    print(isLogged);
    if (isLogged == "true") {
      return Container(
        color: Colors.green,
      );
    }
    return Container(
      color: Colors.red,
    );
  }

  void stick() async {
    var isLogged = await SPref.instance.getValue(SPrefCache.KEY_USER);
    print(isLogged);
  }
}
