import 'package:Food_Order/shared/constant.dart';
import 'package:Food_Order/shared/widget/format_money.dart';
import 'package:flutter/material.dart';

class ProductCart extends StatefulWidget {
  final int index;

  ProductCart({@required this.index});
  @override
  _ProductCartState createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
      color: Colors.white,
      child: Row(
        children: [
          Row(
            children: <Widget>[
              Container(
                  width: 30,
                  child: Text(
                    ListProduct.listProduct[widget.index].quantity.toString(),
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          ),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 35,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              ListProduct.listProduct[widget.index].product
                                  .productName,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87)),
                          Text(FormatMoney.format(
                              ListProduct.listProduct[widget.index].total)),
                        ],
                      ),
                      ListProduct.listProduct[widget.index].product.attribute !=
                              null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                    ListProduct
                                        .listProduct[widget.index]
                                        .product
                                        .listProductOption[ListProduct
                                            .listProduct[widget.index]
                                            .atrributeId]
                                        .attributeValue,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey)),
                                Text(
                                    FormatMoney.format(ListProduct
                                        .listProduct[widget.index]
                                        .product
                                        .listProductOption[ListProduct
                                            .listProduct[widget.index]
                                            .atrributeId]
                                        .price),
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey)),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount:
                      ListProduct.listProduct[widget.index].listToppingName !=
                              null
                          ? ListProduct
                              .listProduct[widget.index].listToppingName.length
                          : 0,
                  itemBuilder: (context, indexOfListTopping) => Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                            ListProduct.listProduct[widget.index]
                                .listToppingName[indexOfListTopping],
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                        Text(
                            FormatMoney.format(ListProduct
                                .listProduct[widget.index]
                                .listToppingPrice[indexOfListTopping]),
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Expanded(
                    child: TextField(
                      style: TextStyle(fontSize: 12),
                      maxLength: 50,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.note_add_outlined,
                            size: 25,
                            color: Colors.grey,
                          ),
                          hintText: 'Bạn muốn dặn dò gì không (50 kí tự)',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
