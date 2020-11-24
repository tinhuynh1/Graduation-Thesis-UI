import 'package:Food_Order/base/base_widget.dart';
import 'package:flutter/material.dart';

class DetailCouponPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [],
      bloc: [],
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black54,
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              'Pickup nhé!',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            )),
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
                  'http://lorempixel.com/640/480/technics',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'macoupon'.toUpperCase(),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                    onTap: () {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('Đã copy')));
                    },
                    child: Text('Copy'))
              ],
            ),
            Text('Thời hạn sử dụng 01-11-2020 đến 30-11-220'),
            Text('Áp dụng: Đặt hàng online')
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 25),
          height: MediaQuery.of(context).size.height / 12,
          child: FlatButton(
            onPressed: () {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
  }
}
