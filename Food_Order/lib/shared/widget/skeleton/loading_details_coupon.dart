import 'package:Food_Order/shared/widget/skeleton_container.dart';
import 'package:flutter/material.dart';

class LoadingDetailCouponPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0eff4),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: SkeletonContainer.square(
          height: 15,
          width: MediaQuery.of(context).size.width / 3,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 20, bottom: 20),
            padding: EdgeInsets.all(10),
            height: 150,
            width: 150,
            child: SkeletonContainer.square(
              height: 130,
              width: 130,
            ),
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 20, bottom: 20),
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height / 3,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                SkeletonContainer.square(
                  height: 15,
                  width: MediaQuery.of(context).size.width / 3,
                ),
                SizedBox(
                  height: 10,
                ),
                SkeletonContainer.square(
                  height: 15,
                  width: MediaQuery.of(context).size.width / 1.5,
                ),
                SizedBox(
                  height: 10,
                ),
                SkeletonContainer.square(
                  height: MediaQuery.of(context).size.height / 6,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
