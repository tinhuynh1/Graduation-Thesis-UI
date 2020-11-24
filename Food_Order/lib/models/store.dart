class Store {
  String branchId;
  String branchName;
  String address;
  String openTime;
  String closeTime;
  double lat;
  double long;
  String distance;
  String mapStatic;
  String createDate;
  String updateDate;
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
      this.distance,
      this.mapStatic,
      this.createDate,
      this.updateDate,
      this.status,
      this.image});
  static List<Store> parseStoreList(map) {
    var list = map['data'] as List;
    return list.map((store) => Store.fromJson(store)).toList();
  }

  factory Store.fromJson(Map<String, dynamic> map) => Store(
        address: map['address'],
        branchId: map['branchId'],
        branchName: map['branchName'],
        closeTime: map['closeTime'],
        createDate: map['createDate'],
        openTime: map['openTime'],
        distance: map['distance'],
        image: map['image'],
        updateDate: map['updateDate'],
        lat: map['lat'],
        long: map['long'],
        mapStatic: map['mapStatic'],
        status: map['status'],
      );
  Map<String, dynamic> toJson() => {};
}
