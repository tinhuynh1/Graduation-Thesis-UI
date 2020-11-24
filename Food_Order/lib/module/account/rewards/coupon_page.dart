import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/module/account/rewards/detail_coupon.dart';
import 'package:Food_Order/shared/widget/coupon_widget.dart';
import 'package:flutter/material.dart';

class CouponPage extends StatelessWidget {
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
              'Coupon của bạn',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 18),
            ),
          ),
          backgroundColor: Colors.grey.shade200,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  height: 45,
                  child: TextFormField(
                    cursorColor: Colors.green[500],
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.qr_code_scanner),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300]),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      hintText: 'Nhập mã khuyến mãi',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailCouponPage()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Ticket(),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailCouponPage()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Ticket(),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
