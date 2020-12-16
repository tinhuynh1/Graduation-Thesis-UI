import 'package:Food_Order/shared/widget/skeleton_container.dart';
import 'package:flutter/material.dart';

class LoadingDetailProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: Colors.grey,
                height: 1,
              ),
              preferredSize: Size.fromHeight(1.0)),
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: SkeletonContainer.square(
            width: 100,
            height: 10,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 10, 10.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonContainer.rounded(
                  height: MediaQuery.of(context).size.height / 3.2,
                  width: MediaQuery.of(context).size.width,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              SizedBox(
                height: 10,
              ),
              SkeletonContainer.rounded(
                  height: 20,
                  width: double.infinity,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              SizedBox(
                height: 100,
              ),
              SkeletonContainer.square(
                height: MediaQuery.of(context).size.height / 5,
                width: double.infinity,
              ),
              SizedBox(
                height: 20,
              ),
              SkeletonContainer.rounded(
                height: 20,
                width: double.infinity,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ],
          ),
        ),
        floatingActionButton: SkeletonContainer.rounded(
          width: 60,
          height: 60,
          borderRadius: BorderRadius.all(Radius.circular(90)),
        ));
  }
}
