import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoAccountPage extends StatefulWidget {
  @override
  _InfoAccountPageState createState() => _InfoAccountPageState();
}

class _InfoAccountPageState extends State<InfoAccountPage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [
        Provider.value(
          value: UserService(),
        ),
      ],
      bloc: [],
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(170.0),
          child: AppBar(
            backgroundColor: Colors.white,
            title: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Image(
                    image: NetworkImage(
                        'https://s3.amazonaws.com/uifaces/faces/twitter/byryan/128.jpg'),
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  'Kuhic',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
        ),
        body: Container(),
      ),
    );
  }
}
