import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackathon/app/colors.dart';
import 'package:hackathon/route1.dart';
import 'package:hackathon/stores/statistics/statistics_notifier.dart';
import 'package:hackathon/ui/gotoquiz.dart';
import 'package:hackathon/ui/home/home_navigator.dart';
import 'package:hackathon/ui/home/home_screen.dart';
import 'package:hackathon/ui/reduce_pullution.dart';
import 'package:hackathon/ui/screens.dart';
import 'package:hackathon/utils/bloc/application_bloc.dart';
import 'package:hackathon/utils/bloc/application_events.dart';
import 'package:hackathon/utils/bloc/application_state.dart';
import 'package:provider/provider.dart';
import 'alert.dart';
import 'package:hackathon/covid.dart';
import 'package:hackathon/polutracker.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'data/repository/base_repository.dart';
import 'data/repository/user_repository.dart';
import 'services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var user;

class home extends StatelessWidget {
  const home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    login();
    final BaseRepository repository = UserRepository();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        top: 120,
                        left: 140,
                        child: Stack(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.white,
                            ),
                            Positioned(
                              top: 10.0,
                              left: 16,
                              child: Container(
                                  height: 110,
                                  width: 110,
                                  child: Image.asset("assets/images/logo.png")),
                            )
                          ],
                        )),
                  ],
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/bg.png'),
                        fit: BoxFit.cover),
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.lightGreen[800],
                          Colors.lightGreen[500],
                          Colors.lightGreen[200]
                        ])),
                height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Pollution Tracker",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25)),
                        SizedBox(height: 5),
                        Text(
                          "100 of 460 contribution",
                          style: TextStyle(fontSize: 12),
                        ),
                      ]),
                  //  FlexibleSpaceBar(),
                  Spacer(
                    flex: 4,
                  ),
                  CircularPercentIndicator(
                    radius: 80.0,
                    lineWidth: 5.0,
                    percent: 100 / 460,
                    center: Text("100",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            decoration: TextDecoration.underline)),
                    progressColor: Colors.red,
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 10.0,
                    child: GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => alerthome())),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.22,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.exclamationTriangle,
                              color: Colors.blueGrey[800],
                              size: 60,
                            ),
                            SizedBox(height: 10),
                            Text("Alert",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ),
                    )),
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 10.0,
                    child: GestureDetector(
                      onTap: () => runApp(
                        BlocProvider<ApplicationBloc>(
                          create: (BuildContext context) {
                            return ApplicationBloc(userRepository: repository)
                              ..add(AppStarted(context: context));
                          },
                          child: Route1(
                            repository: repository,
                          ),
                        ),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.22,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.viruses,
                              color: Colors.blueGrey[800],
                              size: 60,
                            ),
                            SizedBox(height: 10),
                            Text("Covid 19",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 10.0,
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReducePullution())),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.22,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.recycle,
                              color: Colors.blueGrey[800],
                              size: 60,
                            ),
                            SizedBox(height: 10),
                            Text("Recycling",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ),
                    )),
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 10.0,
                    child: GestureDetector(
                      onTap: ()
                          // Navigator.push(
                          //    context,
                          //    MaterialPageRoute(
                          //        builder: (context) => TopicScreen())),
                          async {
                        //    var user = await loginMethod();
                        if (user != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Gotoquiz()));
                        }
                      },
                      //   LoginButton(text: 'Continue as Guest', loginMethod: auth.anonLogin),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.22,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.smokingBan,
                              color: Colors.blueGrey[800],
                              size: 60,
                            ),
                            SizedBox(height: 10),
                            Text("Polu Tracker",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  login() async {
    //AuthService auth = AuthService();
    print("login");
//             auth.anonLogin;

    // final FirebaseAuth _auth = FirebaseAuth.instance;
    //        AuthResult auth= await _auth.signInAnonymously();
    //   FirebaseUser user =auth.user;

    AuthService auth = AuthService();
    user = await auth.anonLogin();

    //  },
    //  print("login1"+user.toString());

    //     FirebaseUser user =auth.user;
    //  var user = await loginMethod();
    //  if (user != null) {
    //          }
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
