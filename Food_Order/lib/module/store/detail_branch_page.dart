import 'package:Food_Order/base/base_widget.dart';
import 'package:flutter/material.dart';

class DetailBranchPage extends StatelessWidget {
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
              '201 Đặng Văn Bi',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 18),
            ),
          ),
          backgroundColor: Colors.grey.shade200,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3.4,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  'http://lorempixel.com/640/480/nightlife',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(15, 30, 15, 25),
                height: MediaQuery.of(context).size.height / 4.8,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  'https://maps.googleapis.com/maps/api/staticmap?center=Brooklyn%20Bridge%2CNew%20York%2CNY&zoom=13&size=600x300&maptype=roadmap&markers=color%3Ared%7Clabel%3AC%7C40.718217%2C-73.998284&key=AIzaSyBJAGy5XN6RxaHa5E4btSBxsbveOK4dXZA&fbclid=IwAR25V1tsBUrzLDLBc_dbZ1_80C9M3YB0QJfCnON8J4a1Uml_CP1EGAVnpO4',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 8.2,
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.red,
                        ),
                        Text('201 Đặng Văn Bi, Thủ Đức, Hồ Chí Minh, VIệt Nam')
                      ],
                    ),
                    Divider(color: Colors.grey[300]),
                    Row(
                      children: [
                        Icon(
                          Icons.space_bar,
                          color: Colors.red,
                        ),
                        Text('15Km'),
                        Spacer(),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(right: 15),
                          child: FlatButton(
                            onPressed: () {},
                            child: Text(
                              "Chỉ đường đến đây",
                              style: TextStyle(color: Colors.red),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
                child: Text('Chi tiết'),
              ),
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height / 7.8,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      height: MediaQuery.of(context).size.height / 18.6,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.access_time,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Giờ mở cửa'),
                              Text('7:00 - 22:00')
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      height: MediaQuery.of(context).size.height / 18.6,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.phone_outlined,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Liên hệ'),
                              Text('0365333229')
                            ],
                          )
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
