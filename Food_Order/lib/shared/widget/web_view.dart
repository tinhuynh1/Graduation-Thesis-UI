import 'package:Food_Order/shared/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class WebViewContainer extends StatefulWidget {
  final String content;

  const WebViewContainer({Key key, this.content}) : super(key: key);

  @override
  createState() => _WebViewContainerState(this.content);
}

class _WebViewContainerState extends State<WebViewContainer> {
  final String content;

  _WebViewContainerState(this.content);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom(
          text: 'Legacy Group Engineer',
        ),
        body: Column(
          children: [
            Expanded(
              child: Html(
                data: content,
              ),
            )
          ],
        ));
  }
}
