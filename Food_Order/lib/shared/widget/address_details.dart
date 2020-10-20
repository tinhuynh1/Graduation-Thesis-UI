import 'package:flutter/material.dart';

class DetailAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: (Text(
          'TCH Signature 19B Phạm Ngọc Thạch',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        )),
      ),
      backgroundColor: Colors.grey[200],
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.red,
              child: Image(
                height: 225,
                width: double.infinity,
                image: NetworkImage(
                  'https://lh5.googleusercontent.com/p/AF1QipOfv3DSTkjsgvwCsUe_flDr4DBXneEVR1hWQCvR=w90-h90-n-k-no',
                ),
              ),
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 280,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 180,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.orange,
                      )
                    ],
                  ),
                  Divider(),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      "Chỉ đường đến đây",
                      style: TextStyle(color: Colors.orange),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.orange),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Chi tiết'),
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 114,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.watch_later_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Giờ mở cửa'),
                            Text('7:00 - 22:00')
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.call_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Liên hệ'),
                            Text('0365333229')
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
