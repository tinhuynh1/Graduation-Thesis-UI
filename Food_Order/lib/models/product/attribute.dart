class Attribute {
  int attributeId;
  String attributeName;

  Attribute({this.attributeId, this.attributeName});

  factory Attribute.fromJson(Map<String, dynamic> map) => Attribute(
        attributeId: map['attributeId'],
        attributeName: map['attributeName'],
      );
  Map<String, dynamic> toJson() => {
        "attributeId": attributeId,
        "attributeName": attributeName,
      };
}
