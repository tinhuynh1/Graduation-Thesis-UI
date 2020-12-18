import 'dart:convert';

import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/order_service.dart';
import 'package:Food_Order/data/remote/product_service.dart';
import 'package:Food_Order/data/repo/order_repo.dart';
import 'package:Food_Order/data/repo/product_repo.dart';
import 'package:Food_Order/data/repo/rest_error.dart';
import 'package:Food_Order/data/state/attribute_state.dart';
import 'package:Food_Order/data/state/order_bloc.dart';
import 'package:Food_Order/data/state/order_state.dart';
import 'package:Food_Order/data/state/topping_state.dart';
import 'package:Food_Order/data/state/total_state.dart';
import 'package:Food_Order/event/create_order_event.dart';
import 'package:Food_Order/event/order_event.dart';
import 'package:Food_Order/models/amount_response.dart';
import 'package:Food_Order/models/product/product_details.dart';
import 'package:Food_Order/module/account/rewards/coupon_page.dart';
import 'package:Food_Order/module/signin/signin_page.dart';
import 'package:Food_Order/shared/widget/appbar.dart';
import 'package:Food_Order/shared/widget/format_money.dart';
import 'package:Food_Order/shared/widget/home_tile.dart';
import 'package:Food_Order/shared/widget/product_cart.dart';
import 'package:Food_Order/test_app/select_address_page.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:Food_Order/shared/size_config.dart';
import 'package:Food_Order/data/remote/place_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

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
        Provider.value(
          value: OrderService(),
        ),
        ProxyProvider<OrderService, OrderRepo>(
          update: (context, orderService, previous) =>
              OrderRepo(orderService: orderService),
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
  final orderBloc = OrderBloc(orderRepo: null);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ChangeNotifierProvider(
        create: (_) => OrderBloc(orderRepo: Provider.of(context)),
        child: Consumer<OrderBloc>(
          builder: (context, bloc, child) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              resizeToAvoidBottomPadding: false,
              backgroundColor: Color(0xfff0eff4),
              appBar: AppBarCustom(
                text: 'Giỏ hàng của bạn',
              ),
              body: ListProduct.listProduct.length != 0
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HomeTitle(text: 'Thông tin đơn hàng'),
                          Container(
                            margin: EdgeInsets.only(top: 10),
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
                                        child: TextFormField(
                                          initialValue: InfoUser.isLogin
                                              ? InfoUser.infoUser.customerName
                                              : '',
                                          cursorColor: Colors.black,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                              ),
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0,
                                                      vertical: 0),
                                              icon: Icon(
                                                Icons.person_outline_outlined,
                                                size: 25,
                                                color: Colors.grey,
                                              ),
                                              hintText: 'Tên người nhận',
                                              hintStyle: TextStyle(
                                                  color: Colors.grey)),
                                        ),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          initialValue: InfoUser.isLogin
                                              ? InfoUser.infoUser.phoneNumber
                                              : '',
                                          cursorColor: Colors.black,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                              ),
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0,
                                                      vertical: 0),
                                              icon: Icon(
                                                Icons.call_outlined,
                                                color: Colors.grey,
                                                size: 25,
                                              ),
                                              hintText: 'Số điện thoại',
                                              hintStyle: TextStyle(
                                                  color: Colors.grey)),
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
                                      height:
                                          MediaQuery.of(context).size.height /
                                              8,
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      child: Image(
                                        image:
                                            AssetImage('assets/logo_intro.jpg'),
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              7,
                                      width: MediaQuery.of(context).size.width /
                                          1.48,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                            ),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                11,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.48,
                                            child: GestureDetector(
                                              onTap: () async {
                                                final sessionToken =
                                                    Uuid().v4();
                                                final Suggestion result =
                                                    await showSearch(
                                                  context: context,
                                                  delegate: AddressSearch(
                                                      sessionToken),
                                                );
                                                print(result.temrs[0].value
                                                    .toString());
                                                if (result != null) {
                                                  final placeDetails =
                                                      await PlaceApiProvider(
                                                              sessionToken)
                                                          .getPlaceDetailFromId(
                                                              result.placeId);
                                                  setState(() {
                                                    Address.detailsAdr =
                                                        result.description;
                                                    Address.adr = result
                                                        .temrs[1].value
                                                        .toString();

                                                    Address.lat =
                                                        placeDetails.lat;
                                                    Address.lng =
                                                        placeDetails.lng;
                                                    Address.detailsAdr = (result
                                                                .temrs[result
                                                                        .temrs
                                                                        .length -
                                                                    3]
                                                                .value +
                                                            ',' +
                                                            result
                                                                .temrs[result
                                                                        .temrs
                                                                        .length -
                                                                    2]
                                                                .value +
                                                            ',' +
                                                            result
                                                                .temrs[result
                                                                        .temrs
                                                                        .length -
                                                                    1]
                                                                .value)
                                                        .toString();
                                                  });
                                                }
                                              },
                                              child: Container(
                                                padding:
                                                    EdgeInsets.only(top: 5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              11,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              Address.adr !=
                                                                      null
                                                                  ? Address.adr
                                                                  : 'Bạn chưa chọn địa chỉ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black87)),
                                                          Text(
                                                            Address.adr != null
                                                                ? Address
                                                                    .detailsAdr
                                                                : '',
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              11,
                                                      child: Text(
                                                        'Thay đổi'
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Expanded(
                                              child: TextField(
                                                cursorColor: Colors.black,
                                                keyboardType:
                                                    TextInputType.text,
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
                          HomeTitle(text: 'Thời gian nhận hàng'),
                          Container(
                            margin: EdgeInsets.only(top: 10),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                          HomeTitle(text: 'Chi tiết đơn hàng'),
                          SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: ListProduct.listProduct.length,
                            itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  ListProduct.listProduct[index].product
                                              .listTopping !=
                                          null
                                      ? orderBloc.event.add(
                                          SetLengthListToppingEvent(
                                              ListProduct.listProduct[index]
                                                  .product.listTopping.length,
                                              ListProduct
                                                  .listProduct[index].product))
                                      : orderBloc.event.add(
                                          SetLengthListToppingEvent(
                                              0,
                                              ListProduct
                                                  .listProduct[index].product));
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (BuildContext bc) {
                                        return Container(
                                          child: Wrap(
                                            children: <Widget>[
                                              _buildAdjustQuantity(ListProduct
                                                  .listProduct[index].product),
                                              ListProduct
                                                          .listProduct[index]
                                                          .product
                                                          .listProductOption !=
                                                      null
                                                  ? _buildListOption(ListProduct
                                                      .listProduct[index]
                                                      .product)
                                                  : Container(),
                                              ListProduct
                                                          .listProduct[index]
                                                          .product
                                                          .listTopping !=
                                                      null
                                                  ? _builListTopping(ListProduct
                                                      .listProduct[index]
                                                      .product)
                                                  : Container(),
                                              _buildAddToCartButton(
                                                  index,
                                                  ListProduct.listProduct[index]
                                                      .product)
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: ProductCart(
                                  index: index,
                                )),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Tạm tính'),
                                    Text(FormatMoney.format(FormatMoney.amount(
                                        ListProduct.listProduct))),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
              bottomNavigationBar: StreamProvider.value(
                  value: bloc.amount(),
                  initialData: null,
                  catchError: (context, error) {
                    return error;
                  },
                  child: Consumer<Object>(
                    builder: (context, data, child) {
                      if (data is RestError || data == null) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          color: Colors.white,
                          child: Column(children: [
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                width: 0.5,
                                color: Colors.grey,
                              ))),
                              height: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            8,
                                    child: Column(children: <Widget>[
                                      Icon(Icons.attach_money_outlined,
                                          color: Colors.grey),
                                      Text(
                                        'Thanh toán khi nhận hàng',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                    ]),
                                  ),
                                  VerticalDivider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return CouponPage();
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                8,
                                        child: Icon(Icons.credit_card,
                                            color: Colors.grey)),
                                  )
                                ],
                              ),
                            ),
                          ]),
                        );
                      }
                      var amountResponse = data as AmountResponse;
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                width: 0.5,
                                color: Colors.grey,
                              ))),
                              height: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            8,
                                    child: Column(children: <Widget>[
                                      Icon(Icons.attach_money_outlined,
                                          color: Colors.grey),
                                      Text(
                                        'Thanh toán khi nhận hàng',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                      Text(
                                        FormatMoney.format(
                                            amountResponse.amount.toDouble()),
                                      ),
                                    ]),
                                  ),
                                  VerticalDivider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print(CouponApply.couponId);
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return CouponPage();
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                8,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 70, right: 70),
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.local_activity,
                                                    color: Colors.red,
                                                    size: 30,
                                                  ),
                                                  amountResponse.discountCode !=
                                                          null
                                                      ? amountResponse
                                                                  .isError ==
                                                              false
                                                          ? Icon(
                                                              Icons.verified,
                                                              color:
                                                                  Colors.green,
                                                              size: 15,
                                                            )
                                                          : Icon(
                                                              Icons.error,
                                                              color: Colors.red,
                                                              size: 15,
                                                            )
                                                      : Container(),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              amountResponse.discountCode ==
                                                      null
                                                  ? 'Mã ưu đãi'
                                                  : amountResponse
                                                      .discountCode.name,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            ),
                                            // SizedBox(
                                            //   height: 30,
                                            //   child: RaisedButton(
                                            //     shape:
                                            //         RoundedRectangleBorder(
                                            //       borderRadius:
                                            //           BorderRadius
                                            //               .circular(
                                            //                   18.0),
                                            //     ),
                                            //     onPressed: () {},
                                            //     color: Colors.black,
                                            //     textColor: Colors.white,
                                            //     child: Text(
                                            //         amountResponse
                                            //             .discountCode
                                            //             .code,
                                            //         style: TextStyle(
                                            //             fontSize: 12)),
                                            //   ),
                                            // ),
                                          ],
                                        )),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: RaisedButton(
                                child: Text(
                                  InfoUser.isLogin
                                      ? 'Đặt hàng'
                                      : "Đăng nhập để mua hàng",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                color: Colors.red,
                                onPressed: () {
                                  !InfoUser.isLogin
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignInPage()),
                                        )
                                      // : bloc.event.add(CreateOrderEvent('a', 'a', 1.2,
                                      //     1.2, 'a', ListProduct.listProduct));
                                      : bloc.event.add(
                                          AmountEvent(ListProduct.listProduct));
                                  print(jsonEncode(ListProduct.listProduct
                                      .map((e) => e.toJson())
                                      .toList()));
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
            );
          },
        ));
  }

  Widget _buildAdjustQuantity(ProductDetails productdetails) {
    return ChangeNotifierProvider(
      create: (_) => OrderBloc(orderRepo: Provider.of(context)),
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              productdetails.productName,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                minWidth: 25,
                height: 25,
                onPressed: () {
                  orderBloc.event.add(DecrementEvent(1, productdetails));
                },
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                  size: 20.0,
                ),
                shape: CircleBorder(),
                color: Colors.black12,
              ),
              StreamBuilder<RemoteState>(
                stream: orderBloc.stateController.stream,
                initialData: orderBloc.state,
                builder: (BuildContext context,
                    AsyncSnapshot<RemoteState> snapshot) {
                  return Text('${snapshot.data.quantity}');
                },
              ),
              FlatButton(
                minWidth: 25,
                height: 25,
                onPressed: () {
                  orderBloc.event.add(IncrementEvent(1, productdetails));
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20.0,
                ),
                shape: CircleBorder(),
                color: Colors.red,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildListOption(ProductDetails productdetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            productdetails.attribute.attributeName,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: productdetails.listProductOption == null
                ? 0
                : productdetails.listProductOption.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                //dense: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        productdetails.listProductOption[index].attributeValue),
                    Text(FormatMoney.format(
                        productdetails.listProductOption[index].price)),
                  ],
                ),
                leading: StreamBuilder<AttributeState>(
                  stream: orderBloc.valueController.stream,
                  initialData: orderBloc.value,
                  builder: (BuildContext context,
                      AsyncSnapshot<AttributeState> snapshot) {
                    return Radio(
                        value: index,
                        groupValue: snapshot.data.value,
                        onChanged: (index) {
                          orderBloc.event.add(
                              SelectAttributeValueEvent(index, productdetails));
                        });
                  },
                ),
              );
            }),
      ],
    );
  }

  Widget _builListTopping(ProductDetails productdetails) {
    return Container(
      height: 140,
      child: ListView(children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Topping',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                primary: false,
                // physics:
                //     NeverScrollableScrollPhysics(),
                itemCount: productdetails.listTopping == null
                    ? 0
                    : productdetails.listTopping.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(productdetails.listTopping[index].toppingName),
                        Text(FormatMoney.format(
                            productdetails.listTopping[index].price)),
                      ],
                    ),
                    leading: StreamBuilder<ToppingState>(
                      stream: orderBloc.toppingController.stream,
                      initialData: (orderBloc.listValue),
                      builder: (BuildContext context,
                          AsyncSnapshot<ToppingState> snapshot) {
                        return Checkbox(
                          value: snapshot.data.check[index],
                          activeColor: Colors.red,
                          onChanged: (bool value) {
                            orderBloc.event.add(CheckToppingEvent(
                                value,
                                index,
                                productdetails.listTopping[index].toppingId,
                                productdetails.listTopping[index].toppingName,
                                productdetails.listTopping[index].price,
                                productdetails));
                            print(snapshot.data.check[index]);
                          },
                        );
                      },
                    ),
                  );
                }),
          ],
        ),
      ]),
    );
  }

  Widget _buildAddToCartButton(int index, ProductDetails productdetails) {
    return StreamBuilder(
        stream: orderBloc.totalController.stream,
        initialData: (orderBloc.total),
        builder: (BuildContext context, AsyncSnapshot<TotalState> snapshot) {
          return Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.red)),
              onPressed: () {
                orderBloc.event.add(UpdateCartEvent(
                  index,
                  productdetails,
                  productdetails.listProductOption != null
                      ? productdetails.attribute.attributeId
                      : productdetails.productId,
                  snapshot.data.total,
                ));
                setState(() {});
                Navigator.pop(context);
              },
              color: Colors.red,
              textColor: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.add_shopping_cart,
                    color: Colors.white,
                  ),
                  Text(
                    "Chỉnh sửa",
                  ),
                  Text(FormatMoney.format(snapshot.data.total)),
                ],
              ),
            ),
          );
        });
  }
}
