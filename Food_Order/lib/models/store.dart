class Store {
  int branchId;
  String branchName;
  String address;
  String openTime;
  String closeTime;
  double lat;
  double long;
  DateTime createDate;
  DateTime updateDate;
  String status;
  String image;

  Store(
      {this.branchId,
      this.branchName,
      this.address,
      this.openTime,
      this.closeTime,
      this.lat,
      this.long,
      this.createDate,
      this.updateDate,
      this.status,
      this.image});
  static List<Store> parseStoreList(map) {
    var list = map['data'] as List;
    return list.map((store) => Store.fromJson(store)).toList();
  }

  factory Store.fromJson(Map<String, dynamic> map) => Store(
        branchId: map['branchId'],
        branchName: map['branchName'],
        address: map['address'],
        openTime: map['openTime'],
        closeTime: map['closeTime'],
        lat: map['lat'],
        long: map['long'],
        createDate: map['createDate'],
        updateDate: map['updateDate'],
        status: map['status'],
        image: map['image'],
      );
  Map<String, dynamic> toJson() => {};
}
