import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/module/account/rewards/splash.dart';
import 'package:flutter/material.dart';

class RewardsStorePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return PageContainer(
      di: [],
      bloc: [],
      child: Scaffold(
        backgroundColor: Colors.indigo[50],
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black54,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'Cửa hàng ưu đãi',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 15),
          ),
        ),
        body: Column(
          children: [
            Expanded(child: TabBarDemo()),
          ],
        ),
      ),
    );
  }
}

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TabBar(
            tabs: [
              Tab(text: 'Đổi ưu đãi'),
              Tab(text: 'Ưu đãi của bạn'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Container(
            //   margin: EdgeInsets.only(top: 10),
            //   padding: EdgeInsets.only(top: 25),
            //   color: Colors.white,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     crossAxisAlignment: CrossAxisAlignment.stretch,
            //     children: <Widget>[
            //       Container(
            //         child: Column(
            //           children: <Widget>[
            //             Image.asset(
            //               'assets/scan.jpg',
            //               width: 60,
            //             ),
            //             Text(
            //               'Tích điểm',
            //               style: TextStyle(fontSize: 12),
            //             )
            //           ],
            //         ),
            //       ),
            //       Container(
            //         child: Column(
            //           children: <Widget>[
            //             Image.asset(
            //               'assets/delivery.jpg',
            //               width: 60,
            //             ),
            //             Text(
            //               'Đặt hàng',
            //               style: TextStyle(fontSize: 12),
            //             )
            //           ],
            //         ),
            //       ),
            //       Container(
            //         child: Column(
            //           children: <Widget>[
            //             Image.asset(
            //               'assets/resources_images_intro_onboadingbg1.png',
            //               width: 60,
            //             ),
            //             Text(
            //               'Coupon',
            //               style: TextStyle(fontSize: 12),
            //             )
            //           ],
            //         ),
            //       ),
            //       GestureDetector(
            //         onTap: () {
            //           Navigator.of(context).push(
            //             MaterialPageRoute(
            //               builder: (BuildContext context) {
            //                 return RewardsStorePage();
            //               },
            //             ),
            //           );
            //         },
            //         child: Container(
            //           child: Column(
            //             children: <Widget>[
            //               Image.asset(
            //                 'assets/rewards.jpg',
            //                 width: 60,
            //               ),
            //               Text(
            //                 'Rewards',
            //                 style: TextStyle(fontSize: 12),
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Splash(),
            Container(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/rewards.jpg',
                    width: 60,
                  ),
                  Text('Không có ưu đãi'),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(left: 15, top: 10),
          color: Colors.white,
          height: 50,
          child: Row(
            children: <Widget>[Text('Khách hàng mới')],
          ),
        ),
      ),
    );
  }
}
