import 'package:Food_Order/shared/widget/appbar.dart';
import 'package:flutter/material.dart';

class LoadingCouponPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom(
          text: '',
        ),
        backgroundColor: Color(0xfff0eff4),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  height: 45,
                  child: TextFormField(
                    cursorColor: Colors.green[500],
                    autofocus: false,
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
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) => Container(
                    child: Text('Loading.....'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
