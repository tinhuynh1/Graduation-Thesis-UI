import 'package:flutter/material.dart';

class GridProduct extends StatelessWidget {
  final String name;
  final String img;
  final String price;

  GridProduct({
    Key key,
    @required this.name,
    @required this.img,
    this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                // decoration: BoxDecoration(
                //     border: Border.all(
                //       color: Colors.grey,
                //     ),
                //     borderRadius: BorderRadius.all(Radius.circular(10))),
                color: Colors.white,
                height: MediaQuery.of(context).size.height / 3.6,
                width: MediaQuery.of(context).size.width / 2.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      "$img",
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                      child: Text('$name'),
                    ),
                    Spacer(),
                    Divider(
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                      child: Row(
                        children: <Widget>[
                          Text('$price'),
                          Spacer(),
                          FlatButton(
                            height: 30,
                            onPressed: () {},
                            child: Text(
                              '+',
                              style: TextStyle(
                                color: Colors.orange,
                              ),
                            ),
                            shape: CircleBorder(
                              //borderRadius: BorderRadius.circular(90.0),
                              side: BorderSide(color: Colors.orange),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      onTap: () {},
    );
  }
}
