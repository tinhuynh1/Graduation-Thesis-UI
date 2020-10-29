import 'package:Food_Order/base/base_bloc.dart';
import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/data/repo/product_repo.dart';
import 'package:Food_Order/models/product.dart';
import 'package:flutter/material.dart';

class FoodBloc extends BaseBloc with ChangeNotifier {
  final ProductRepo _productRepo;
  //final OrderRepo _orderRepo;

  //var _shoppingCart = ShoppingCart();

  static FoodBloc _instance;

  static FoodBloc getInstance({
    @required ProductRepo productRepo,
    //@required OrderRepo orderRepo,
  }) {
    if (_instance == null) {
      _instance = FoodBloc._internal(
        productRepo: productRepo,
        //orderRepo: orderRepo,
      );
    }
    return _instance;
  }

  FoodBloc._internal({
    @required ProductRepo productRepo,
    //@required OrderRepo orderRepo,
  }) : _productRepo = productRepo;
  //_orderRepo = orderRepo;

  //final _shoppingCardSubject = BehaviorSubject<ShoppingCart>();

  //Stream<ShoppingCart> get shoppingCartStream => _shoppingCardSubject.stream;
  //Sink<ShoppingCart> get shoppingCartSink => _shoppingCardSubject.sink;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      // case AddToCartEvent:
      //   handleAddToCart(event);
      //   break;
    }
  }

  // handleAddToCart(event) {
  //   AddToCartEvent addToCartEvent = event as AddToCartEvent;
  //   _orderRepo.addToCart(addToCartEvent.product).then((shoppingCart) {
  //     _shoppingCart.orderId = shoppingCart.orderId;
  //     shoppingCartSink.add(shoppingCart);
  //   });
  // }

  // getShoppingCartInfo() {
  //   Stream<ShoppingCart>.fromFuture(_orderRepo.getShoppingCartInfo()).listen(
  //       (shoppingCart) {
  //     _shoppingCart = shoppingCart;
  //     shoppingCartSink.add(shoppingCart);
  //   }, onError: (err) {
  //     _shoppingCardSubject.addError(err);
  //   });
  // }

  Stream<List<Product>> getProductList() {
    return Stream<List<Product>>.fromFuture(
      _productRepo.getProductList(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print("homepage close");
    //_shoppingCardSubject.close();
  }
}
