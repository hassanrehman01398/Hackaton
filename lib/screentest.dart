import 'package:flutter/material.dart';

class screentest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("data"),
            Row(
              children: <Widget>[
                RaisedButton(onPressed: (){},
                child:Text("Yes")),
                RaisedButton(onPressed: (){},
                child:Text("No"))
              ],
            )
          ],
          )
      ),
    );
  }
}
