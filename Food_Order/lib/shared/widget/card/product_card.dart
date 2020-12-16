import 'package:Food_Order/models/product/parent_category.dart';
import 'package:Food_Order/module/order/product_details.dart';
import 'package:Food_Order/shared/size_config.dart';
import 'package:Food_Order/shared/widget/format_money.dart';
import 'package:flutter/material.dart';

class CardProduct extends StatelessWidget {
  final int idProduct;
  final List<ParentCategory> listParentCategory;
  final int parentCategoryIndex;
  final int categoryIndex;
  final int productIndex;

  const CardProduct({
    Key key,
    this.idProduct,
    this.parentCategoryIndex,
    this.productIndex,
    this.listParentCategory,
    this.categoryIndex,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                    id: idProduct,
                  )),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 7,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[300],
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  topRight: Radius.circular(5.0)),
              child: Image.network(
                listParentCategory[parentCategoryIndex]
                    .listChildrenCategory[categoryIndex]
                    .listProduct[productIndex]
                    .image,
                height: SizeConfig.screenHeight / 6.5,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
              child: Text(
                listParentCategory[parentCategoryIndex]
                    .listChildrenCategory[categoryIndex]
                    .listProduct[productIndex]
                    .productName,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Spacer(),
            Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 0, 15),
              child: Text(
                FormatMoney.format(listParentCategory[parentCategoryIndex]
                    .listChildrenCategory[categoryIndex]
                    .listProduct[productIndex]
                    .price),
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
