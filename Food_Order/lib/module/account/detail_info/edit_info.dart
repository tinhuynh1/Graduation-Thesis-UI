import 'package:Food_Order/base/base_widget.dart';
import 'package:flutter/material.dart';

class EditInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [],
      bloc: [],
      child: Scaffold(
        backgroundColor: Color(0xfff0eff4),
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
                    readOnly: true,
                    cursorColor: Colors.red,
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1960),
                              lastDate: DateTime(2021))
                          .then((date) {});
                    },
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
                  TextFormField(
                    readOnly: true,
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext bc) {
                            return Wrap(
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Text('Giới tính của bạn ?',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12)),
                                        ),
                                        Divider(
                                          color: Colors.grey,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Text('Nam',
                                              style: TextStyle(
                                                color: Colors.blue,
                                              )),
                                        ),
                                        Divider(
                                          color: Colors.grey,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Text('Nữ',
                                              style: TextStyle(
                                                color: Colors.blue,
                                              )),
                                        ),
                                        Container(
                                          color: Color(0xfff0eff4),
                                          height: 15,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Text('Hủy bỏ',
                                              style: TextStyle(
                                                color: Colors.blue,
                                              )),
                                        ),
                                      ],
                                    ))
                              ],
                            );
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
