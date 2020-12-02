import 'package:PicBee1/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Home();
            })));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(),
            Shimmer.fromColors(
              period: Duration(milliseconds: 1200),
              baseColor: Colors.white,
              highlightColor: Colors.grey,
              child: Text(
                'PicBee',
                style: TextStyle(
                  fontFamily: "Signatra",
                  fontSize: 90.0,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 50.0),
              child: SpinKitThreeBounce(
                color: Colors.white,
                size: 40.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
