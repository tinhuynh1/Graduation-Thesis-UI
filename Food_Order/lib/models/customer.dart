import 'package:Food_Order/models/label.dart';

class Customer {
  String customerId;
  String accountId;
  String avatar;
  String customerName;
  String phoneNumber;
  DateTime dateOfBirth;
  String status;
  Label label;
  String barCode;
  int point;

  Customer(
      {this.customerId,
      this.accountId,
      this.avatar,
      this.customerName,
      this.phoneNumber,
      this.dateOfBirth,
      this.status,
      this.label,
      this.barCode,
      this.point});
  factory Customer.fromJson(Map<String, dynamic> map) {
    return Customer(
        accountId: map['accountId'],
        avatar: map['avatar'],
        barCode: map['barCode'],
        customerId: map['customerId'],
        customerName: map['customerName'],
        dateOfBirth: DateTime.parse(map["dateOfBirth"].toString()),
        label: map["label"] != null ? Label.fromJson(map["label"]) : null,
        phoneNumber: map['phoneNumber'],
        status: map['status'],
        point: map['point']);
  }
  Map<String, dynamic> toJson() => {
        "accountId": accountId,
        "avatar": avatar,
        "customerId": customerId,
        "customerName": customerName,
        "dateOfBirth": dateOfBirth.toIso8601String(),
        "phoneNumber": phoneNumber,
        "status": status,
        "label": label != null ? label.toJson() : null,
        "barCode": barCode,
        "point": point,
      };
}
