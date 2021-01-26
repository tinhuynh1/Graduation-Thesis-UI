class StatusOrder {
  String status;
  DateTime transactionTime;
  StatusOrder({
    this.status,
    this.transactionTime,
  });
  static List<StatusOrder> parseStatusOrderList(map) {
    var list = map['listTransaction'] as List;
    return list
        .map((listTransaction) => StatusOrder.fromJson(listTransaction))
        .toList();
  }

  factory StatusOrder.fromJson(Map<String, dynamic> map) => StatusOrder(
        status: map["status"],
        transactionTime: DateTime.parse(map["transactionTime"].toString()),
      );
}
