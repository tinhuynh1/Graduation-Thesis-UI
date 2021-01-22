import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/product_service.dart';
import 'package:Food_Order/data/repo/product_repo.dart';
import 'package:Food_Order/shared/constant.dart';
import 'package:Food_Order/shared/size_config.dart';
import 'package:Food_Order/shared/widget/card/product_card.dart';
import 'package:Food_Order/shared/widget/custom_tab_view.dart';
import 'package:Food_Order/shared/widget/home_tile.dart';
import 'package:Food_Order/shared/widget/see_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

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
  AutoScrollController controller;
  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollToIndex(1);
        },
        tooltip: 'Increment',
        child: Icon(
          Icons.filter_alt_outlined,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            CustomTabView(
              initPosition: initPosition,
              itemCount: Product.category.length,
              tabBuilder: (context, index) =>
                  Tab(text: Product.category[index].parentCategoryName),
              pageBuilder: (context, parentCategoryIndex) => Container(
                color: Color(0xfff0eff4),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  controller: controller,
                  itemCount: Product.category[parentCategoryIndex]
                      .listChildrenCategory.length,
                  itemBuilder: (context, categoryIndex) {
                    return Product
                                .category[parentCategoryIndex]
                                .listChildrenCategory[categoryIndex]
                                .listProduct !=
                            null
                        ? AutoScrollTag(
                            key: ValueKey(categoryIndex),
                            controller: controller,
                            index: categoryIndex,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  HomeTitle(
                                      text: Product
                                              .category[parentCategoryIndex]
                                              .listChildrenCategory[
                                                  categoryIndex]
                                              .categoryName +
                                          categoryIndex.toString()),
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
                                        return CardProduct(
                                          idProduct: Product
                                              .category[parentCategoryIndex]
                                              .listChildrenCategory[
                                                  categoryIndex]
                                              .listProduct[productIndex]
                                              .productId,
                                          listParentCategory: Product.category,
                                          parentCategoryIndex:
                                              parentCategoryIndex,
                                          categoryIndex: categoryIndex,
                                          productIndex: productIndex,
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container();
                  },
                ),
                // child: ListView(
                //   scrollDirection: Axis.vertical,
                //   controller: controller,
                //   children: <Widget>[
                //     ...List.generate(20, (index) {
                //       return AutoScrollTag(
                //         key: ValueKey(index),
                //         controller: controller,
                //         index: index,
                //         child: Container(
                //           height: 100,
                //           color: Colors.red,
                //           margin: EdgeInsets.all(10),
                //           child: Center(child: Text('index: $index')),
                //         ),
                //         highlightColor: Colors.black.withOpacity(0.1),
                //       );
                //     }),
                //   ],
                // ),
              ),
            ),
            //display "xem gio hang" button
            ListProduct.listProduct.isNotEmpty ? SeeCartButton() : Container(),
          ],
        ),
      ),
    );
  }

  Future _scrollToIndex(int index) async {
    await controller.scrollToIndex(index,
        preferPosition: AutoScrollPosition.begin);
    print('Scroll to' + index.toString());
  }
}
