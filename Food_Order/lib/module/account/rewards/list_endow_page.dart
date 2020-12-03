import 'package:Food_Order/base/base_widget.dart';
import 'package:flutter/material.dart';

class ListEndow extends StatelessWidget {
  Widget build(BuildContext context) {
    return PageContainer(
      di: [],
      bloc: [],
      child: Scaffold(
        backgroundColor: Colors.indigo[50],
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: Colors.grey[400],
                height: 0.5,
              ),
              preferredSize: Size.fromHeight(1.0)),
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black54,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'Danh sách ưu đãi',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 15),
          ),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height / 20,
            ),
            ListEndDow(),
          ],
        ),
      ),
    );
  }
}

class ListEndDow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
