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
              color: Colors.black87, fontWeight: FontWeight.w400, fontSize: 18),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
            child: Text('Thông tin đơn hàng'),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            height: MediaQuery.of(context).size.height / 5,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person_outline_outlined,
                            color: Colors.grey,
                          ),
                          hintText: 'Tên người nhận',
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.call_outlined,
                            color: Colors.grey,
                          ),
                          hintText: 'Số điện thoại',
                        ),
                      ),
                    ),
                    Icon(
                      Icons.contact_phone,
                      color: Colors.grey,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image(
                      height: 70,
                      width: 70,
                      image: AssetImage('assets/logo_intro.jpg'),
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('201 Đặng Văn Bi'),
                            Text(
                              'THAY ĐỔI',
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                        Container(
                          color: Colors.red,
                          height: 32,
                          width: 32,
                          child: TextField(
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.event_note_outlined,
                                color: Colors.grey,
                              ),
                              hintText: 'Tên người nhận',
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
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
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        child: RaisedButton(
          child: Text(
            "Đăng nhập để mua hàng",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Colors.red,
          onPressed: () {},
        ),
      ),
    );
  }
}
