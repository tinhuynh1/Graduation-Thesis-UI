import 'package:Food_Order/module/order/cart/details_cart_page.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:Food_Order/shared/widget/format_money.dart';
import 'package:flutter/material.dart';

class SeeCartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailsCartPage()),
          );
        },
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 14,
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  ListProduct.listProduct.length.toString(),
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ),
              Text(
                'Xem giỏ hàng',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  FormatMoney.format(
                      FormatMoney.amount(ListProduct.listProduct)),
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.right,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
