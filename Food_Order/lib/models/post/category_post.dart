import 'package:Food_Order/models/post/post.dart';

class CategoryPost {
  int categoryId;
  String categoryName;
  List<Post> listPost;

  CategoryPost({
    this.categoryId,
    this.categoryName,
    this.listPost,
  });
  static List<CategoryPost> parseCategoryPostList(map) {
    var list = map['data'] as List;
    return list
        .map((categoryPost) => CategoryPost.fromJson(categoryPost))
        .toList();
  }

  factory CategoryPost.fromJson(Map<String, dynamic> map) => CategoryPost(
        categoryId: map["categoryId"],
        categoryName: map["categoryName"],
        listPost: map['listPost'] != null
            ? map['listPost'].map<Post>((map) => Post.fromJson(map)).toList()
            : null,
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
        "listPost": listPost,
      };
}
