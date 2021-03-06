/* Splash screen of the application.
   This screen shows the app name with its tagline and an animated gif.
   Reference:
     to hold the splash screen for few seconds:
        https://stackoverflow.com/questions/50129761/flutter-hold-splash-screen-for-3-seconds-how-to-implement-splash-screen-in-flut
 */
import 'dart:async';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 6),
        () => Navigator.of(context).pushReplacementNamed('/Home'));
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              gradient: new LinearGradient(colors: [
                const Color(0xFF00ACC1),
                const Color(0xFF80DEEA),
              ], begin: Alignment.topRight, end: Alignment.bottomRight),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                    child: Image(
                  image: AssetImage('assets/logo.png'),
                )),
                SizedBox(height: 20),
                Text(
                  'Remind you what to watch',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16),
                ),
                SizedBox(
                  height: 70,
                ),
                Container(
                    child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/tv_loading.gif',
                    ),
                    Text(
                      'Loading...',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                ))
              ],
            )));
  }
}
