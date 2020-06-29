import 'package:flutter/material.dart';
import 'home.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.lightGreen),
        title: 'Hackathon',
        home: Splash());
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 4),
        () => Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return home();
            })));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white),
        child: Image.network('https://user-images.githubusercontent.com/47937749/85965646-c5268f80-b9d6-11ea-8dc5-a16a1706372a.png'),
    );
  }
}