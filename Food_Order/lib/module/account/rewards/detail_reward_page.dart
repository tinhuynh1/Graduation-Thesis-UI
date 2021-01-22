import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/reward_service.dart';
import 'package:Food_Order/data/repo/reward_repo.dart';
import 'package:Food_Order/event/exchange/exchange_event.dart';
import 'package:Food_Order/event/exchange/exchange_fail_event.dart';
import 'package:Food_Order/event/exchange/exchange_successfully_event.dart';
import 'package:Food_Order/models/detail_reward.dart';
import 'package:Food_Order/module/account/rewards/reward_bloc.dart';
import 'package:Food_Order/shared/widget/bloc_listener.dart';
import 'package:Food_Order/shared/widget/skeleton/loading_detail_reward.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailRewardPage extends StatelessWidget {
  final int id;

  const DetailRewardPage({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PageContainer(
        di: [
          Provider.value(
            value: RewardService(),
          ),
          ProxyProvider<RewardService, RewardRepo>(
            update: (context, rewardService, previous) =>
                RewardRepo(rewardService: rewardService),
          )
        ],
        bloc: [],
        child: DetailRewardScreen(
          id: id,
        ));
  }
}

class DetailRewardScreen extends StatefulWidget {
  final int id;

  const DetailRewardScreen({Key key, this.id}) : super(key: key);
  @override
  _DetailRewardScreenState createState() => _DetailRewardScreenState();
}

class _DetailRewardScreenState extends State<DetailRewardScreen> {
  final controller = ScrollController();
  handleEvent(BaseEvent event) async {
    if (event is ExchangeSuccessEvent) {
      showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.only(bottom: 10),
              content: Builder(builder: (context) {
                return Container(
                  child: Wrap(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text('Thông báo'),
                      ),
                      Divider(
                        height: 2,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          event.message,
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                      Divider(),
                      Row(
                        children: [
                          Spacer(),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "OK",
                              style: TextStyle(color: Colors.red),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }));
        },
      );
      return;
    }
    if (event is ExchangeFailEvent) {
      showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.only(bottom: 10),
              content: Builder(builder: (context) {
                return Container(
                  child: Wrap(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text('Thông báo'),
                      ),
                      Divider(
                        height: 2,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          event.errMessage,
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                      Divider(),
                      Row(
                        children: [
                          Spacer(),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "OK",
                              style: TextStyle(color: Colors.red),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }));
        },
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('vi');
    return ChangeNotifierProvider(
      create: (_) => RewardBloc(rewardRepo: Provider.of(context)),
      child: Consumer<RewardBloc>(
        builder: (context, bloc, child) => BlocListener<RewardBloc>(
          listener: handleEvent,
          child: Container(
            child: StreamProvider<Object>.value(
              value: bloc.getDetailReward(widget.id),
              initialData: null,
              catchError: (context, error) {
                return error;
              },
              child: Consumer<Object>(builder: (context, data, child) {
                if (data == null) {
                  return LoadingDetailRewardPage();
                }
                var rewardDetails = data as DetailReward;
                return Scaffold(
                    body: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                            pinned: true,
                            expandedHeight: 200.0,
                            flexibleSpace: FlexibleSpaceBar(
                              //title: Text('Available seats'),
                              background: Image.network(
                                //rewardDetails.image,
                                "http://placeimg.com/640/480/food",
                                fit: BoxFit.fitWidth,
                              ),
                            )),
                        SliverToBoxAdapter(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                rewardDetails.name,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  _expireDateText(rewardDetails.createDate,
                                      rewardDetails.endDate),
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                rewardDetails.detail,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.loyalty, color: Colors.red),
                                      Text(rewardDetails.point.toString())
                                    ]),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Chi tiết ưu đãi',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // Text(
                                    //   rewardDetails.detail,
                                    // ),
                                    Text(
                                        "Est sunt inventore et repellendus voluptatem labore. Eum necessitatibus iusto dolore magni impedit. Et quos cum eum neque commodi ratione. Optio dignissimos neque dolorem adipisci. Voluptates repellat iure consequatur alias."),
                                    Text(
                                      'Thể lệ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    //Text(rewardDetails.rules),
                                    Text(
                                        "Est sunt inventore et repellendus voluptatem labore. Eum necessitatibus iusto dolore magni impedit. Et quos cum eum neque commodi ratione. Optio dignissimos neque dolorem adipisci. Voluptates repellat iure consequatur alias.")
                                  ],
                                ),
                              )
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
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.only(bottom: 10),
                                content: Builder(builder: (context) {
                                  return Container(
                                    // margin: EdgeInsets.only(left: 15, right: 15),
                                    child: Wrap(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Text(
                                              'Bạn có muốn  đổi ưu đãi này'),
                                        ),
                                        Divider(
                                          height: 2,
                                          color: Colors.grey,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Text(
                                            'Đổi ưu đãi này với ' +
                                                rewardDetails.point.toString() +
                                                ' điểm',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                          ),
                                        ),
                                        Divider(),
                                        Row(
                                          children: [
                                            Spacer(),
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                "Hủy bỏ",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            FlatButton(
                                              color: Colors.red,
                                              onPressed: () {
                                                bloc.event.add(ExchangeEvent(
                                                    rewardId: rewardDetails
                                                        .rewardId));
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                "Đồng ý",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }),
                              );
                            },
                          );
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.red)),
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Text('Đổi ngay'),
                      ),
                    ));
              }),
            ),
          ),
        ),
      ),
    );
  }

  String _expireDateText(DateTime start, DateTime end) {
    var str = 'Có hiệu lực ' +
        DateFormat.yMd('vi').format(start) +
        ' đến ' +
        DateFormat.yMd('vi').format(end);
    return str;
  }
}
