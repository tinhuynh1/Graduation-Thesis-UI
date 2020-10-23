import 'package:Food_Order/models/product.dart';
import 'package:Food_Order/shared/widget/product_details.dart';
import 'package:flutter/material.dart';

class GridProduct extends StatelessWidget {
  final String name;
  final String img;
  final String price;

  GridProduct({
    Key key,
    @required this.name,
    @required this.img,
    this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        children: <Widget>[
          _buildProduct(product),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductDetails();
            },
          ),
        );
      },
    );
  }
}

Widget _buildProduct(Product product) {
  return Container(
    child: Container(
      // height: MediaQuery.of(context).size.height / 3.6,
      // width: MediaQuery.of(context).size.width / 2.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0)),
            child: Image.network(
              product.productImage,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
            child: Text('${product.productName}'),
          ),
          Spacer(),
          Divider(
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('${product.price} Đ'),
                //Spacer(),
                FlatButton(
                  height: 30,
                  onPressed: () {},
                  child: Text(
                    '+',
                    style: TextStyle(
                      color: Colors.orange,
                    ),
                  ),
                  shape: CircleBorder(
                    side: BorderSide(color: Colors.orange),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Colors.white),
  );
}
