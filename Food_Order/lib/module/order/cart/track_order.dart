import 'package:Food_Order/models/last_order_response.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:Food_Order/shared/widget/appbar.dart';
import 'package:Food_Order/shared/widget/avatar.dart';
import 'package:Food_Order/shared/widget/home_tile.dart';
import 'package:Food_Order/shared/widget/last_order_card.dart';
import 'package:flutter/material.dart';

class TrackOrderScreen extends StatefulWidget {
  final LastOrderResponse lastOrderResponse;
  const TrackOrderScreen({Key key, this.lastOrderResponse}) : super(key: key);
  @override
  _TrackOrderScreenState createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0eff4),
      appBar: AppBarCustom(
        text: 'Theo dõi đơn hàng #' + widget.lastOrderResponse.orderCode,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LastOrderCard(
              lastOrderResponse: widget.lastOrderResponse,
            ),
            HomeTitle(text: 'Trạng thái đơn hàng'),
            Container(
              margin: EdgeInsets.only(left: 15.0, right: 15.0),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[200],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white),
              padding: EdgeInsets.all(15),
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: widget.lastOrderResponse.listTransaction.length,
                itemBuilder: (context, index) => statusWidget(
                    widget.lastOrderResponse.listTransaction[index].status,
                    index == 0),
              ),
            ),
            HomeTitle(text: 'Chi tiết đơn hàng'),
            Container(
                margin: EdgeInsets.only(left: 15.0, right: 15.0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[200],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                padding: EdgeInsets.all(15),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount:
                              widget.lastOrderResponse.listOrderDetail.length,
                          itemBuilder: (context, indexListOrder) => Row(
                                children: <Widget>[
                                  Text(widget.lastOrderResponse
                                      .listOrderDetail[indexListOrder].quantity
                                      .toString()),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(widget
                                      .lastOrderResponse
                                      .listOrderDetail[indexListOrder]
                                      .productCart
                                      .productNameA),
                                  Spacer(),
                                  Text(widget
                                      .lastOrderResponse
                                      .listOrderDetail[indexListOrder]
                                      .productCart
                                      .price
                                      .toString()),
                                ],
                              )),
                      Divider(),
                      Row(
                        children: <Widget>[
                          Text('Tổng cộng:'),
                          Spacer(),
                          Text(widget.lastOrderResponse.listOrderDetail[0].total
                              .toString())
                        ],
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.only(left: 15.0, right: 15.0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[200],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Avatar(r: 70, width: 30, heigh: 30),
                        SizedBox(
                          width: 20,
                        ),
                        Text(InfoUser.infoUser.customerName)
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Icon(Icons.call, color: Colors.red),
                        SizedBox(
                          width: 20,
                        ),
                        Text(InfoUser.infoUser.phoneNumber)
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text('ĐH CNTT Tp.HCM')
                      ],
                    ),
                    Divider(),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Stack statusWidget(String status, bool firstItem) {
    return Stack(children: <Widget>[
      // !firstItem
      //     ?
      Container(
        margin: EdgeInsets.only(
          //bottom: 10,
          left: 5,
        ),
        width: 4,
        height: 38,
        color: Colors.grey,
      ),
      //: Container(),
      Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                  border: Border.all(color: Colors.red, width: 3)),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              status,
            )
          ],
        ),
      ),
    ]);
  }
}
