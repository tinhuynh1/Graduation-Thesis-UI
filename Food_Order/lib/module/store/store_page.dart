import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/module/store/map.dart';
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
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            )),
        backgroundColor: Colors.grey.shade200,
        body: Stack(
          children: [
            Map(),
            Column(
              children: <Widget>[
                //SizedBox(height: 15),
                Container(
                  margin: EdgeInsets.all(15),
                  width: double.infinity,
                  height: 45,
                  //color: Colors.white,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Text('Chọn khu vực'),
                      Spacer(),
                      Icon(Icons.arrow_drop_down)
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
