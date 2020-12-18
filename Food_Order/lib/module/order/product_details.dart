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
import 'package:Food_Order/models/product/product_details.dart';
import 'package:Food_Order/module/order/cart/details_cart_page.dart';
import 'package:Food_Order/module/order/product_bloc.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:Food_Order/shared/ultil/comments.dart';
import 'package:Food_Order/shared/widget/format_money.dart';
import 'package:Food_Order/shared/widget/skeleton/loading_detail_product.dart';
import 'package:Food_Order/shared/widget/smooth_star_rating.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int id;
  const ProductDetailsScreen({@required this.id});
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
      ],
      bloc: [],
      child: ProductDetailsPage(id: id),
    );
  }
}

class ProductDetailsPage extends StatefulWidget {
  final int id;
  const ProductDetailsPage({@required this.id});
  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool isFav = false;
  final orderBloc = OrderBloc(orderRepo: null);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: ProductBloc.getInstance(productRepo: Provider.of(context)),
      child: Consumer<ProductBloc>(
        builder: (context, bloc, child) => Container(
          child: StreamProvider<Object>.value(
            value: bloc.getProductDetailsById(widget.id),
            initialData: null,
            catchError: (context, error) {
              return error;
            },
            child: Consumer<Object>(
              builder: (context, data, child) {
                if (data == null) {
                  return LoadingDetailProduct();
                }

                if (data is RestError) {
                  return Center(
                    child: Container(
                      child: Text(
                        data.message,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  );
                }
                var productdetails = data as ProductDetails;
                return Scaffold(
                  appBar: AppBar(
                    bottom: PreferredSize(
                        child: Container(
                          color: Colors.grey,
                          height: 1,
                        ),
                        preferredSize: Size.fromHeight(1.0)),
                    elevation: 0.0,
                    iconTheme: IconThemeData(
                      color: Colors.grey,
                    ),
                    backgroundColor: Colors.white,
                    automaticallyImplyLeading: true,
                    leading: IconButton(
                      icon: Icon(
                        Icons.keyboard_backspace,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    centerTitle: true,
                    title: Text(
                      productdetails.productName,
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(Icons.shopping_cart),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsCartPage()),
                          );
                        },
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                  body: Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                    child: ListView(
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        Stack(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height / 3.2,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  productdetails.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: -10.0,
                              bottom: 3.0,
                              child: RawMaterialButton(
                                onPressed: () {},
                                fillColor: Colors.white,
                                shape: CircleBorder(),
                                elevation: 4.0,
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(
                                    isFav
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.red,
                                    size: 17,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          productdetails.productName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                          maxLines: 2,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
                          child: Row(
                            children: <Widget>[
                              SmoothStarRating(
                                starCount: 5,
                                color: Colors.orange,
                                allowHalfRating: true,
                                rating: 5.0,
                                size: 10.0,
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                "5.0 (23 Reviews)",
                                style: TextStyle(
                                  fontSize: 11.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "20 Pieces",
                                style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                FormatMoney.format(productdetails.price),
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w900,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          "Mô tả",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                          maxLines: 2,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          productdetails.description,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          "Reviews",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                          maxLines: 2,
                        ),
                        SizedBox(height: 20.0),
                        ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: comments == null ? 0 : comments.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map comment = comments[index];
                            return ListTile(
                              leading: CircleAvatar(
                                radius: 25.0,
                                backgroundImage: NetworkImage(
                                  "${comment['img']}",
                                ),
                              ),
                              title: Text("${comment['name']}"),
                              subtitle: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      SmoothStarRating(
                                        starCount: 5,
                                        color: Colors.orange,
                                        allowHalfRating: true,
                                        rating: 5.0,
                                        size: 12.0,
                                      ),
                                      SizedBox(width: 6.0),
                                      Text(
                                        "February 14, 2020",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 7.0),
                                  Text(
                                    "${comment["comment"]}",
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                  // floatingActionButton: Container(
                  //   height: 50.0,
                  floatingActionButton: FloatingActionButton(
                    child: Icon(
                      Icons.add_shopping_cart_outlined,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.red,
                    onPressed: () {
                      productdetails.listTopping != null
                          ? orderBloc.event.add(SetLengthListToppingEvent(
                              productdetails.listTopping.length,
                              productdetails))
                          : orderBloc.event.add(
                              SetLengthListToppingEvent(0, productdetails));
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext bc) {
                            return Container(
                              child: Wrap(
                                children: <Widget>[
                                  _buildAdjustQuantity(productdetails),
                                  productdetails.listProductOption != null
                                      ? _buildListOption(productdetails)
                                      : Container(),
                                  productdetails.listTopping != null
                                      ? _builListTopping(productdetails)
                                      : Container(),
                                  _buildAddToCartButton(productdetails)
                                ],
                              ),
                            );
                          });
                    },
                  ),
                );
              },
            ),
          ),
        ),
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

  Widget _buildAddToCartButton(ProductDetails productdetails) {
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
                orderBloc.event.add(AddProductToCartEvent(
                    productdetails,
                    productdetails.listProductOption != null
                        ? productdetails.listProductOption[1].productId
                        : productdetails.productId,
                    snapshot.data.total));

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
                    "Thêm vào giỏ hàng",
                  ),
                  Text(FormatMoney.format(snapshot.data.total)),
                ],
              ),
            ),
          );
        });
  }
}
