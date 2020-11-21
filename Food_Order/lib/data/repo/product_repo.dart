import 'dart:async';

import 'package:Food_Order/data/remote/product_service.dart';
import 'package:Food_Order/data/repo/rest_error.dart';
import 'package:Food_Order/models/product/parent_category.dart';
import 'package:Food_Order/models/product/product_details.dart';
import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class ProductRepo {
  AsyncMemoizer<List<ParentCategory>> memCache = AsyncMemoizer();
  AsyncMemoizer<ProductDetails> memCacheDetails = AsyncMemoizer();
  ProductService _productService;

  ProductRepo({@required ProductService productService})
      : _productService = productService;

  Future<List<ParentCategory>> getParentCategoryList() async {
    return memCache.runOnce(() async {
      print('fecth data');
      var c = Completer<List<ParentCategory>>();
      try {
        var response = await _productService.getParentCategoryList();
        var parentCategoryList =
            ParentCategory.parseParentCategoryList(response.data);
        c.complete(parentCategoryList);
      } on DioError {
        c.completeError(RestError.fromData('Không có dữ liệu'));
      } catch (e) {
        c.completeError(e);
      }
      return c.future;
    });
  }

  Future<ProductDetails> getDetailsProdctById(int id) async {
    return memCacheDetails.runOnce(() async {
      var c = Completer<ProductDetails>();
      try {
        var response = await _productService.getDetailsProductById(id);
        var productDetails = ProductDetails.fromJson((response.data["data"]));
        c.complete(productDetails);
      } on DioError {
        c.completeError(RestError.fromData('Không có dữ liệu'));
      } catch (e) {
        c.completeError(e);
      }
      return c.future;
    });
  }
}
