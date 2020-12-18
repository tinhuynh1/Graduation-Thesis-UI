class DiscountCode {
  String code;
  int discountCodeId;
  String name;

  DiscountCode({
    this.code,
    this.discountCodeId,
    this.name,
  });
  factory DiscountCode.fromJson(Map<String, dynamic> map) {
    return DiscountCode(
      code: map['code'],
      discountCodeId: map['discountCodeId'],
      name: map['name'],
    );
  }
}
