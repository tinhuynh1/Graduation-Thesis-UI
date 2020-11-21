import 'package:Food_Order/base/base_widget.dart';
import 'package:flutter/material.dart';

class DetailsCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [],
      bloc: [],
      child: DetailsCartScreen(),
    );
  }
}

class DetailsCartScreen extends StatefulWidget {
  @override
  _DetailsCartScreen createState() => _DetailsCartScreen();
}

class _DetailsCartScreen extends State<DetailsCartScreen> {
  int initPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black54,
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              'Giỏ hàng của bạn',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.normal),
            )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
              child: Text('Thông tin đơn hàng'),
            ),
            Container(
              height: 200,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
              child: Text('Thời gian nhận hàng'),
            ),
            Container(
              height: 50,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
              child: Text('Chi tiết đơn'),
            ),
            Container(
              height: 300,
              color: Colors.white,
            )
          ],
        ));
  }
}
