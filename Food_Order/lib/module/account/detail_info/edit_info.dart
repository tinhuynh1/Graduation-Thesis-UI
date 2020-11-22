import 'package:Food_Order/base/base_widget.dart';
import 'package:flutter/material.dart';

class EditInfoPage extends StatelessWidget {
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
              'Sửa thông tin',
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
          ],
        ),
        bottomNavigationBar: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Text(
            'Lưu thay đổi',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Colors.red,
        ),
      ),
    );
  }
}
