import 'package:Food_Order/models/product/category.dart';
import 'package:Food_Order/shared/ultil/category.dart';

class ParentCategory {
  int parentCategory;
  String parentCategoryName;
  List<Category> listChildrenCategory;

  ParentCategory(
      {this.parentCategory,
      this.parentCategoryName,
      this.listChildrenCategory});
  static List<ParentCategory> parseParentCategoryList(map) {
    var list = map['data'] as List;
    return list
        .map((parentCategory1) => ParentCategory.fromJson(parentCategory1))
        .toList();
  }

  factory ParentCategory.fromJson(Map<String, dynamic> map) => ParentCategory(
        parentCategory: map["parentCategory"],
        parentCategoryName: map["parentCategoryName"],
        listChildrenCategory: map['listChildrenCategory'] != null
            ? map['listChildrenCategory']
                .map<Category>((map) => Category.fromJson(map))
                .toList()
            : null,
      );

  Map<String, dynamic> toJson() => {
        "parentCategory": parentCategory,
        "parentCategoryName": parentCategoryName,
      };
}
