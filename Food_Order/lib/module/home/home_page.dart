import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/user_service.dart';
import 'package:Food_Order/models/cuisineitems.dart';
import 'package:Food_Order/models/nearbyitems.dart';
import 'package:Food_Order/models/popularitems.dart';
import 'package:Food_Order/shared/ultil/cards.dart';
import 'package:Food_Order/shared/widget/home_tile.dart';
import 'package:Food_Order/shared/widget/slider_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  List<CuisineItems> cuisineItems = [
    CuisineItems(
        text: "Pizza & Pasta",
        secondaryText: "28 reviews",
        image: "images/pizza.jpeg"),
    CuisineItems(
        text: "Sushi", secondaryText: "26 reviews", image: "images/sushi.jpeg"),
    CuisineItems(
        text: "Mexican",
        secondaryText: "31 reviews",
        image: "images/mexican.jpeg"),
  ];
  List<PopularItems> popularItems = [
    PopularItems(
        text: "Thai Me Up Restaurant &\nBrewery", image: "images/brewery.jpeg"),
    PopularItems(
        text: "Tequila Mackingbir\nGreenpoint",
        image: "images/greenpoint.jpeg"),
  ];
  List<NearByItems> nearbyItems = [
    NearByItems(
        text: "Sotto || Ponte Pizza\nPasta Tradizionali",
        image: "images/ponte_pizza.jpeg"),
    NearByItems(
        text: "Delicious Pizza & Pasta\nTraditionaly",
        image: "images/delicious.jpeg"),
    NearByItems(
        text: "Delicious Pizza & Pasta\nTraditionaly",
        image: "images/delicious.jpeg"),
  ];
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
        appBar: _buildAppbar(),
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   automaticallyImplyLeading: false,
        //   title: Row(
        //     children: <Widget>[
        //       Icon(
        //         Icons.person,
        //         color: Colors.grey,
        //         size: 35.0,
        //       ),
        //       FlatButton(
        //         onPressed: () {},
        //         child: Text(
        //           "Đăng nhập",
        //           style: TextStyle(color: Colors.orange),
        //         ),
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(18.0),
        //           side: BorderSide(color: Colors.orange),
        //         ),
        //       )
        //     ],
        //   ),
        //   actions: <Widget>[
        //     IconButton(
        //       icon: Icon(
        //         Icons.notifications_outlined,
        //         color: Colors.grey,
        //         size: 35.0,
        //       ),
        //       onPressed: () {},
        //       tooltip: "Notifications",
        //     ),
        //   ],
        // ),
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.grey,
                height: 120,
                child: Row(
                    //item 1, item 2, item 3
                    ),
              ),
              SizedBox(
                height: 20,
              ),
              HomeTitle(text: "Ưu đãi đặc biệt"),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 300,
                child: ListView.builder(
                  itemCount: cards == null ? 0 : cards.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 16),
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
              Container(
                height: 300,
                child: ListView.builder(
                  itemCount: cards == null ? 0 : cards.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 16),
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

AppBar _buildAppbar() {
  return AppBar(
    elevation: 0,
    backgroundColor: Color(0xFFEEEEEE),
    brightness: Brightness.light,
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
                      width: 5,
                    ),
                    Icon(
                      Icons.loyalty,
                      color: Colors.orange,
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
