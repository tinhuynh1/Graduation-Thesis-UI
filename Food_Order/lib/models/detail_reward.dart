class DetailReward {
  String image;
  String name;
  String detail;
  DateTime createDate;
  DateTime endDate;
  int point;
  int rewardId;
  String rules;

  DetailReward(
      {this.name,
      this.detail,
      this.createDate,
      this.endDate,
      this.point,
      this.image,
      this.rewardId,
      this.rules});

  factory DetailReward.fromJson(Map<String, dynamic> map) => DetailReward(
      rules: map['rules'],
      image: map["image"],
      name: map["name"],
      detail: map["detail"],
      point: map["point"],
      createDate: DateTime.parse(map['createDate'].toString()),
      endDate: DateTime.parse(map['endDate'].toString()),
      rewardId: map['rewardId']);
}
