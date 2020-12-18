import 'package:Food_Order/models/discount_code.dart';

class AmountResponse {
  int amount;
  DiscountCode discountCode;
  bool isError;

  AmountResponse({
    this.amount,
    this.discountCode,
    this.isError,
  });

  factory AmountResponse.fromJson(Map<String, dynamic> map) {
    return AmountResponse(
      amount: map['amount'],
      discountCode: map["discountCode"] != null
          ? DiscountCode.fromJson(map["discountCode"])
          : null,
      isError: map['isError'],
    );
  }
  Map<String, dynamic> toJson() => {
        "amount": amount,
        "discountCode": discountCode,
        "isError": isError,
      };
}
