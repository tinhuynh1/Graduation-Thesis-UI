import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/base/base_bloc.dart';
import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/data/repo/store_repo.dart';
import 'package:Food_Order/models/store.dart';
import 'package:flutter/material.dart';

class StoreBloc extends BaseBloc with ChangeNotifier {
  final StoreRepo _storeRepo;

  static StoreBloc _instance;

  static StoreBloc getInstance({
    @required StoreRepo storeRepo,
  }) {
    if (_instance == null) {
      _instance = StoreBloc._internal(
        storeRepo: storeRepo,
      );
    }
    return _instance;
  }

  StoreBloc._internal({
    @required StoreRepo storeRepo,
  }) : _storeRepo = storeRepo;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
    }
  }

  Stream<List<Store>> getStoreList() {
    return Stream<List<Store>>.fromFuture(
      _storeRepo.getStoreList(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print("homepage close");
  }
}
