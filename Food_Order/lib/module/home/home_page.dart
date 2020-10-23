import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/models/cuisineitems.dart';
import 'package:Food_Order/shared/ultil/cards.dart';
import 'package:Food_Order/shared/widget/home_tile.dart';
import 'package:Food_Order/shared/widget/slider_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
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
        //appBar: _buildAppbar(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Row(
            children: <Widget>[
              Icon(
                Icons.person,
                color: Colors.grey,
                size: 35.0,
              ),
              FlatButton(
                onPressed: () {},
                child: Text(
                  "Đăng nhập",
                  style: TextStyle(color: Colors.orange),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.orange),
                ),
              )
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.notifications_outlined,
                color: Colors.grey,
                size: 35.0,
              ),
              onPressed: () {},
              tooltip: "Notifications",
            ),
          ],
        ),
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(top: 25),
                color: Colors.white,
                height: 130,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  //item 1, item 2, item 3
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'assets/resources_images_intro_onboadingbg1.png',
                            width: 60,
                          ),
                          Text(
                            'Tích điểm',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'assets/resources_images_intro_onboadingbg1.png',
                            width: 60,
                          ),
                          Text(
                            'Tích điểm',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'assets/resources_images_intro_onboadingbg1.png',
                            width: 60,
                          ),
                          Text(
                            'Tích điểm',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'assets/resources_images_intro_onboadingbg1.png',
                            width: 60,
                          ),
                          Text(
                            'Tích điểm',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              HomeTitle(text: "Ưu đãi đặc biệt"),
              Container(
                padding: EdgeInsets.only(top: 10),
                height: 310,
                child: ListView.builder(
                  itemCount: cards == null ? 0 : cards.length,
                  scrollDirection: Axis.horizontal,
                  //padding: EdgeInsets.only(left: 10),
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    Map card = cards[index];
                    return SliderHome(
                      img: card['img'],
                      title: card['title'],
                      desc: card['desc'],
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              HomeTitle(text: "Cập nhật từ Nhà"),
              Container(
                padding: EdgeInsets.only(top: 10),
                height: 300,
                child: ListView.builder(
                  itemCount: cards == null ? 0 : cards.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    Map card = cards[index];
                    return SliderHome(
                      img: card['img'],
                      title: card['title'],
                      desc: card['desc'],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//UI Appbar khi da dang nhao
AppBar _buildAppbarWithAuthenticated() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    title: Container(
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(70),
            child: Image(
              image: NetworkImage(
                  'https://s3.amazonaws.com/uifaces/faces/twitter/byryan/128.jpg'),
              width: 35,
              height: 35,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Dickens',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'Khách hàng mới',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.loyalty,
                      color: Colors.orange,
                      size: 14,
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
