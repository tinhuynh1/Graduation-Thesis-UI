class Post {
  int postId;
  String shortContent;
  String title;
  String poster;
  String  type;

  Post({
    this.postId,
    this.shortContent,
    this.title,
    this.poster,
    this.type,
  });
  static List<Post> parsePostList(map) {
    var list = map['data'] as List;
    return list.map((post) => Post.fromJson(post)).toList();
  }

  factory Post.fromJson(Map<String, dynamic> map) => Post(
        postId: map["postId"],
        shortContent: map["shortContent"],
        title: map["title"],
        poster: map["poster"],
        type: "type"
        
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "shortContent": shortContent,
        "title": title,
        "poster": poster,
        "type": type
      };
}
