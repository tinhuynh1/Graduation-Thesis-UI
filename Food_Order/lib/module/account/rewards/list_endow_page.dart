import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/reward_service.dart';
import 'package:Food_Order/data/repo/reward_repo.dart';
import 'package:Food_Order/models/reward.dart';
import 'package:Food_Order/module/account/rewards/detail_reward_page.dart';
import 'package:Food_Order/module/account/rewards/reward_bloc.dart';
import 'package:Food_Order/shared/widget/card/reward_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListEndowPage extends StatelessWidget {
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
            'Danh sách ưu đãi',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 15),
          ),
        ),
        body: ListEnddowScreen(),
      ),
    );
  }
}

class ListEnddowScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RewardBloc(rewardRepo: Provider.of(context)),
      child: Consumer<RewardBloc>(
          builder: (context, bloc, child) => Container(
              child: StreamProvider.value(
                  value: bloc.getListReward(),
                  initialData: null,
                  catchError: (context, error) {
                    return error;
                  },
                  child: Consumer<Object>(builder: (context, data, child) {
                    var listReward = data as List<Rewards>;
                    return Container(
                      margin: EdgeInsets.only(top: 15),
                      height: double.infinity,
                      color: Colors.white,
                      child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: listReward.length,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailRewardPage(
                                            id: listReward[index].rewardId)),
                                  );
                                },
                                child: RewardCard(
                                    image: listReward[index].image,
                                    name: listReward[index].name,
                                    point: listReward[index].point),
                              )),
                    );
                  })))),
    );
  }
}
