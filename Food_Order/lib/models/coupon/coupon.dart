class Coupon {
  int discountCodeId;
  String name;
  String image;
  DateTime startDate;
  DateTime endDate;

  Coupon({
    this.discountCodeId,
    this.name,
    this.image,
    this.startDate,
    this.endDate,
  });
  static List<Coupon> parseCouponList(map) {
    var list = map['data'] as List;
    return list.map((coupon) => Coupon.fromJson(coupon)).toList();
  }

  factory Coupon.fromJson(Map<String, dynamic> map) => Coupon(
        discountCodeId: map["discountCodeId"],
        name: map["name"],
        image: map["image"],
        startDate: DateTime.parse(map['startDate'].toString()),
        endDate: DateTime.parse(map['endDate'].toString()),
      );

  Map<String, dynamic> toJson() => {
        "discountCodeId": discountCodeId,
        "name": name,
        "image": image,
        "startDate": startDate,
        "endDate": endDate
      };
}
