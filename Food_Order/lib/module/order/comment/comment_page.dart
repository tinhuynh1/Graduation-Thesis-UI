import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/product_service.dart';
import 'package:Food_Order/data/repo/product_repo.dart';
import 'package:Food_Order/data/repo/rest_error.dart';
import 'package:Food_Order/models/comment.dart';
import 'package:Food_Order/module/order/product_bloc.dart';
import 'package:Food_Order/shared/widget/smooth_star_rating.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommentPage extends StatelessWidget {
  final int id;

  const CommentPage({Key key, this.id}) : super(key: key);
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
        )
      ],
      bloc: [],
      child: CommentScreen(id: id),
    );
  }
}

class CommentScreen extends StatefulWidget {
  final int id;

  const CommentScreen({Key key, this.id}) : super(key: key);
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('vi');
    return ChangeNotifierProvider.value(
      value: ProductBloc.getInstance(productRepo: Provider.of(context)),
      child: Consumer<ProductBloc>(
        builder: (context, bloc, child) => Container(
          child: StreamProvider.value(
            value: bloc.getComments(widget.id),
            initialData: null,
            catchError: (context, error) {
              return error;
            },
            child: Consumer<Object>(
              builder: (context, data, child) {
                if (data == null || data is RestError) return Container();
                var listComment = data as List<Comment>;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Đánh giá",
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
                      itemCount: listComment == null ? 0 : listComment.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 25.0,
                            backgroundImage: NetworkImage(
                              listComment[index].customer.avatar,
                            ),
                          ),
                          title: Text(listComment[index].customer.customerName),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    DateFormat.yMd('vi')
                                        .format(listComment[index].createDate),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 7.0),
                              Text(
                                listComment[index].content,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
