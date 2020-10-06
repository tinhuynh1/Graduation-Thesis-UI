import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [
        Provider.value(
          value: UserService(),
        ),
      ],
      bloc: [],
      child: Container(
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Container(
                height: 50.0,
                child: TabBar(
                  indicatorColor: Colors.orange,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      text: "Phổ biến",
                    ),
                    Tab(
                      text: "Thức uống",
                    ),
                    Tab(
                      text: "Đồ ăn",
                    ),
                  ],
                ),
              ),
            ),
            body: TabBarView(
              children: [
                Icon(Icons.fastfood),
                Icon(Icons.local_drink),
                Icon(Icons.food_bank),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
