import 'package:Food_Order/base/base_event.dart';
import 'package:flutter/material.dart';

class CommentEvent extends BaseEvent {
  int productId;
  String content;
  CommentEvent({
    @required this.productId,
    @required this.content,
  });
}
