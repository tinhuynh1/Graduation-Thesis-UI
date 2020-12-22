import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/models/store.dart';
import 'package:Food_Order/shared/widget/appbar.dart';
import 'package:Food_Order/shared/widget/home_tile.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailBranchPage extends StatelessWidget {
  final List<Store> store;
  final int id;
  DetailBranchPage({@required this.id, @required this.store});
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [],
      bloc: [],
      child: Scaffold(
        appBar: AppBarCustom(
          text: store[id].address,
        ),
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3.4,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  store[id].image,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(15, 30, 15, 25),
                height: MediaQuery.of(context).size.height / 4.8,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  store[id].mapStatic,
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
                        Text(store[id].address)
                      ],
                    ),
                    Divider(color: Colors.grey[300]),
                    Row(
                      children: [
                        Icon(
                          Icons.space_bar,
                          color: Colors.red,
                        ),
                        Text(store[id].distance),
                        Spacer(),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(right: 15),
                          child: FlatButton(
                            onPressed: () {
                              _launchMapsUrl(store[id].lat, store[id].long);
                            },
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
              HomeTitle(text: 'Chi tiết'),
              Container(
                margin: EdgeInsets.only(top: 10),
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
                              Text(store[id].openTime +
                                  "-" +
                                  store[id].closeTime)
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
                          GestureDetector(
                            onTap: () {
                              launch(('tel://${0365333229}'));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Liên hệ'),
                                Text('0365333229')
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _launchMapsUrl(double lat, double lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
