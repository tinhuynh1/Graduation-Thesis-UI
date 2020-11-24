import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/data/remote/store_service.dart';
import 'package:Food_Order/data/repo/rest_error.dart';
import 'package:Food_Order/data/repo/store_repo.dart';
import 'package:Food_Order/models/store.dart';
import 'package:Food_Order/module/store/detail_branch_page.dart';
import 'package:Food_Order/module/store/store_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class StorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(di: [
      Provider.value(
        value: StoreService(),
      ),
      ProxyProvider<StoreService, StoreRepo>(
        update: (context, storeService, previous) =>
            StoreRepo(storeService: storeService),
      ),
    ], bloc: [], child: MapScreen());
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController _controller;
  PageController _pageController;
  int prevPage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              'Store',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            )),
        backgroundColor: Colors.grey.shade200,
        body: ChangeNotifierProvider.value(
          value: StoreBloc.getInstance(storeRepo: Provider.of(context)),
          child: Consumer<StoreBloc>(
            builder: (context, bloc, child) => Container(
              child: StreamProvider<Object>.value(
                value: bloc.getStoreList(),
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
                    var listBranch = data as List<Store>;
                    return Scaffold(
                      body: Stack(children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height - 50.0,
                          width: MediaQuery.of(context).size.width,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(10.8782694, 106.8044371),
                              zoom: 12.0,
                            ),
                            //markers: Set.from(elements)),
                            onMapCreated: mapCreated,
                          ),
                        ),
                        Positioned(
                          bottom: 40.0,
                          child: Container(
                            height: 200.0,
                            width: MediaQuery.of(context).size.width,
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: listBranch.length,
                              itemBuilder: (BuildContext context, int index) {
                                return _branchList(listBranch, index);
                              },
                            ),
                          ),
                        ),
                      ]),
                    );
                  },
                ),
              ),
            ),
          ),
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      //moveCamera();
    }
  }

  moveCamera(List<Store> branch) {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(branch[_pageController.page.toInt()].lat,
            branch[_pageController.page.toInt()].long),
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  _branchList(List<Store> branchs, int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 0;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 250.0,
            width: Curves.easeInOut.transform(value) * 400.0,
            child: widget,
          ),
        );
      },
      child: Stack(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20.0,
              ),
              height: 125.0,
              width: 275.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 10.0,
                    ),
                  ]),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailBranchPage(
                        id: index,
                        store: branchs,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white),
                  child: Row(
                    children: [
                      Container(
                        height: 125.0,
                        width: 125.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(branchs[index].image),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            branchs[index].address,
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
