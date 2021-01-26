import 'dart:async';

import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/product_service.dart';
import 'package:Food_Order/data/repo/product_repo.dart';
import 'package:Food_Order/data/state/search_state.dart';
import 'package:Food_Order/event/search_product_event.dart';
import 'package:Food_Order/models/product/product.dart';
import 'package:Food_Order/module/order/product_bloc.dart';
import 'package:Food_Order/module/order/product_details.dart';
import 'package:Food_Order/shared/size_config.dart';
import 'package:Food_Order/shared/widget/format_money.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class SearchPage extends StatelessWidget {
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
      ],
      bloc: [],
      child: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _txtSearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _debouncer = Debouncer(milliseconds: 500);
    List<Product> filteredProducts = List();
    return ChangeNotifierProvider.value(
      value: ProductBloc.getInstance(productRepo: Provider.of(context)),
      child: Consumer<ProductBloc>(
          builder: (context, bloc, child) => Container(
              child: StreamProvider.value(
                  value: bloc.getAllProduct(),
                  initialData: null,
                  catchError: (context, error) {
                    return error;
                  },
                  child: Consumer<Object>(builder: (context, data, child) {
                    var product = data as List<Product>;
                    return Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.white,
                        iconTheme: IconThemeData(
                          color: Colors.black54,
                        ),
                        title: TextFormField(
                          controller: _txtSearchController,
                          onChanged: (string) {
                            

                            _debouncer.run(() {
                              setState(() {
                                print(string);
                                filteredProducts = product
                                    .where((p) => (p.productName
                                            .toLowerCase()
                                            .contains(string.toLowerCase()) ||
                                        p.productName
                                            .toLowerCase()
                                            .contains(string.toLowerCase())))
                                    .toList();
                                bloc.event.add(SearchProductEvent(
                                    keyword: string,
                                    listProduct: filteredProducts));
                                print('Filtered lenght: ' +
                                    filteredProducts.length.toString());
                              });
                            });
                          },
                          cursorColor: Colors.green[500],
                          //autofocus: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            hintText: 'Tìm kiếm sản phẩm',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      body: StreamBuilder<SearchState>(
                          stream: bloc.searchController.stream,
                          initialData: bloc.listProduct,
                          builder: (BuildContext context,
                              AsyncSnapshot<SearchState> snapshot) {
                            return Container(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: GridView.builder(
                                shrinkWrap: true,
                                primary: false,
                                //physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio:
                                      MediaQuery.of(context).size.width /
                                          (MediaQuery.of(context).size.height /
                                              1.6),
                                ),
                                itemCount: snapshot.data.listProduct.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailsScreen(
                                                  id: snapshot
                                                      .data
                                                      .listProduct[index]
                                                      .productId,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5.0),
                                                topRight: Radius.circular(5.0)),
                                            child: Image.network(
                                              snapshot.data.listProduct[index]
                                                  .image,
                                              height:
                                                  SizeConfig.screenHeight / 6.5,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10.0, 10.0, 0, 0),
                                            child: Text(
                                              snapshot.data.listProduct[index]
                                                  .productName,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Spacer(),
                                          Divider(
                                            color: Colors.grey,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                15, 10, 0, 15),
                                            child: Text(
                                              FormatMoney.format(snapshot.data
                                                  .listProduct[index].price),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                    );
                  })))),
    );
  }
}
