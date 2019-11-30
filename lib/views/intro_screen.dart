import 'package:flutter/material.dart';
import 'package:lost_and_found/views/root_page.dart';
import 'package:lost_and_found/views/sign_in_page.dart';
import 'package:splashscreen/splashscreen.dart';

class IntroScreen extends StatefulWidget {
  static const String routeName = '/intro';
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return _introScreen();
  }

  Widget _introScreen() {
    return Stack(
      children: <Widget>[
        SplashScreen(
          seconds: 5,
          backgroundColor: Colors.blue,
          navigateAfterSeconds: RootPage(),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Text(
            'Lost_and_Found',
            style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold),
          ),
        )),
      ],
    );
  }
}
