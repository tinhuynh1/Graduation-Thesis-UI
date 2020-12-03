import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/module/account/rewards/list_endow_page.dart';
import 'package:flutter/material.dart';

class RewardsStorePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return PageContainer(
      di: [],
      bloc: [],
      child: Scaffold(
        backgroundColor: Colors.indigo[50],
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: Colors.grey[400],
                height: 0.5,
              ),
              preferredSize: Size.fromHeight(1.0)),
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black54,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'Cửa hàng ưu đãi',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 15),
          ),
        ),
        body: Column(
          children: [
            Expanded(child: TabBarDemo()),
          ],
        ),
      ),
    );
  }
}

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
            indicatorColor: Colors.red,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            tabs: [
              Tab(text: 'Đổi ưu đãi'),
              Tab(text: 'Ưu đãi của bạn'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 15),
                    height: MediaQuery.of(context).size.height / 6,
                    color: Colors.white,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                    height: MediaQuery.of(context).size.height / 2.3,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Ưu đãi từ Bánh Mì Pew Pew'),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, top: 15),
                                    color: Colors.white,
                                    height: 100,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          //color: Colors.red,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Image.network(
                                              'http://lorempixel.com/640/480/food',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  9,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text('Bánh mì Giáng Sinh'),
                                                Text(
                                                  'Bánh Mì Pew Pew',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12),
                                                ),
                                                Spacer(),
                                                Divider(
                                                  color: Colors.black87,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        ),
                        Spacer(),
                        Divider(color: Colors.black87),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text('Xem tất cả (5)',
                              style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 18,
                    margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                    //padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return ListEndow();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Xem tất cả ưu đãi',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
            Center(child: Text('Không có ưu đãi')),
          ],
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
            children: <Widget>[Text('Khách hàng mới')],
          ),
        ),
      ),
    );
  }
}
