import 'dart:async';

import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/data/repo/product_repo.dart';
import 'package:Food_Order/base/base_bloc.dart';
import 'package:Food_Order/data/state/search_state.dart';
import 'package:Food_Order/event/comment_event.dart';
import 'package:Food_Order/event/search_product_event.dart';
import 'package:Food_Order/models/comment.dart';
import 'package:Food_Order/models/product/parent_category.dart';
import 'package:Food_Order/models/product/product.dart' as product;
import 'package:Food_Order/models/product/product_details.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc extends BaseBloc with ChangeNotifier {
  final ProductRepo _productRepo;
  final _idProduct = BehaviorSubject<int>();
  List<product.Product> listProductSearch = [];
  var listProduct = SearchState([]);
  final searchController = StreamController<SearchState>.broadcast();

  static ProductBloc _instance;

  static ProductBloc getInstance({
    @required ProductRepo productRepo,
  }) {
    if (_instance == null) {
      _instance = ProductBloc._internal(
        productRepo: productRepo,
      );
    }
    return _instance;
  }

  ProductBloc._internal({
    @required ProductRepo productRepo,
  }) : _productRepo = productRepo;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case CommentEvent:
        handleComment(event);
        break;
      case SearchProductEvent:
        handleSearchProduct(event);
        break;
    }
  }

  handleSearchProduct(event) {
    SearchProductEvent e = event as SearchProductEvent;
    print('Search:' + e.keyword);
    listProduct = SearchState(e.listProduct);
    searchController.sink.add(listProduct);
  }

  handleComment(event) {
    loadingSink.add(true); // show loading
    CommentEvent e = event as CommentEvent;
    _productRepo.commentProduct(e.productId, e.content).then((value) => true);
  }

  Stream<List<ParentCategory>> getParentCategoryList() {
    print('call API');
    return Stream<List<ParentCategory>>.fromFuture(
      _productRepo.getParentCategoryList(),
    );
  }

  Stream<List<product.Product>> getAllProduct() {
    return Stream<List<product.Product>>.fromFuture(
      _productRepo.getAllProduct(),
    );
  }

  Stream<List<ParentCategory>> getParentCategoryListCache() {
    return Stream<List<ParentCategory>>.fromFuture(
      Helper.getListParentCategory(),
    );
  }

  Stream<ProductDetails> getProductDetailsById(int id) {
    return Stream<ProductDetails>.fromFuture(
      _productRepo.getDetailsProdctById(id),
    );
  }

  Stream<List<Comment>> getComments(int id) {
    return Stream<List<Comment>>.fromFuture(
      _productRepo.getComments(id),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _idProduct.close();
    searchController.close();
    print("homepage close");
  }
}
