class ProductCartResponse {
  String productNameA;
  int price;

  ProductCartResponse({this.productNameA, this.price});

  factory ProductCartResponse.fromJson(Map<String, dynamic> map) {
    return ProductCartResponse(
      productNameA: map['productName'],
      price: map['price'],
    );
  }
}
