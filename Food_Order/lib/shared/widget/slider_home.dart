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
      width: MediaQuery.of(context).size.width / 1.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            child: Image.asset(
              '$img',
              height: 120,
              width: 240,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
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
    );
  }
}
