import 'package:Food_Order/models/customer.dart';

class Comment {
  String content;
  DateTime createDate;
  Customer customer;

  Comment({
    this.content,
    this.createDate,
    this.customer,
  });
  static List<Comment> parseCommentList(map) {
    var list = map['data'] as List;
    return list != null
        ? list.map((comment) => Comment.fromJson(comment)).toList()
        : null;
  }

  factory Comment.fromJson(Map<String, dynamic> map) => Comment(
      content: map['content'],
      createDate: DateTime.parse(map['createDate'].toString()),
      customer:
          map["customer"] != null ? Customer.fromJson(map["customer"]) : null);
}
