class Customer {
  String customerId;
  String accountId;
  String avatar;
  String customerName;
  String phoneNumber;
  DateTime dateOfBirth;
  String status;
  Customer(
      {this.customerId,
      this.accountId,
      this.avatar,
      this.customerName,
      this.phoneNumber,
      this.dateOfBirth,
      this.status});
  factory Customer.fromJson(Map<String, dynamic> map) {
    return Customer(
        accountId: map['accountId'],
        avatar: map['avatar'],
        customerId: map['customerId'],
        customerName: map['customerName'],
        dateOfBirth: DateTime.parse(map["dateOfBirth"].toString()),
        phoneNumber: map['phoneNumber'],
        status: map['status']);
  }
  Map<String, dynamic> toJson() => {
        "accountId": accountId,
        "avatar": avatar,
        "customerId": customerId,
        "customerName": customerName,
        "dateOfBirth": dateOfBirth.toIso8601String(),
        "phoneNumber": phoneNumber,
        "status": status
      };
}
