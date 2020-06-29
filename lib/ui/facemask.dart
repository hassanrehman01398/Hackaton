
import 'package:flutter/material.dart';
import 'package:hackathon/app/colors.dart';
import 'package:hackathon/app/icons.dart';
import 'package:hackathon/app/strings.dart';
import 'package:url_launcher/url_launcher.dart';

import 'camera_screen.dart';
import 'local_storage.dart';

class Facemask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              code,
              color: green,
              size: 25,
              semanticLabel: codeString,
            ),
            onPressed: () {
              gotoWebPage();
            },
          )
        ],
        backgroundColor: yellow.withOpacity(0.6),
        title: Text(
          title,
          style: TextStyle(color: black, fontFamily: gilroy),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: yellow.withOpacity(0.4),
            border: Border.all(color: yellow, width: 5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(illustrator),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CameraPage()));
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: yellow,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 3, color: white)),
                child: Text(
                  liveCamera,
                  style: TextStyle(
                      color: black,
                      fontFamily: gilroy,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LocalStorage()));
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                decoration: BoxDecoration(
                    color: yellow,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 3, color: white)),
                child: Text(
                  fromGallery,
                  style: TextStyle(
                      color: black,
                      fontFamily: gilroy,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  gotoWebPage() async {
    if (await canLaunch(urlString)) {
      await launch(urlString);
    } else {
      throw "Could not launch $urlString";
    }
  }
}
