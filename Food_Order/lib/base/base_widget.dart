import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:provider/provider.dart';

class PageContainer extends StatelessWidget {
  final Widget child;

  final List<SingleChildCloneableWidget> bloc;
  final List<SingleChildCloneableWidget> di;

  PageContainer({this.bloc, this.di, this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: MultiProvider(
          providers: [
            ...di,
            ...bloc,
          ],
          child: Builder(
            builder: (BuildContext context) {
              return OfflineBuilder(
                connectivityBuilder: (BuildContext context,
                    ConnectivityResult connectivity, Widget child) {
                  final bool connected =
                      connectivity != ConnectivityResult.none;
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      child,
                      Positioned(
                        left: 0.0,
                        right: 0.0,
                        height: 20.0,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          color: connected ? null : Color(0xFFEE4400),
                          child: connected
                              ? null
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Không có kế nối mạng!",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    SizedBox(
                                      width: 12.0,
                                      height: 12.0,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  );
                },
                child: child,
              );
            },
          ),
        ),
      ),
    );
  }
}
