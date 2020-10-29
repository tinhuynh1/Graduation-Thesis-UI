import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageContainer extends StatelessWidget {
  final Widget child;

  final List<SingleChildCloneableWidget> bloc;
  final List<SingleChildCloneableWidget> di;

  PageContainer({this.bloc, this.di, this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        //appBar: AppBar(),
        body: MultiProvider(
          providers: [
            ...di,
            ...bloc,
          ],
          child: child,
        ),
      ),
    );
  }
}
