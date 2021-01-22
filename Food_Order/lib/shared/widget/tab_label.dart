import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/data/repo/user_repo.dart';
import 'package:Food_Order/models/label.dart';
import 'package:Food_Order/module/account/rewards/label_bloc.dart';
import 'package:Food_Order/shared/widget/custom_tab_view.dart';
import 'package:Food_Order/shared/widget/skeleton_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LabelWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [
        Provider.value(
          value: UserService(),
        ),
        ProxyProvider<UserService, UserRepo>(
          update: (context, userService, previous) =>
              UserRepo(userService: userService),
        )
      ],
      bloc: [],
      child: TabLabelWidget(),
    );
  }
}

class TabLabelWidget extends StatefulWidget {
  @override
  _TabLabelWidgetState createState() => _TabLabelWidgetState();
}

class _TabLabelWidgetState extends State<TabLabelWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: LabelBloc.getInstance(userRepo: Provider.of(context)),
      child: Consumer<LabelBloc>(
        builder: (context, bloc, child) => Container(
          child: StreamProvider<Object>.value(
            value: bloc.getListLabel(),
            initialData: null,
            catchError: (context, error) {
              return error;
            },
            child: Consumer<Object>(builder: (context, data, child) {
              if (data == null) {
                return Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SkeletonContainer.square(
                          height: MediaQuery.of(context).size.height / 4.3,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ],
                  ),
                );
              }
              var listLabel = data as List<Label>;
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
                height: MediaQuery.of(context).size.height / 4.3,
                width: MediaQuery.of(context).size.width,
                child: CustomTabView(
                    initPosition: 0,
                    itemCount: listLabel.length,
                    tabBuilder: (context, index) => Tab(
                          icon: Container(
                            width: double.infinity,
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image(
                                    image: NetworkImage(listLabel[index].image),
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    listLabel[index].labelName,
                                    style: TextStyle(fontSize: 10),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    pageBuilder: (context, index) => Container(
                          color: Colors.white,
                          child: Center(
                            child: Text(listLabel[index].description),
                          ),
                        )),
              );
            }),
          ),
        ),
      ),
    );
  }
}
