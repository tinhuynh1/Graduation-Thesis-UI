class CouponDetail {
  String name;
  String code;
  String description;
  String qrCode;
  DateTime startDate;
  DateTime endDate;

  CouponDetail({
    this.name,
    this.description,
    this.code,
    this.qrCode,
    this.startDate,
    this.endDate,
  });

  factory CouponDetail.fromJson(Map<String, dynamic> map) => CouponDetail(
        name: map["name"],
        description: map["description"],
        code: map["code"],
        qrCode: map["qrCode"],
        startDate: DateTime.parse(map['startDate'].toString()),
        endDate: DateTime.parse(map['endDate'].toString()),
      );
}
