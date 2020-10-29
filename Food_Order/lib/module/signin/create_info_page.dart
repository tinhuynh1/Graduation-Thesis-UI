import 'package:Food_Order/base/base_widget.dart';
import 'package:flutter/material.dart';

class CreateInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [],
      bloc: [],
      child: CreateInfoFormWidget(),
    );
  }
}

class CreateInfoFormWidget extends StatefulWidget {
  @override
  _CreateInfoFormWidgetState createState() => _CreateInfoFormWidgetState();
}

class _CreateInfoFormWidgetState extends State<CreateInfoFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Create info page"),
    );
  }
}
