import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/shared/ultil/cards.dart';
import 'package:Food_Order/shared/widget/home_tile.dart';
import 'package:Food_Order/shared/widget/map.dart';
import 'package:Food_Order/shared/widget/slider_home.dart';
import 'package:flutter/material.dart';

class StorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [],
      bloc: [],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'Store',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.grey.shade200,
        body: Map(),
      ),
    );
  }
}
