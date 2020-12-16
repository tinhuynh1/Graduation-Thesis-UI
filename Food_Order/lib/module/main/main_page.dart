import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/module/account/account_page.dart';
import 'package:Food_Order/module/home/home_page.dart';
import 'package:Food_Order/module/order/product_page.dart';
import 'package:Food_Order/module/store/store_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPageScreen extends StatelessWidget {
  final bool isNav;
  const MainPageScreen({@required this.isNav});
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [
        Provider.value(
          value: UserService(),
        ),
      ],
      bloc: [],
      child: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({
    Key key,
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400],
            ),
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.red,
          selectedFontSize: 12.0,
          unselectedItemColor: Colors.black,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Tin tức",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined),
              label: "Đặt hàng",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store_outlined),
              label: "Cửa hàng",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: "Tài khoản",
            ),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
      body: getBodyWidget(),
    );
  }

  getBodyWidget() {
    if (_currentIndex == 0) {
      return HomePage();
    } else if (_currentIndex == 1) {
      return ProductPage();
    } else if (_currentIndex == 2) {
      return StorePage();
    } else if (_currentIndex == 3) {
      return AccountPage();
    } else {
      return Container();
    }
  }
}
