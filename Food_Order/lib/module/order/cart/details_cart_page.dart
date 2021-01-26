import 'package:Food_Order/base/base_event.dart';
import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/order_service.dart';
import 'package:Food_Order/data/remote/product_service.dart';
import 'package:Food_Order/data/repo/order_repo.dart';
import 'package:Food_Order/data/repo/product_repo.dart';
import 'package:Food_Order/data/repo/rest_error.dart';
import 'package:Food_Order/data/state/attribute_state.dart';
import 'package:Food_Order/data/state/method_state.dart';
import 'package:Food_Order/bloc/order_bloc.dart';
import 'package:Food_Order/data/state/order_state.dart';
import 'package:Food_Order/data/state/topping_state.dart';
import 'package:Food_Order/data/state/total_state.dart';
import 'package:Food_Order/event/create_order_event.dart';
import 'package:Food_Order/event/delete_item_event.dart';
import 'package:Food_Order/event/order_event.dart';
import 'package:Food_Order/event/order_fail_event.dart';
import 'package:Food_Order/event/order_success_event.dart';
import 'package:Food_Order/models/amount_response.dart';
import 'package:Food_Order/models/product/product_details.dart';
import 'package:Food_Order/module/account/rewards/coupon_page.dart';
import 'package:Food_Order/module/payment.dart';
import 'package:Food_Order/module/signin/signin_page.dart';
import 'package:Food_Order/module/store/pick_up_store_page.dart';
import 'package:Food_Order/shared/widget/appbar.dart';
import 'package:Food_Order/shared/widget/bloc_listener.dart';
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
  final TextEditingController _txtreceiverNameController =
      TextEditingController(text: InfoUser.infoUser.customerName);
  final TextEditingController _txtphoneNumberController =
      TextEditingController(text: InfoUser.infoUser.phoneNumber);
  final TextEditingController _txtNoteController = TextEditingController();
  final orderBloc = OrderBloc(orderRepo: null);
  handleEvent(BaseEvent event) async {
    if (event is OrderSuccessEvent) {
      ListProduct.listProduct.clear();
      Navigator.pushReplacementNamed(context, '/status-order');
      return;
    }

    if (event is OrderFailEvent) {
      showDialog(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: EdgeInsets.only(bottom: 10),
                content: Builder(builder: (context) {
                  return Container(
                    child: Wrap(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text('Lỗi'),
                        ),
                        Divider(
                          height: 2,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            event.errMessage,
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        ),
                        Divider(),
                        Row(
                          children: [
                            Spacer(),
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "OK",
                                style: TextStyle(color: Colors.red),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }));
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ChangeNotifierProvider(
      create: (_) => OrderBloc(orderRepo: Provider.of(context)),
      child: Consumer<OrderBloc>(
        builder: (context, bloc, child) {
          return BlocListener<OrderBloc>(
            listener: handleEvent,
            child: StreamProvider.value(
              value: bloc.amount(),
              initialData: null,
              catchError: (context, error) {
                return error;
              },
              child: Consumer<Object>(
                builder: (context, data, child) {
                  var amountResponse = data as AmountResponse;
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
                                  height:
                                      MediaQuery.of(context).size.height / 5,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: TextFormField(
                                                controller:
                                                    _txtreceiverNameController,
                                                cursorColor: Colors.black,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                    ),
                                                    isDense: true,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0,
                                                            vertical: 0),
                                                    icon: Icon(
                                                      Icons
                                                          .person_outline_outlined,
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
                                                controller:
                                                    _txtphoneNumberController,
                                                cursorColor: Colors.black,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
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
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(top: 10),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                8,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/logo_intro.jpg'),
                                            ),
                                          ),
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                7,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
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
                                                  child: StreamBuilder<
                                                          MethodState>(
                                                      stream: orderBloc
                                                          .valueMethodController
                                                          .stream,
                                                      initialData:
                                                          orderBloc.valueMethod,
                                                      builder: (BuildContext
                                                              context,
                                                          AsyncSnapshot<
                                                                  MethodState>
                                                              snapshot) {
                                                        return GestureDetector(
                                                          onTap:
                                                              !snapshot.data
                                                                      .value
                                                                  ? () async {
                                                                      final sessionToken =
                                                                          Uuid()
                                                                              .v4();
                                                                      final Suggestion
                                                                          result =
                                                                          await showSearch(
                                                                        context:
                                                                            context,
                                                                        delegate:
                                                                            AddressSearch(sessionToken),
                                                                      );
                                                                      print(result
                                                                          .temrs[
                                                                              0]
                                                                          .value
                                                                          .toString());
                                                                      if (result !=
                                                                          null) {
                                                                        final placeDetails =
                                                                            await PlaceApiProvider(sessionToken).getPlaceDetailFromId(result.placeId);
                                                                        setState(
                                                                            () {
                                                                          Address.detailsAdr =
                                                                              result.description;
                                                                          Address.adr = result
                                                                              .temrs[1]
                                                                              .value
                                                                              .toString();

                                                                          Address.lat =
                                                                              placeDetails.lat;
                                                                          Address.lng =
                                                                              placeDetails.lng;
                                                                          Address.detailsAdr =
                                                                              (result.temrs[result.temrs.length - 3].value + ',' + result.temrs[result.temrs.length - 2].value + ',' + result.temrs[result.temrs.length - 1].value).toString();
                                                                        });
                                                                      }
                                                                    }
                                                                  : () {
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                PickUpStorePage()),
                                                                      );
                                                                    },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 5),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      2.2,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height /
                                                                      11,
                                                                  child: !snapshot
                                                                          .data
                                                                          .value
                                                                      ? Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(Address.adr != null ? Address.adr : 'Bạn chưa chọn địa chỉ',
                                                                                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87)),
                                                                            Text(
                                                                              Address.adr != null ? Address.detailsAdr : '',
                                                                              style: TextStyle(fontSize: 12),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      : Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text('Bạn chưa chọn cửa hàng',
                                                                                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87)),
                                                                            Text(
                                                                              '',
                                                                              style: TextStyle(fontSize: 12),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                ),
                                                                Container(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height /
                                                                      11,
                                                                  child: Text(
                                                                    'Thay đổi'
                                                                        .toUpperCase(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                ),
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Expanded(
                                                    child: TextField(
                                                      controller:
                                                          _txtNoteController,
                                                      cursorColor: Colors.black,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      decoration:
                                                          InputDecoration(
                                                              isDense: true,
                                                              icon: Icon(
                                                                Icons
                                                                    .note_add_outlined,
                                                                size: 25,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              hintText:
                                                                  'Thêm ghi chú cho tài xế',
                                                              hintStyle: TextStyle(
                                                                  color: Colors
                                                                      .grey)),
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
                                HomeTitle(text: 'Hình thức nhận hàng'),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  height:
                                      MediaQuery.of(context).size.height / 14,
                                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      StreamBuilder<MethodState>(
                                          stream: orderBloc
                                              .valueMethodController.stream,
                                          initialData: orderBloc.valueMethod,
                                          builder: (BuildContext context,
                                              AsyncSnapshot<MethodState>
                                                  snapshot) {
                                            return snapshot.data.value
                                                ? Text('Tự đến lấy')
                                                : Text('Giao tận nơi');
                                          }),
                                      Spacer(),
                                      StreamBuilder<MethodState>(
                                          stream: orderBloc
                                              .valueMethodController.stream,
                                          initialData: orderBloc.valueMethod,
                                          builder: (BuildContext context,
                                              AsyncSnapshot<MethodState>
                                                  snapshot) {
                                            return Switch(
                                                value: snapshot.data.value,
                                                onChanged: (_) {
                                                  orderBloc.event.add(
                                                      ToggleMethodEvent(
                                                          !snapshot
                                                              .data.value));
                                                });
                                          })
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
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                          onTap: () {
                                            ListProduct.listProduct[index]
                                                        .product.listTopping !=
                                                    null
                                                ? orderBloc.event.add(
                                                    SetLengthListToppingEvent(
                                                        ListProduct
                                                            .listProduct[index]
                                                            .product
                                                            .listTopping
                                                            .length,
                                                        ListProduct
                                                            .listProduct[index]
                                                            .product))
                                                : orderBloc.event.add(
                                                    SetLengthListToppingEvent(
                                                        0,
                                                        ListProduct
                                                            .listProduct[index]
                                                            .product));
                                            showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('Xác nhận'),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: ListBody(
                                                      children: <Widget>[
                                                        Text(
                                                            'Bạn có chắc chắn muốn đăng xuất?'),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text(
                                                        'Xóa bỏ',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      onPressed: () {
                                                        bloc.event.add(
                                                            DeleteItemEvent(
                                                                index));
                                                        setState(() {});
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text('Chỉnh sửa'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        showModalBottomSheet(
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            isScrollControlled:
                                                                true,
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    bc) {
                                                              return Container(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius: new BorderRadius
                                                                            .only(
                                                                        topLeft:
                                                                            const Radius.circular(
                                                                                10.0),
                                                                        topRight:
                                                                            const Radius.circular(10.0))),
                                                                child: Wrap(
                                                                  children: <
                                                                      Widget>[
                                                                    _buildAdjustQuantity(ListProduct
                                                                        .listProduct[
                                                                            index]
                                                                        .product),
                                                                    ListProduct.listProduct[index].product.listProductOption !=
                                                                            null
                                                                        ? _buildListOption(ListProduct
                                                                            .listProduct[index]
                                                                            .product)
                                                                        : Container(),
                                                                    ListProduct.listProduct[index].product.listTopping !=
                                                                            null
                                                                        ? _builListTopping(ListProduct
                                                                            .listProduct[index]
                                                                            .product)
                                                                        : Container(),
                                                                    _buildAddToCartButton(
                                                                        index,
                                                                        ListProduct
                                                                            .listProduct[index]
                                                                            .product)
                                                                  ],
                                                                ),
                                                              );
                                                            });
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
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
                                  height:
                                      MediaQuery.of(context).size.height / 14,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('Tạm tính'),
                                          Text(FormatMoney.format(
                                              FormatMoney.amount(
                                                  ListProduct.listProduct))),
                                        ],
                                      ),
                                      data != null &&
                                              amountResponse.isError == false
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text('Khuyến mãi'),
                                                Text('-' +
                                                    FormatMoney.format(FormatMoney
                                                            .amount(ListProduct
                                                                .listProduct) -
                                                        amountResponse.amount
                                                            .toDouble())),
                                              ],
                                            )
                                          : Container(),
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
                                  height:
                                      MediaQuery.of(context).size.height / 15,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Tổng cộng'),
                                      data != null
                                          ? Text(
                                              FormatMoney.format(amountResponse
                                                  .amount
                                                  .toDouble()),
                                            )
                                          : Text(FormatMoney.format(
                                              FormatMoney.amount(
                                                  ListProduct.listProduct))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Center(
                            child: Text(
                                'Bạn chưa có sản phẩm nào trong giỏ hàng')),
                    bottomNavigationBar: Container(
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PaymentPage()),
                                    );
                                  },
                                  child: Container(
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
                                      data is RestError || data == null
                                          ? Container()
                                          : Text(
                                              FormatMoney.format(amountResponse
                                                  .amount
                                                  .toDouble()),
                                            ),
                                    ]),
                                  ),
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
                                      width: MediaQuery.of(context).size.width /
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
                                                  Icons.confirmation_num,
                                                  color: Colors.red,
                                                  size: 30,
                                                ),
                                                data is RestError ||
                                                        data != null
                                                    ? amountResponse
                                                                .discountCode !=
                                                            null
                                                        ? amountResponse
                                                                    .isError ==
                                                                false
                                                            ? Icon(
                                                                Icons.verified,
                                                                color: Colors
                                                                    .green,
                                                                size: 15,
                                                              )
                                                            : Icon(
                                                                Icons.error,
                                                                color:
                                                                    Colors.red,
                                                                size: 15,
                                                              )
                                                        : Container()
                                                    : Container()
                                              ],
                                            ),
                                          ),
                                          Text(
                                            data is RestError || data != null
                                                ? amountResponse.discountCode ==
                                                        null
                                                    ? 'Mã ưu đãi'
                                                    : amountResponse.isError ==
                                                            true
                                                        ? amountResponse
                                                            .messageError
                                                        : amountResponse
                                                            .discountCode.name
                                                : 'Mã ưu đãi',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                          ),
                                          data is RestError ||
                                                  data != null &&
                                                      amountResponse
                                                              .discountCode !=
                                                          null
                                              ? SizedBox(
                                                  height: 30,
                                                  child: RaisedButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                    ),
                                                    onPressed: () {},
                                                    color: Colors.black,
                                                    textColor: Colors.white,
                                                    child: Text(
                                                        amountResponse
                                                            .discountCode.code,
                                                        style: TextStyle(
                                                            fontSize: 12)),
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      )),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: StreamBuilder<MethodState>(
                                stream: orderBloc.valueMethodController.stream,
                                initialData: orderBloc.valueMethod,
                                builder: (BuildContext context,
                                    AsyncSnapshot<MethodState> snapshot) {
                                  return RaisedButton(
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
                                          :
                                          // : showDialog(
                                          //     context: context,
                                          //     builder: (BuildContext context) {

                                          //       return AlertDialog(
                                          //         title: Text('Thông báo!'),
                                          //         content: Container(
                                          //           height: 100,
                                          //           child: Center(
                                          //               child:
                                          //                   CircularProgressIndicator(
                                          //             backgroundColor:
                                          //                 Colors.grey[100],
                                          //           )),
                                          //         ),
                                          //         actions: [
                                          //           FlatButton(
                                          //             child: Text('Ok'),
                                          //             onPressed: () {
                                          //               Navigator.of(context)
                                          //                   .pop();
                                          //             },
                                          //           ),
                                          //         ],
                                          //       );
                                          //     },
                                          //   );
                                          bloc.event.add(CreateOrderEvent(
                                              address: Address.detailsAdr,
                                              orderType: !snapshot.data.value
                                                  ? 'DELIVERY'
                                                  : 'AT_STORE',
                                              latitude: Address.lat,
                                              longtitude: Address.lng,
                                              note: _txtNoteController.text,
                                              listOrderDetail:
                                                  ListProduct.listProduct,
                                              receiverName:
                                                  _txtreceiverNameController
                                                      .text,
                                              phoneNumber:
                                                  _txtphoneNumberController
                                                      .text,
                                              amount: amountResponse.amount,
                                              discountCodeId:
                                                  CouponApply.couponId,
                                              branchId: 'id',
                                              paymentMethod: "COD"));
                                    },
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
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
        initialData: orderBloc.total,
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
