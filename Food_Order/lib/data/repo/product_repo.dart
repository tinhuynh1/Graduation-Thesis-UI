import 'dart:async';

import 'package:Food_Order/data/remote/product_service.dart';
import 'package:Food_Order/data/repo/rest_error.dart';
import 'package:Food_Order/models/product/parent_category.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class ProductRepo {
  ProductService _productService;

  ProductRepo({@required ProductService productService})
      : _productService = productService;

  Future<List<ParentCategory>> getParentCategoryList() async {
    var c = Completer<List<ParentCategory>>();
    try {
      var response = await _productService.getParentCategoryList();
      var parentCategoryList = ParentCategory.parseParentCategoryList(response.data);
      c.complete(parentCategoryList);
    } on DioError {
      c.completeError(RestError.fromData('Không có dữ liệu'));
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }
}
