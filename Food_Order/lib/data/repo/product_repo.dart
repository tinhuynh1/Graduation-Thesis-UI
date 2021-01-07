import 'dart:async';

import 'package:Food_Order/data/remote/product_service.dart';
import 'package:Food_Order/data/repo/rest_error.dart';
import 'package:Food_Order/data/spref/spref.dart';
import 'package:Food_Order/models/comment.dart';
import 'package:Food_Order/models/product/parent_category.dart';
import 'package:Food_Order/models/product/product.dart' as product;
import 'package:Food_Order/models/product/product_details.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class ProductRepo {
  AsyncMemoizer<List<ParentCategory>> memCache = AsyncMemoizer();
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
        SPref.instance.set(SPrefCache.KEY_PRODUCT, response.toString());
        //print(response.data['data'].toString());
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
  }

  Future<List<Comment>> getComments(int id) async {
    var c = Completer<List<Comment>>();
    try {
      var response = await _productService.getComments(id);
      var commentList = Comment.parseCommentList(response.data);

      c.complete(commentList);
    } on DioError {
      c.completeError(RestError.fromData('Không có dữ liệu'));
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<bool> commentProduct(int productId, String content) async {
    var c = Completer<bool>();
    try {
      var response = await _productService.commentProdcuct(productId, content);
      print(response.toString());
      c.complete(true);
    } on DioError {
      c.completeError(RestError.fromData('Lỗi comment product '));
    } catch (e) {
      print('loi roi abe oi');
      c.completeError(e);
    }
    return c.future;
  }

  Future<List<product.Product>> getAllProduct() async {
    var c = Completer<List<product.Product>>();
    try {
      var response = await _productService.getAllProduct();
      var allProduct = product.Product.parseProductList(response.data);
      c.complete(allProduct);
    } on DioError {
      c.completeError(RestError.fromData('Không có dữ liệu'));
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }
}
