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
        customerId: map['customerId'],
        accountId: map['accountId'],
        avatar: map['avatar'],
        customerName: map['customerName'],
        phoneNumber: map['phoneNumber'],
        dateOfBirth: DateTime.parse(map["dateOfBirth"]),
        status: map['status']);
  }
}
