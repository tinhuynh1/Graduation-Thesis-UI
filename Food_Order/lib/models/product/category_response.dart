class CategoryResponse {
  int categoryId;
  int parentId;
  String name;
  CategoryResponse({this.categoryId, this.parentId, this.name});
  static List<CategoryResponse> parseCategoryResponseList(map) {
    var list = map['data'] as List;
    return list.map((category) => CategoryResponse.fromJson(category)).toList();
  }

  factory CategoryResponse.fromJson(Map<String, dynamic> map) =>
      CategoryResponse(
          categoryId: map["CategoryId"],
          name: map["Name"],
          parentId: map["ParentId"]);
}
