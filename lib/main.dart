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
        child: Image.network('https://raw.githubusercontent.com/hassanrehman01398/Hackaton/master/download.jpg?token=ALGAESJEZ6EFWCSGAUDGKR27AB2NM'),
    );
  }
}