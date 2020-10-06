import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/module/main/main_page.dart';
import 'package:flutter/material.dart';

class InputPhone extends StatelessWidget {
  static String routeName = "/sign-in-phone";
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [],
      bloc: [],
      child: SignInFormWidget(),
    );
  }
}

class SignInFormWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Chào bạn,',
            style: TextStyle(fontSize: 25.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Nhập số điện thoại để tiếp tục',
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            //color: Colors.pink,
            height: 45.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  height: double.infinity,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Colors.grey)),
                  color: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  onPressed: () {},
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          "Ad".toUpperCase(),
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Expanded(
                  child: TextFormField(
                    cursorColor: Colors.green[500],
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      hintText: 'Số điện thoại',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          borderSide: BorderSide(color: Colors.grey[200])),
                    ),
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          Container(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                  width: double.infinity,
                  //height: getProportionateScreenWidth(56),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () {},
                    child: Text(
                      'Tiếp tục',
                      style: TextStyle(
                        color: Colors.white,
                        //fontSize: getProportionateScreenWidth(18),
                      ),
                    ),
                    color: Colors.orange,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPageScreen()),
                    );
                  },
                  child: Text(
                    'Bỏ qua',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
