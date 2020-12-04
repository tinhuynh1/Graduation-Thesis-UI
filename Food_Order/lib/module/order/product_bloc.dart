import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/data/repo/product_repo.dart';
import 'package:Food_Order/base/base_bloc.dart';
import 'package:Food_Order/event/quantity_event.dart';
import 'package:Food_Order/models/product/parent_category.dart';
import 'package:Food_Order/models/product/product_details.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc extends BaseBloc with ChangeNotifier {
  final ProductRepo _productRepo;
  final _idProduct = BehaviorSubject<int>();

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
      case QuantityEvent:
        break;
    }
  }

  Stream<List<ParentCategory>> getParentCategoryList() {
    print('call API');
    return Stream<List<ParentCategory>>.fromFuture(
      _productRepo.getParentCategoryList(),
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

  // Stream<ProductDetails> getProductDetailsByIdCache() {
  //   return Stream<ProductDetails>.fromFuture(
  //     _productRepo.getProductDetailsCache(),
  //   );
  // }

  @override
  void dispose() {
    super.dispose();

    _idProduct.close();
    print("homepage close");
  }
}
