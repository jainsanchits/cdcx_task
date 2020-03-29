import 'dart:async';

import 'package:cdcxtask/HomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: new ThemeData(
      primarySwatch: Colors.grey,
      brightness: Brightness.dark,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/logo.png"),
            SizedBox(
              height: 10,
            ),
            Text(
              "Welcome To CoinDCX",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )
          ]),
    ));
  }
}
