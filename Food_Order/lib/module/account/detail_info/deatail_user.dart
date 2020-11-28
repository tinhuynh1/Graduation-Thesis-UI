import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/state/order_bloc.dart';
import 'package:Food_Order/data/state/order_state.dart';
import 'package:Food_Order/event/order_event.dart';
import 'package:Food_Order/module/account/detail_info/edit_info.dart';
import 'package:flutter/material.dart';

class DetailUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final blocRemote = RemoteBloc();
    return PageContainer(
      di: [],
      bloc: [],
      child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height / 3.8,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 340),
                        child: RawMaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          constraints: BoxConstraints(),

                          fillColor: Colors.black54,
                          child: Icon(
                            Icons.close,
                            size: 30.0,
                            color: Colors.white,
                          ),
                          //padding: EdgeInsets.all(15.0),
                          shape: CircleBorder(),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(70),
                        child: Image(
                          image: NetworkImage(
                              'http://lorempixel.com/640/480/food'),
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: Text('Huỳnh Nguyễn Quang Tín'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.loyalty,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Thành viên mới')
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: <Widget>[
                    Text('Thông tin cá nhân'),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return EditInfoPage();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Đổi',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height / 16,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Tên',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text('Huỳnh Nguyễn Quang Tín'),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height / 16,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Sinh nhật',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text('12/08/1998'),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height / 16,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Số điện thoại',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text('0365333229'),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
