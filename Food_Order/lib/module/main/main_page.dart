import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/module/account/account_page.dart';
import 'package:Food_Order/module/home/home_page.dart';
import 'package:Food_Order/module/order/product_page.dart';
import 'package:Food_Order/module/store/store_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPageScreen extends StatelessWidget {
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
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey.shade300,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          //}
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Tin tức"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            title: Text("Đặt hàng"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            title: Text("Cửa hàng"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Tài khoản"),
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
      body: getBodyWidget(),
    );
  }

  getBodyWidget() {
    if (_currentIndex == 0) {
      return HomePage();
    } else if (_currentIndex == 1) {
      return OrderPage();
    } else if (_currentIndex == 2) {
      return StorePage();
    } else if (_currentIndex == 3) {
      return AccountPage();
    } else {
      return Container();
    }
  }
}
