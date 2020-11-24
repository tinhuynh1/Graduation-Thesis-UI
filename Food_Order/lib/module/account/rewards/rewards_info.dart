import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/module/account/rewards/coupon_page.dart';
import 'package:flutter/material.dart';

class RewardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [],
      bloc: [],
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black54,
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              'Thông tin thành viên',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 18),
            ),
          ),
          backgroundColor: Colors.grey.shade200,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[300],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                margin: EdgeInsets.fromLTRB(15, 20, 15, 10),
                height: MediaQuery.of(context).size.height / 6.0,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'http://lorempixel.com/640/480/food',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 70),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Huỳnh Nguyễn Quang Tín',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          Text(
                            'Khách hàng mới',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[300],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
                height: MediaQuery.of(context).size.height / 4.3,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.loyalty,
                            color: Colors.red,
                          ),
                          VerticalDivider(
                            color: Colors.grey,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CouponPage()),
                              );
                            },
                            child: Container(
                              height: 50,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('2'),
                                  Row(
                                    children: <Widget>[
                                      Text('Ưu đãi'),
                                      Icon(Icons.keyboard_arrow_right)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Text('Lịch sử nhận thưởng'),
                          Spacer(),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Row(
                      children: <Widget>[
                        Text('Tìm hiểu chương trình'),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_right)
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, top: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[300],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
                height: MediaQuery.of(context).size.height / 9.2,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Bạn là thành viên mới',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Chưa tích điểm',
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}