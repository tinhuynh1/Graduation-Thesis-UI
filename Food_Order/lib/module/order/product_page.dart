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
    return Scaffold(
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
                                HomeTitle(
                                    text: Product
                                        .category[parentCategoryIndex]
                                        .listChildrenCategory[categoryIndex]
                                        .categoryName),
                                Container(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: MediaQuery.of(context)
                                              .size
                                              .width /
                                          (MediaQuery.of(context).size.height /
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
                                            .listChildrenCategory[categoryIndex]
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
                          )
                        : Container();
                  },
                ),
              ),
            ),
            //display "xem gio hang" button
            ListProduct.listProduct.isNotEmpty ? SeeCartButton() : Container(),
          ],
        ),
      ),
    );
  }
}
