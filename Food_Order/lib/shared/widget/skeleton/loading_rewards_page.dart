import 'package:Food_Order/shared/constant.dart';
import 'package:Food_Order/shared/widget/appbar.dart';
import 'package:Food_Order/shared/widget/skeleton_container.dart';
import 'package:flutter/material.dart';

class LoadingRewardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff0eff4),
        appBar: AppBarCustom(
          text: 'Cửa hàng ưu đãi',
        ),
        body: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Color(0xfff0eff4),
              appBar: AppBar(
                bottom: PreferredSize(
                    child: Container(
                      color: Colors.grey[400],
                      height: 0.5,
                    ),
                    preferredSize: Size.fromHeight(1.0)),
                elevation: 0.0,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                title: TabBar(
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.black,
                  tabs: [
                    Tab(text: 'Đổi ưu đãi'),
                    Tab(text: 'Ưu đãi của bạn'),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[400],
                    ),
                  ],
                ),
                padding: EdgeInsets.only(left: 15, top: 10),
                //color: Colors.white,
                height: 50,
                child: Row(
                  children: <Widget>[
                    Text('Khách hàng ' +
                        InfoUser.infoUser.label.labelName.toLowerCase())
                  ],
                ),
              ),
              body: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 25),
                    margin: EdgeInsets.only(top: 10, bottom: 15),
                    height: MediaQuery.of(context).size.height / 6,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SkeletonContainer.rounded(
                                height: 50,
                                width: 50,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90))),
                            SizedBox(
                              height: 10,
                            ),
                            SkeletonContainer.square(
                              width: 50,
                              height: 10,
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            SkeletonContainer.rounded(
                                height: 50,
                                width: 50,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90))),
                            SizedBox(
                              height: 10,
                            ),
                            SkeletonContainer.square(
                              width: 50,
                              height: 10,
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            SkeletonContainer.rounded(
                                height: 50,
                                width: 50,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90))),
                            SizedBox(
                              height: 10,
                            ),
                            SkeletonContainer.square(
                              width: 50,
                              height: 10,
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            SkeletonContainer.rounded(
                                height: 50,
                                width: 50,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90))),
                            SizedBox(
                              height: 10,
                            ),
                            SkeletonContainer.square(
                              width: 50,
                              height: 10,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                    height: MediaQuery.of(context).size.height / 2,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonContainer.square(
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SkeletonContainer.rounded(
                                  height: MediaQuery.of(context).size.width /
                                      3 /
                                      1.5,
                                  width: MediaQuery.of(context).size.width / 3,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SkeletonContainer.square(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height: 15,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SkeletonContainer.square(
                                    width: MediaQuery.of(context).size.width /
                                        2 /
                                        1.5,
                                    height: 15,
                                  ),
                                  SizedBox(
                                    height: 35,
                                  ),
                                  SkeletonContainer.square(
                                    width:
                                        MediaQuery.of(context).size.width / 6,
                                    height: 15,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SkeletonContainer.rounded(
                                  height: MediaQuery.of(context).size.width /
                                      3 /
                                      1.5,
                                  width: MediaQuery.of(context).size.width / 3,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SkeletonContainer.square(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height: 15,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SkeletonContainer.square(
                                    width: MediaQuery.of(context).size.width /
                                        2 /
                                        1.5,
                                    height: 15,
                                  ),
                                  SizedBox(
                                    height: 35,
                                  ),
                                  SkeletonContainer.square(
                                    width:
                                        MediaQuery.of(context).size.width / 6,
                                    height: 15,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SkeletonContainer.rounded(
                                  height: MediaQuery.of(context).size.width /
                                      3 /
                                      1.5,
                                  width: MediaQuery.of(context).size.width / 3,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SkeletonContainer.square(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height: 15,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SkeletonContainer.square(
                                    width: MediaQuery.of(context).size.width /
                                        2 /
                                        1.5,
                                    height: 15,
                                  ),
                                  SizedBox(
                                    height: 35,
                                  ),
                                  SkeletonContainer.square(
                                    width:
                                        MediaQuery.of(context).size.width / 6,
                                    height: 15,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        Divider(color: Colors.grey),
                        Center(
                          child: SkeletonContainer.square(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 15,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
