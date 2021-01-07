import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/data/state/tab_index_state.dart';
import 'package:Food_Order/event/select_body_event.dart';
import 'package:Food_Order/module/account/account_page.dart';
import 'package:Food_Order/module/home/home_bloc.dart';
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
    final bloc = HomeBloc.getInstance(userRepo: null);

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
        child: StreamProvider.value(
          initialData: 0,
          value: bloc.indexStream,
          child: Consumer<int>(
            builder: (context, index, child) => BottomNavigationBar(
              selectedItemColor: Colors.red,
              selectedFontSize: 12.0,
              unselectedItemColor: Colors.black,
              currentIndex: index,
              onTap: (index) {
                bloc.event.add(SelectBodyEvent(index));
                // setState(() {
                //   _currentIndex = index;
                // });
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
        ),
      ),
      body: StreamBuilder<TabIndexState>(
        stream: bloc.indexController.stream,
        initialData: bloc.index,
        builder: (BuildContext context, AsyncSnapshot<TabIndexState> snapshot) {
          return getBodyWidget(snapshot.data.index);
        },
      ),
    );
  }

  getBodyWidget(int index) {
    if (index == 0) {
      return HomePage();
    } else if (index == 1) {
      return ProductPage();
    } else if (index == 2) {
      return StorePage();
    } else if (index == 3) {
      return AccountPage();
    } else {
      return Container();
    }
  }
}
