import 'package:flutter/material.dart';

class RewardCard extends StatelessWidget {
  final String image;
  final String name;
  final int point;

  const RewardCard({Key key, this.image, this.name, this.point})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            //padding: EdgeInsets.all(10),
            height: 165,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[300],
              ),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: SizedBox(
              height: 165,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(name),
          Row(
            children: <Widget>[
              Icon(
                Icons.loyalty,
                color: Colors.red,
              ),
              SizedBox(width: 10),
              Text(point.toString())
            ],
          )
        ],
      ),
    );
  }
}
