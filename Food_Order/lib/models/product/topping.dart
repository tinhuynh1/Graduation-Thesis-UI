class Topping {
  double price;
  int toppingId;
  String toppingName;
  Topping({
    this.price,
    this.toppingId,
    this.toppingName,
  });
  factory Topping.fromJson(Map<String, dynamic> map) => Topping(
        price: double.tryParse(map['price'].toString()) ?? 0,
        toppingId: map["toppingId"],
        toppingName: map["toppingName"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "toppingId": toppingId,
        "toppingName": toppingName,
      };
}
