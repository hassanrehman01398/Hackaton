import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'imageCapture.dart';

class alert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AppBar(
                  elevation: 0,
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  title: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'A',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 40)),
                        TextSpan(
                            text: '!',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 50)),
                        TextSpan(
                            text: 'ERT',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 40)),
                      ],
                    ),
                  ),
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          )),
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          child: ListView(children: <Widget>[
            SizedBox(height: 20),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => emergency()));
                },
                child: Container(
                    decoration: BoxDecoration(
                      // border: Border.all(
                      //   color: Colors.red[500],
                      //   width: 5
                      // ),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment(0.8,
                            0.0), // 10% of the width, so there are ten blinds.
                        colors: [
                          const Color(0xFFfc594e),
                          const Color(0xFFff3b2d)
                        ], // whitish to gray
                        //tileMode: TileMode.repeated, // repeats the gradient over the canvas
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.red.withOpacity(0.5),
                            spreadRadius: 4,
                            blurRadius: 3,
                            offset: Offset(2, 4))
                      ],
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.red[500],
                      // Colors.red[500].withOpacity(0.8),
                    ),
                    height: 120,
                    width: double.infinity,
                    child: Center(
                        child: Text(
                      "Emergency",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )))),
            SizedBox(height: 30),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ImageCapture()));
                },
                child: Container(
                    decoration: BoxDecoration(
                      // border: Border.all(
                      //   color: Colors.red[500],
                      //   width: 5
                      // ),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment(0.8,
                            0.0), // 10% of the width, so there are ten blinds.
                        colors: [
                          const Color(0xFF8c8c8c),
                          const Color(0xFF686868)
                        ], // whitish to gray
                        //tileMode: TileMode.repeated, // repeats the gradient over the canvas
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 4,
                            blurRadius: 3,
                            offset: Offset(2, 4))
                      ],
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.grey[500],
                      // Colors.red[500].withOpacity(0.8),
                    ),
                    height: 120,
                    width: double.infinity,
                    child: Center(
                        child: Text(
                      "Record",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )))),
            SizedBox(height: 30),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => emergency()));
                },
                child: Container(
                    decoration: BoxDecoration(
                      // border: Border.all(
                      //   color: Colors.red[500],
                      //   width: 5
                      // ),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment(0.8,
                            0.0), // 10% of the width, so there are ten blinds.
                        colors: [
                          const Color(0xFF639ff9),
                          const Color(0xFF0267ff)
                        ], // whitish to gray
                        //tileMode: TileMode.repeated, // repeats the gradient over the canvas
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blue.withOpacity(0.5),
                            spreadRadius: 4,
                            blurRadius: 3,
                            offset: Offset(2, 4))
                      ],
                      borderRadius: BorderRadius.circular(25.0),
                      //color: Colors.blueAccent,
                      // Colors.red[500].withOpacity(0.8),
                    ),
                    height: 120,
                    width: double.infinity,
                    child: Center(
                        child: Text(
                      "NewsFeed",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )))),
          ])),
    );
  }
}

class alerthome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height * 0.65,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.blueGrey,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      'This is a quick Alert Part of the App\n',
                                  style: TextStyle(
                                      color: Colors.lightGreenAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: "Quicksand")),
                              TextSpan(
                                  text:
                                      '\nIt has 3 quick shortcuts\n\nEMERGENCY - Contact Police, FireBrigade and Other saftey organizations with one touch sending them your information and location\n\nCAMERA - Open camera and take a picture or record a video to capture the situation\n\nNEWS FEED - See news related to safety around your area and posts by other users.',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: "Quicksand")),
                            ],
                          ),
                        ),
                      ),
                    )),
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => alert()));
                  },
                  child: Icon(FontAwesomeIcons.check),
                )
              ],
            )));
  }
}

class emergency extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: Container(
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
            ),
          )),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.indigo,
              ),
              height: 80,
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  launch("tel://12345");
                },
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => emergency()));
                // },
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 10.0,
                    color: Colors.white,
                    child: Center(
                        child: Text(
                      "Police",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ))),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.brown[500],
              ),
              child: GestureDetector(
                onTap: () {
                  launch("tel://1234");
                },
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => emergency()));
                // },
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 10.0,
                    color: Colors.white,
                    child: Center(
                        child: Text(
                      "Rangers",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ))),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.red[500],
              ),
              child: GestureDetector(
                onTap: () {
                  launch("tel://123");
                },
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => emergency()));
                // },
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 10.0,
                    color: Colors.white,
                    child: Center(
                        child: Text(
                      "Ambulance",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ))),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.yellow[500],
              ),
              child: GestureDetector(
                onTap: () {
                  launch("tel://12345");
                },
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => emergency()));
                // },
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 10.0,
                    color: Colors.white,
                    child: Center(
                        child: Text(
                      "Fire Brigade",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ))),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue[500],
              ),
              child: GestureDetector(
                onTap: () {
                  launch("tel://12");
                },
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => emergency()));
                // },
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 10.0,
                    color: Colors.white,
                    child: Center(
                        child: Text(
                      "Aashaa",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ))),
              ),
            ),
          ])),
    );
  }
}
