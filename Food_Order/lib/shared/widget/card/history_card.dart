import 'package:Food_Order/shared/widget/button/nomal_button.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
      padding: EdgeInsets.all(10),
      height: 165,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[300],
        ),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[],
          ),
          Divider(
            color: Colors.grey,
          ),
          Row(
            children: [
              Spacer(),
              NomalButton(
                text: 'Đặt lại',
                onPressed: null,
              ),
            ],
          )
        ],
      ),
    );
  }
}
