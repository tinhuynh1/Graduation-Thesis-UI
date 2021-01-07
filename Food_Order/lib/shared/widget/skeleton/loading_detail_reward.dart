import 'package:Food_Order/shared/widget/skeleton_container.dart';
import 'package:flutter/material.dart';

class LoadingDetailRewardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff0eff4),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
                expandedHeight: 200.0,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.1, 0.5, 0.7, 0.9],
                      colors: [
                        Colors.black,
                        Colors.grey[400],
                        Colors.grey[100],
                        Colors.white,
                      ],
                    ),
                  ),
                )),
            SliverFillRemaining(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    //height: MediaQuery.of(context).size.height / 3,
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        SkeletonContainer.square(
                          height: 15,
                          width: MediaQuery.of(context).size.width / 1.5,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SkeletonContainer.square(
                          height: 15,
                          width: MediaQuery.of(context).size.width / 3,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SkeletonContainer.square(
                              height: 15,
                              width: MediaQuery.of(context).size.width / 5,
                            ),
                            Spacer()
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SkeletonContainer.square(
                          height: 15,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SkeletonContainer.square(
                          height: 15,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SkeletonContainer.square(
                          height: 15,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SkeletonContainer.square(
                              height: 100,
                              width: 100,
                            ),
                            SkeletonContainer.square(
                              height: 100,
                              width: 100,
                            ),
                            SkeletonContainer.square(
                              height: 100,
                              width: 100,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SkeletonContainer.square(
                              height: 15,
                              width: MediaQuery.of(context).size.width / 5,
                            ),
                            Spacer()
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SkeletonContainer.square(
                          height: 15,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SkeletonContainer.square(
                          height: 15,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SkeletonContainer.square(
                          height: 15,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SkeletonContainer.square(
                              height: 15,
                              width: MediaQuery.of(context).size.width / 5,
                            ),
                            Spacer()
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SkeletonContainer.square(
                          height: 15,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SkeletonContainer.square(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 20),
          height: 75,
          color: Colors.white,
          child: RaisedButton(
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.black38,
          ),
        ));
  }
}
