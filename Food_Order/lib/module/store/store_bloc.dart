import 'dart:async';

import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/base/base_bloc.dart';
import 'package:Food_Order/data/repo/store_repo.dart';
import 'package:Food_Order/data/state/attribute_state.dart';
import 'package:Food_Order/event/pick_up_store_event.dart';
import 'package:Food_Order/models/store.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class StoreBloc extends BaseBloc with ChangeNotifier {
  var value = AttributeState(0);
  final valueController = StreamController<AttributeState>.broadcast();
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
      case PickUpStoreEvent:
        handlePickUpStore(event);
        break;
    }
  }

  handlePickUpStore(event) {
    PickUpStoreEvent e = event as PickUpStoreEvent;
    print("ban da chon cua hang co id la: ${e.store.branchId}");
    value = AttributeState(event.value);
    valueController.sink.add(value);
  }

  Stream<List<Store>> getStoreList(double lat, double lng) {
    final position =  Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print('Current Position is: ');
    print(position);
    return Stream<List<Store>>.fromFuture(
      _storeRepo.getStoreList(lat, lng),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print("homepage close");
  }
}
