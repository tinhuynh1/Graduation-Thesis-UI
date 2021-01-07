import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/models/product/product.dart';
import 'package:flutter/material.dart';

class SearchProductEvent extends BaseEvent {
  String keyword;
  List<Product> listProduct;
  SearchProductEvent({@required this.keyword, @required this.listProduct});
}
