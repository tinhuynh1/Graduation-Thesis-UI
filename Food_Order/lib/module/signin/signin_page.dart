import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/module/signin/inputphone_page.dart';
import 'package:Food_Order/module/main/main_page.dart';
import 'package:Food_Order/shared/widget/button/social_button.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
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
  //final TextEditingController _txtPhoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image(
              image: AssetImage('assets/login.png'),
              fit: BoxFit.cover,
            ),
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
              //color: Colors.white,
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
                          Container(
                            child: Image.asset(
                              "assets/resources_images_flag_vietnam.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InputPhone()));
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).unselectedWidgetColor),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        hintText: 'Số điện thoại',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            borderSide: BorderSide(color: Colors.red)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            Container(
              alignment: Alignment.center,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Hoặc đăng nhập bằng',
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: <Widget>[
                      SocialButton(
                        onPressed: () {},
                        text: 'Facebook',
                        color: Color(0xFF3b5998),
                      ),
                      Spacer(),
                      SocialButton(
                        onPressed: () {},
                        text: 'Email',
                        color: Colors.orange,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainPageScreen()),
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
            ),
          ],
        ),
      ),
    );
  }
}
