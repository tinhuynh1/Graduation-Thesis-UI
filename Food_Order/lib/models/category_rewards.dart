class CategoryReeards {
  String icon;
  String name;
  int rewardCategoryId;

  CategoryReeards({this.icon, this.name, this.rewardCategoryId});
  static List<CategoryReeards> parseRewardCategoryList(map) {
    var list = map['data'] as List;
    return list
        .map((parentCategory) => CategoryReeards.fromJson(parentCategory))
        .toList();
  }

  factory CategoryReeards.fromJson(Map<String, dynamic> map) => CategoryReeards(
        icon: map["icon"],
        name: map["name"],
        rewardCategoryId: map['rewardCategoryId'],
      );

  Map<String, dynamic> toJson() =>
      {"icon": icon, "name": name, "rewardCategoryId": rewardCategoryId};
}
