import 'package:Food_Order/models/last_order_response.dart';
import 'package:flutter/material.dart';

class LastOrderCard extends StatelessWidget {
  final LastOrderResponse lastOrderResponse;

  const LastOrderCard({Key key, this.lastOrderResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 15.0, right: 15.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[200],
            ),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Mã đơn hàng: #" + lastOrderResponse.orderCode,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  lastOrderResponse.type == 'DELIVERY'
                      ? Text(
                          "Giao tận nơi",
                        )
                      : Text(
                          "Tự đến lấy",
                        ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
