import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/product_service.dart';
import 'package:Food_Order/data/repo/product_repo.dart';
import 'package:Food_Order/data/repo/rest_error.dart';
import 'package:Food_Order/models/product.dart';
import 'package:Food_Order/module/order/tab_product/food_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListFoodPage extends StatelessWidget {
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
      child: ProductListWidget(),
    );
  }
}

class ProductListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: FoodBloc.getInstance(
        productRepo: Provider.of(context),
        //orderRepo: Provider.of(context),
      ),
      child: Consumer<FoodBloc>(
        builder: (context, bloc, child) => Container(
          child: StreamProvider<Object>.value(
            value: bloc.getProductList(),
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
                var products = data as List<Product>;
                return GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.6),
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return _buildProduct(bloc, products[index]);
                    });
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildProduct(FoodBloc bloc, Product product) {
  return Container(
    child: Container(
      // height: MediaQuery.of(context).size.height / 3.6,
      // width: MediaQuery.of(context).size.width / 2.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0)),
            child: Image.network(
              product.productImage,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
            child: Text('${product.productName}'),
          ),
          Spacer(),
          Divider(
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('${product.price} Đ'),
                //Spacer(),
                FlatButton(
                  height: 30,
                  onPressed: () {},
                  child: Text(
                    '+',
                    style: TextStyle(
                      color: Colors.orange,
                    ),
                  ),
                  shape: CircleBorder(
                    side: BorderSide(color: Colors.orange),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Colors.white),
  );
}
