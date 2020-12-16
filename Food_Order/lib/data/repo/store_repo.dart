import 'dart:async';

import 'package:Food_Order/data/remote/store_service.dart';
import 'package:Food_Order/data/repo/rest_error.dart';
import 'package:Food_Order/models/store.dart';
import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class StoreRepo {
  AsyncMemoizer<List<Store>> memCache = AsyncMemoizer();
  StoreService _storeService;

  StoreRepo({@required StoreService storeService})
      : _storeService = storeService;

  Future<List<Store>> getStoreList() async {
    return memCache.runOnce(() async {
      print('fecth data');
      var c = Completer<List<Store>>();
      try {
        var response = await _storeService.getStoreList();
        var parentSoteList = Store.parseStoreList(response.data);
        //Branchs.listStore = parentSoteList;
        c.complete(parentSoteList);
      } on DioError {
        c.completeError(RestError.fromData('Không có dữ liệu'));
      } catch (e) {
        c.completeError(e);
      }
      return c.future;
    });
  }
}
