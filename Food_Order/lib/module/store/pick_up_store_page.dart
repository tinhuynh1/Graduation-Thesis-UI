import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/store_service.dart';
import 'package:Food_Order/data/repo/store_repo.dart';
import 'package:Food_Order/data/state/attribute_state.dart';
import 'package:Food_Order/event/pick_up_store_event.dart';
import 'package:Food_Order/models/store.dart';
import 'package:Food_Order/module/store/store_bloc.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PickUpStorePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return PageContainer(
      di: [
        Provider.value(
          value: StoreService(),
        ),
        ProxyProvider<StoreService, StoreRepo>(
          update: (context, storeService, previous) =>
              StoreRepo(storeService: storeService),
        ),
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
            'Chọn cửa hàng',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 15),
          ),
        ),
        body: PickUpStoreScreen(),
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 20),
          height: 75,
          //color: Colors.white,
          child: RaisedButton(
            onPressed: () {},
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.red)),
            color: Colors.red,
            textColor: Colors.white,
            child: Text('Chọn cửa hàng'),
          ),
        ),
      ),
    );
  }
}

class PickUpStoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: StoreBloc.getInstance(storeRepo: Provider.of(context)),
      child: Consumer<StoreBloc>(
          builder: (context, bloc, child) => Container(
              child: StreamProvider.value(
                  value: bloc.getStoreList(CurrentLocation.location.lat,
                      CurrentLocation.location.lng),
                  initialData: null,
                  catchError: (context, error) {
                    return error;
                  },
                  child: Consumer<Object>(builder: (context, data, child) {
                    var listStore = data as List<Store>;
                    return Column(
                      children: [
                        Container(
                          color: Colors.white,
                          height: 56,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 8,
                                padding: EdgeInsets.only(top: 10, left: 15),
                                child: Row(
                                  children: <Widget>[
                                    Column(children: [
                                      Text('Danh mục'),
                                      Text('Danh mục'),
                                    ]),
                                    Spacer(),
                                    Icon(Icons.arrow_drop_down)
                                  ],
                                ),
                              ),
                              VerticalDivider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 8,
                                padding: EdgeInsets.only(top: 10, left: 15),
                                child: Row(
                                  children: <Widget>[
                                    Column(children: [
                                      Text('Sắp xếp theo'),
                                      Text('Danh mục'),
                                    ]),
                                    Spacer(),
                                    Icon(Icons.arrow_drop_down)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          color: Colors.white,
                          child: ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: listStore.length,
                              itemBuilder: (context, index) => Column(
                                    children: [
                                      Container(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 0, 0, 5),
                                          child: Row(
                                            children: [
                                              StreamBuilder<AttributeState>(
                                                  stream: bloc
                                                      .valueController.stream,
                                                  initialData: bloc.value,
                                                  builder: (BuildContext
                                                          context,
                                                      AsyncSnapshot<
                                                              AttributeState>
                                                          snapshot) {
                                                    return Radio(
                                                        value: index,
                                                        groupValue:
                                                            snapshot.data.value,
                                                        onChanged: (index) {
                                                          bloc.event.add(
                                                              PickUpStoreEvent(
                                                                  index,
                                                                  listStore[
                                                                      index]));
                                                        });
                                                  }),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      listStore[index].address),
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        'Khoảng cách :${listStore[index].distance}',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Spacer(),
                                              Icon(
                                                Icons.location_on,
                                                color: Colors.red,
                                              )
                                            ],
                                          )),
                                      Divider(
                                        color: Colors.grey,
                                      )
                                    ],
                                  )),
                        ),
                      ],
                    );
                  })))),
    );
  }
}
