import 'package:flutter/material.dart';
import 'ui/splash.dart';
import 'ui/bottomNavigator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme:ThemeData(
        textTheme: TextTheme(
          title: TextStyle(
            color: Colors.black,
              fontFamily: 'Montserrat'
          ),
          body1: TextStyle(
              color: Colors.black,
              fontFamily: 'Montserrat'
          ),
          subtitle: TextStyle(
            color: Colors.grey,
              fontFamily: 'Montserrat'
          )
        ),
        accentColor: Color(0xFF4DD0E1),
        primaryColor: Color(0xFF00ACC1)
      ),
      home: Splash(),
      routes: <String, WidgetBuilder>{
        '/Home': (BuildContext context) => new BottomNavigationBarPage()
      },
    );
  }
}

//to reuse the curved theme to all screens
class PageTheme {
  pageTheme(
      String text, BuildContext context, bool isDetailPage, Widget widget) {
    return new Container(
        color: Color(0xFF00ACC1),
        child: ListView(children: [
          Padding(
            padding: EdgeInsets.only(top: 30, bottom: 30),
            child: Row(
              children: [
                isDetailPage == true
                    ? IconButton(
                        icon: new Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    : SizedBox(
                        width: 30,
                      ),
                Flexible(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height - 182.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
              ),
              child: widget)
        ]));
  }
}
