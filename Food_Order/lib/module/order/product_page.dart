import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/product_service.dart';
import 'package:Food_Order/data/repo/product_repo.dart';
import 'package:Food_Order/data/repo/rest_error.dart';
import 'package:Food_Order/data/spref/spref.dart';
import 'package:Food_Order/models/product/parent_category.dart';
import 'package:Food_Order/module/order/product_bloc.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:Food_Order/shared/size_config.dart';
import 'package:Food_Order/shared/widget/custom_tab_view.dart';
import 'package:Food_Order/module/order/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
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
      child: TabParentCategory(),
    );
  }
}

class TabParentCategory extends StatefulWidget {
  @override
  _TabParentCategory createState() => _TabParentCategory();
}

class _TabParentCategory extends State<TabParentCategory> {
  int initPosition = 1;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // return
    // ChangeNotifierProvider.value(
    //   value: ProductBloc.getInstance(productRepo: Provider.of(context)),
    //   child: Consumer<ProductBloc>(
    //     builder: (context, bloc, child) => Container(
    //       child: StreamProvider<Object>.value(
    //         value: bloc.getParentCategoryList(),
    //         initialData: null,
    //         catchError: (context, error) {
    //           return error;
    //         },
    //         child: Consumer<Object>(
    //           builder: (context, data, child) {
    //             if (data == null) {
    //               return Center(
    //                 child: CircularProgressIndicator(
    //                   backgroundColor: Colors.orange,
    //                 ),
    //               );
    //             }

    //             if (data is RestError) {
    //               return Center(
    //                 child: Container(
    //                   child: Text(
    //                     data.message,
    //                     style: TextStyle(fontSize: 20),
    //                   ),
    //                 ),
    //               );
    //             }
    //             var parentCategorys = data as List<ParentCategory>;
    return Scaffold(
      body: SafeArea(
        child: CustomTabView(
          initPosition: initPosition,
          itemCount: Product.category.length,
          tabBuilder: (context, index) =>
              Tab(text: Product.category[index].parentCategoryName),
          pageBuilder: (context, parentCategoryIndex) => Container(
              color: Colors.grey[200],
              // child: Consumer<Object>(
              //   builder: (context, data, child) {
              //return
              child: ListView.builder(
                  itemCount: Product.category[parentCategoryIndex]
                      .listChildrenCategory.length,
                  itemBuilder: (context, categoryIndex) {
                    return Product
                                .category[parentCategoryIndex]
                                .listChildrenCategory[categoryIndex]
                                .listProduct !=
                            null
                        ? Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  child: Text(Product
                                      .category[parentCategoryIndex]
                                      .listChildrenCategory[categoryIndex]
                                      .categoryName),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: GridView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      physics: NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio:
                                            MediaQuery.of(context).size.width /
                                                (MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    1.6),
                                      ),
                                      itemCount: Product
                                          .category[parentCategoryIndex]
                                          .listChildrenCategory[categoryIndex]
                                          .listProduct
                                          .length,
                                      itemBuilder: (context, productIndex) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetailsScreen(
                                                        id: Product
                                                            .category[
                                                                parentCategoryIndex]
                                                            .listChildrenCategory[
                                                                categoryIndex]
                                                            .listProduct[
                                                                productIndex]
                                                            .productId,
                                                      )),
                                            );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 5,
                                              vertical: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey[300],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.white,
                                            ),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3.6,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  5.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  5.0)),
                                                  child: Image.network(
                                                    Product
                                                        .category[
                                                            parentCategoryIndex]
                                                        .listChildrenCategory[
                                                            categoryIndex]
                                                        .listProduct[
                                                            productIndex]
                                                        .image,
                                                    height: SizeConfig
                                                            .screenHeight /
                                                        6.5,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10.0, 10.0, 0, 0),
                                                  child: Text(
                                                    Product
                                                        .category[
                                                            parentCategoryIndex]
                                                        .listChildrenCategory[
                                                            categoryIndex]
                                                        .listProduct[
                                                            productIndex]
                                                        .productName,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500),
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
                                                    '${FlutterMoneyFormatter(settings: MoneyFormatterSettings(
                                                          symbol: 'đ',
                                                          fractionDigits: 0,
                                                        ), amount: Product.category[parentCategoryIndex].listChildrenCategory[categoryIndex].listProduct[productIndex].price).output.symbolOnRight}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          )
                        : Container();
                  })
              //   },
              // ),
              ),
        ),
      ),
    );
    //           },
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
