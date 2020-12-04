import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/product_service.dart';
import 'package:Food_Order/data/repo/product_repo.dart';
import 'package:Food_Order/data/state/order_bloc.dart';
import 'package:Food_Order/models/cart.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:Food_Order/shared/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:provider/provider.dart';

class DetailsCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [
        Provider.value(
          value: ProductService(),
        ),
        ProxyProvider<ProductService, ProductRepo>(
          update: (context, productService, previous) =>
              ProductRepo(productService: productService),
        ),
        ListenableProvider<OrderBloc>(create: (context) => OrderBloc()),
      ],
      bloc: [],
      child: DetailsCartScreen(),
    );
  }
}

class DetailsCartScreen extends StatefulWidget {
  @override
  _DetailsCartScreen createState() => _DetailsCartScreen();
}

class _DetailsCartScreen extends State<DetailsCartScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<OrderBloc>(builder: (context, bloc, child) {
      return Scaffold(
          backgroundColor: Colors.indigo[50],
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black54,
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              'Giỏ hàng của bạn',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ),
          body: ListProduct.listProduct.length != 0
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                          child: Text('Thông tin đơn hàng',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87))),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        height: MediaQuery.of(context).size.height / 5,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextField(
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 0),
                                          icon: Icon(
                                            Icons.person_outline_outlined,
                                            size: 25,
                                            color: Colors.grey,
                                          ),
                                          hintText: 'Tên người nhận',
                                          hintStyle:
                                              TextStyle(color: Colors.grey)),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 0),
                                          icon: Icon(
                                            Icons.call_outlined,
                                            color: Colors.grey,
                                            size: 25,
                                          ),
                                          hintText: 'Số điện thoại',
                                          hintStyle:
                                              TextStyle(color: Colors.grey)),
                                    ),
                                  ),
                                  Icon(
                                    Icons.contact_phone,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  //color: Colors.white,
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: Image(
                                    image: AssetImage('assets/logo_intro.jpg'),
                                  ),
                                ),
                                Container(
                                  //color: Colors.yellow,
                                  height:
                                      MediaQuery.of(context).size.height / 7,
                                  width:
                                      MediaQuery.of(context).size.width / 1.48,
                                  child: Column(
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, top: 10),
                                        //color: Colors.green,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                25,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.48,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text('Bạn chưa chọn địa chỉ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87)),
                                            Text(
                                              'Thay đổi'.toUpperCase(),
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        //color: Colors.red,
                                        margin: EdgeInsets.only(top: 25),
                                        padding:
                                            EdgeInsets.only(left: 10, top: 10),
                                        child: Expanded(
                                          child: TextField(
                                            cursorColor: Colors.black,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                                isDense: true,
                                                icon: Icon(
                                                  Icons.note_add_outlined,
                                                  size: 25,
                                                  color: Colors.grey,
                                                ),
                                                hintText:
                                                    'Thêm ghi chú cho tài xế',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                          child: Text('Thời gian nhận hàng',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87))),
                      Container(
                        height: MediaQuery.of(context).size.height / 14,
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Icon(Icons.pending_actions_outlined,
                                  color: Colors.grey),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Hẹn giờ',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('Trong 15-30 phút',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                          child: Text('Chi tiết đơn hàng',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87))),
                      ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: ListProduct.listProduct.length,
                        itemBuilder: (context, index) => Container(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, top: 10),
                          color: Colors.white,
                          child: Row(
                            children: [
                              Row(
                                children: <Widget>[
                                  Container(
                                      width: 30,
                                      child: Text(
                                        ListProduct.listProduct[index].quantity
                                            .toString(),
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
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      height: 35,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                  ListProduct.listProduct[index]
                                                      .product.productName,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black87)),
                                              Text(
                                                '${FlutterMoneyFormatter(settings: MoneyFormatterSettings(
                                                      symbol: 'đ',
                                                      fractionDigits: 0,
                                                    ), amount: ListProduct.listProduct[index].total).output.symbolOnRight}',
                                              ),
                                            ],
                                          ),
                                          ListProduct.listProduct[index].product
                                                      .attribute !=
                                                  null
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                        ListProduct
                                                            .listProduct[index]
                                                            .product
                                                            .listProductOption[
                                                                ListProduct
                                                                    .listProduct[
                                                                        index]
                                                                    .atrributeId]
                                                            .attributeValue,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.grey)),
                                                    Text(
                                                        '${FlutterMoneyFormatter(settings: MoneyFormatterSettings(
                                                              symbol: 'đ',
                                                              fractionDigits: 0,
                                                            ), amount: ListProduct.listProduct[index].product.listProductOption[ListProduct.listProduct[index].atrributeId].price).output.symbolOnRight}',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.grey)),
                                                  ],
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                    ListView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      itemCount: ListProduct.listProduct[index]
                                                  .listToppingName !=
                                              null
                                          ? ListProduct.listProduct[index]
                                              .listToppingName.length
                                          : 0,
                                      itemBuilder:
                                          (context, indexOfListTopping) =>
                                              Container(
                                        padding:
                                            EdgeInsets.only(left: 5, right: 5),
                                        color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                                ListProduct.listProduct[index]
                                                        .listToppingName[
                                                    indexOfListTopping],
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey)),
                                            Text(
                                                '${FlutterMoneyFormatter(settings: MoneyFormatterSettings(
                                                      symbol: 'đ',
                                                      fractionDigits: 0,
                                                    ), amount: ListProduct.listProduct[index].listToppingPrice[indexOfListTopping]).output.symbolOnRight}',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Expanded(
                                        child: TextField(
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
                                              hintText:
                                                  'Bạn muốn dặn dò gì không (50 kí tự)',
                                              hintStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height / 15,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Tạm tính'),
                                Text(
                                  '${FlutterMoneyFormatter(settings: MoneyFormatterSettings(
                                        symbol: 'đ',
                                        fractionDigits: 0,
                                      ), amount: _total(ListProduct.listProduct)).output.symbolOnRight}',
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Phí giao hàng'),
                                Text('Miễn phí')
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height / 15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Tổng cộng'),
                            Text('69.000 đ')
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Text('Bạn chưa có sản phẩm nào trong giỏ hàng'),
                ),
          bottomNavigationBar: InfoUser.isLogin != true
              ? Container(
                  height: 50.0,
                  child: RaisedButton(
                    child: Text(
                      "Đăng nhập để mua hàng",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.red,
                    onPressed: () {},
                  ),
                )
              : Container(
                  height: 50.0,
                  child: RaisedButton(
                    child: Text(
                      "Đặt hàng",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.red,
                    onPressed: () {},
                  ),
                ));
    });
  }

  double _total(List<Cart> list) {
    var sum = 0.0;
    for (int i = 0; i < list.length; i++) {
      sum += list[i].total;
    }
    return sum;
  }
}
