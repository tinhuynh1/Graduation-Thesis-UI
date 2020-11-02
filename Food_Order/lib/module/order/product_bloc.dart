import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/data/repo/product_repo.dart';
import 'package:Food_Order/base/base_bloc.dart';
import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/models/product/parent_category.dart';
import 'package:flutter/material.dart';

class ProductBloc extends BaseBloc with ChangeNotifier {
  final ProductRepo _productRepo;

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
      
    }
  }

  Stream<List<ParentCategory>> getParentCategoryList() {
    return Stream<List<ParentCategory>>.fromFuture(
      _productRepo.getParentCategoryList(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print("homepage close");
  }
}
