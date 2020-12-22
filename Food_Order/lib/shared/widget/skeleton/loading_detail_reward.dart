import 'package:Food_Order/shared/widget/skeleton_container.dart';
import 'package:flutter/material.dart';

class LoadingDetailRewardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0eff4),
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
    );
  }
}
