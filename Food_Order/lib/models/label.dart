class Label {
  String description;
  String image;
  int labelId;
  String labelName;
  int point;

  Label({
    this.description,
    this.image,
    this.labelId,
    this.labelName,
    this.point,
  });
  static List<Label> parseLabelList(map) {
    var list = map['data'] as List;
    return list.map((label) => Label.fromJson(label)).toList();
  }

  factory Label.fromJson(Map<String, dynamic> map) {
    return Label(
      description: map['description'],
      image: map['image'],
      labelId: map['labelId'],
      labelName: map['labelName'],
      point: map['point'],
    );
  }
  Map<String, dynamic> toJson() => {
        "description": description,
        "image": image,
        "labelId": labelId,
        "labelName": labelName,
        "point": point,
      };
}
