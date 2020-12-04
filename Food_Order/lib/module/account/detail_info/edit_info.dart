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
            bottom: PreferredSize(
                child: Container(
                  color: Colors.grey[400],
                  height: 0.5,
                ),
                preferredSize: Size.fromHeight(1.0)),
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: Colors.black54,
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              'Sửa thông tin',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            )),
        body: Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 18),
          //height: 300,
          child: Wrap(
            children: <Widget>[
              Column(
                children: [
                  TextField(
                    cursorColor: Colors.red,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      labelText: 'Họ và tên',
                      labelStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  TextField(
                    cursorColor: Colors.red,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      labelText: 'Ngày sinh',
                      labelStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  TextField(
                    autofocus: true,
                    readOnly: true,
                    onTap: () {
                      showDatePicker(
                              context: context,
                              firstDate: DateTime(1960),
                              lastDate: DateTime(2021))
                          .then((date) {
                        print('ok');
                      });
                    },
                    cursorColor: Colors.red,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      labelText: 'Giới tính',
                      labelStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 25),
          height: MediaQuery.of(context).size.height / 12,
          child: FlatButton(
            onPressed: () {},
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
      ),
    );
  }
}

class EditInfoScreen extends StatefulWidget {
  @override
  _EditInfoScreenState createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<EditInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
