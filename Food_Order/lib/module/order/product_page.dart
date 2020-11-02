import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/product_service.dart';
import 'package:Food_Order/data/repo/product_repo.dart';
import 'package:Food_Order/data/repo/rest_error.dart';
import 'package:Food_Order/models/product/parent_category.dart';
import 'package:Food_Order/module/order/product_bloc.dart';
import 'package:Food_Order/shared/widget/custom_tab_view.dart';
import 'package:flutter/material.dart';
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
  int initPosition = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: ProductBloc.getInstance(productRepo: Provider.of(context)),
      child: Consumer<ProductBloc>(
        builder: (context, bloc, child) => Container(
          child: StreamProvider<Object>.value(
            value: bloc.getParentCategoryList(),
            initialData: null,
            catchError: (context, error) {
              return error;
            },
            child: Consumer<Object>(
              builder: (context, data, child) {
                if (data == null) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.orange,
                    ),
                  );
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
                var parentCategorys = data as List<ParentCategory>;
                return Scaffold(
                  body: SafeArea(
                    child: CustomTabView(
                      initPosition: initPosition,
                      itemCount: parentCategorys.length,
                      tabBuilder: (context, index) =>
                          Tab(text: parentCategorys[index].parentCategoryName),
                      pageBuilder: (context, parentCategoryIndex) => Container(
                        color: Colors.grey[200],
                        child: Consumer<Object>(
                          builder: (context, data, child) {
                            return ListView.builder(
                                itemCount: parentCategorys[parentCategoryIndex]
                                    .listChildrenCategory
                                    .length,
                                itemBuilder: (context, categoryIndex) {
                                  return parentCategorys[parentCategoryIndex]
                                              .listChildrenCategory[
                                                  categoryIndex]
                                              .listProduct !=
                                          null
                                      ? Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 10),
                                                child: Text(parentCategorys[
                                                        parentCategoryIndex]
                                                    .listChildrenCategory[
                                                        categoryIndex]
                                                    .categoryName),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: GridView.builder(
                                                    shrinkWrap: true,
                                                    primary: false,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      childAspectRatio:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  1.6),
                                                    ),
                                                    itemCount: parentCategorys[
                                                            parentCategoryIndex]
                                                        .listChildrenCategory[
                                                            categoryIndex]
                                                        .listProduct
                                                        .length,
                                                    itemBuilder: (context,
                                                        productIndex) {
                                                      return Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 5,
                                                          vertical: 5,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: Colors.white,
                                                        ),
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            3.6,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            5,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            ClipRRect(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft:
                                                                      const Radius
                                                                              .circular(
                                                                          5.0),
                                                                  topRight:
                                                                      const Radius
                                                                              .circular(
                                                                          5.0)),
                                                              child:
                                                                  Image.network(
                                                                parentCategorys[parentCategoryIndex]
                                                                    .listChildrenCategory[
                                                                        categoryIndex]
                                                                    .listProduct[
                                                                        productIndex]
                                                                    .image,
                                                                height: 130,
                                                                width: double
                                                                    .infinity,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      10.0,
                                                                      10.0,
                                                                      0,
                                                                      0),
                                                              child: Text(parentCategorys[parentCategoryIndex]
                                                                  .listChildrenCategory[
                                                                      categoryIndex]
                                                                  .listProduct[
                                                                      productIndex]
                                                                  .productName),
                                                            ),
                                                            Spacer(),
                                                            Divider(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      10,
                                                                      0,
                                                                      0,
                                                                      0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: <
                                                                    Widget>[
                                                                  Text(parentCategorys[parentCategoryIndex]
                                                                      .listChildrenCategory[
                                                                          categoryIndex]
                                                                      .listProduct[
                                                                          productIndex]
                                                                      .price
                                                                      .toString()),
                                                                  FlatButton(
                                                                    height: 30,
                                                                    onPressed:
                                                                        () {},
                                                                    child: Text(
                                                                      '+',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .orange,
                                                                      ),
                                                                    ),
                                                                    shape:
                                                                        CircleBorder(
                                                                      side: BorderSide(
                                                                          color:
                                                                              Colors.orange),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                              )
                                            ],
                                          ),
                                        )
                                      : Container();
                                });
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
