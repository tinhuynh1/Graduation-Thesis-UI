import 'package:flutter/material.dart';

class SliderHome extends StatelessWidget {
  final String img;
  final String title;
  final String desc;

  SliderHome({
    Key key,
    @required this.img,
    @required this.title,
    @required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        width: MediaQuery.of(context).size.width / 1.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0)),
              child: Image.asset(
                '$img',
                height: 120,
                width: 245,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '$title',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '$desc',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                  //Spacer(),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      "Chi tiết",
                      style: TextStyle(color: Colors.orange),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.orange),
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
