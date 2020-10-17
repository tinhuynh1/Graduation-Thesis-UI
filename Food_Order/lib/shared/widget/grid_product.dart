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
              GestureDetector(
                onTap: () {
                  showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: MaterialLocalizations.of(context)
                          .modalBarrierDismissLabel,
                      barrierColor: Colors.black45,
                      transitionDuration: const Duration(milliseconds: 200),
                      pageBuilder: (BuildContext buildContext,
                          Animation animation, Animation secondaryAnimation) {
                        return Scaffold(
                          backgroundColor: Colors.transparent,
                          body: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width - 80,
                              height: MediaQuery.of(context).size.height - 200,
                              //padding: EdgeInsets.all(20),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 100,
                                          height: 100,
                                          child: Image.asset(
                                            "$img",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Container(
                                          //width: 100,
                                          height: 100,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Text('Tra Sua So Ri Thanh Long'),
                                              Text('49.000 d'),
                                              Icon(Icons.favorite_outline)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 50,
                                    color: Colors.grey[200],
                                    child: Text(
                                      'Size',
                                    ),
                                  ),
                                  Container(),
                                  Container(
                                    width: double.infinity,
                                    height: 50,
                                    color: Colors.grey[200],
                                    child: Text(
                                      'Topping',
                                    ),
                                  ),
                                  RaisedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Save",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.orange,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3.6,
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                              topRight: const Radius.circular(10.0)),
                          child: Image.asset(
                            "$img",
                            fit: BoxFit.cover,
                          ),
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
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('$price'),
                              //Spacer(),
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
                                  side: BorderSide(color: Colors.orange),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
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
