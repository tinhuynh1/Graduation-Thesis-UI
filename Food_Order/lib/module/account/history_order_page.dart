import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/shared/widget/appbar.dart';
import 'package:Food_Order/shared/widget/card/history_card.dart';
import 'package:flutter/material.dart';

class HistoryOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [],
      bloc: [],
      child: Scaffold(
        appBar: AppBarCustom(text: 'Lịch sử đơn hàng'),
        backgroundColor: Color(0xfff0eff4),
        body: ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (context, index) => GestureDetector(
                  child: HistoryCard(),
                )),
      ),
    );
  }
}
