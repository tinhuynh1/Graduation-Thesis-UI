import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/reward_service.dart';
import 'package:Food_Order/data/repo/reward_repo.dart';
import 'package:Food_Order/models/category_rewards.dart';
import 'package:Food_Order/module/account/rewards/list_endow_page.dart';
import 'package:Food_Order/module/account/rewards/my_coupon_page.dart';
import 'package:Food_Order/module/account/rewards/reward_bloc.dart';
import 'package:Food_Order/shared/widget/appbar.dart';
import 'package:Food_Order/shared/widget/skeleton/loading_rewards_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RewardsStorePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return PageContainer(di: [
      Provider.value(
        value: RewardService(),
      ),
      ProxyProvider<RewardService, RewardRepo>(
        update: (context, rewardService, previous) =>
            RewardRepo(rewardService: rewardService),
      )
    ], bloc: [], child: RewardsStoreScreen());
  }
}

class RewardsStoreScreen extends StatefulWidget {
  @override
  _RewardsStoreScreenState createState() => _RewardsStoreScreenState();
}

class _RewardsStoreScreenState extends State<RewardsStoreScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => RewardBloc(rewardRepo: Provider.of(context)),
        child: Consumer<RewardBloc>(builder: (context, bloc, child) {
          return Scaffold(
              backgroundColor: Color(0xfff0eff4),
              appBar: AppBarCustom(
                text: 'Cửa hàng ưu đãi',
              ),
              body: StreamProvider.value(
                  value: bloc.getListCategoryReward(),
                  initialData: null,
                  catchError: (context, error) {
                    return error;
                  },
                  child: Consumer<Object>(builder: (context, data, child) {
                    if (data == null) {
                      return LoadingRewardsPage();
                    }
                    var response = data as List<CategoryReeards>;
                    return Column(
                      children: [
                        Expanded(
                            child: TabBarDemo(
                          list: response,
                        )),
                      ],
                    );
                  })));
        }));
  }
}

class TabBarDemo extends StatelessWidget {
  final List<CategoryReeards> list;

  const TabBarDemo({Key key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 15),
                    height: MediaQuery.of(context).size.height / 6,
                    color: Colors.white,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ListView.builder(
                            scrollDirection: Axis.horizontal,
                            //primary: false,
                            shrinkWrap: true,
                            itemCount: list.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ListEndowPage()),
                                );
                              },
                              child: Padding(
                                  padding: const EdgeInsets.only(top: 25),
                                  child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          list.length,
                                      child: Column(
                                        children: <Widget>[
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(90),
                                              child: Image(
                                                image: NetworkImage(
                                                    list[index].icon),
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover,
                                              )),
                                          Text(list[index].name)
                                        ],
                                      ))),
                            ),
                          ),
                        ]),
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
                            Text('Ưu đãi từ cửa hàng'),
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
                                                Text('Bánh mì bơ sữa'),
                                                Text(
                                                  'Bánh Mì',
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
                          padding: const EdgeInsets.only(top: 10),
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
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return ListEndowPage();
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
            MyCouponPage(),
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
          height: 50,
          child: Row(
            children: <Widget>[Text('Khách hàng mới')],
          ),
        ),
      ),
    );
  }
}
