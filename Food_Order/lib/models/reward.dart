class Rewards {
  String image;
  String name;
  int point;
  int rewardId;

  Rewards({this.image, this.name, this.point, this.rewardId});
  static List<Rewards> parseRewardList(map) {
    var list = map['data'] as List;
    return list.map((listReward) => Rewards.fromJson(listReward)).toList();
  }

  factory Rewards.fromJson(Map<String, dynamic> map) => Rewards(
      image: map["image"],
      name: map["name"],
      point: map['point'],
      rewardId: map['rewardId']);

  Map<String, dynamic> toJson() =>
      {"image": image, "name": name, "point": point};
}
