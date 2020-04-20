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
        accentColor: Color(0xFF6cc3c1),
        primaryColor: Color(0xFF42CCC8)
      ),
      home: Splash(),
      routes: <String, WidgetBuilder>{
        '/Home': (BuildContext context) => new BottomNavigationBarPage()
      },
    );
  }
}

//to reuse the curved theme to all screens
class PageTheme{
  pageTheme(String text,BuildContext context,Widget widget){
    return new Container(
        color:  Color(0xFF42CCC8),
        child:ListView(
            children:[
              Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  text,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height - 185.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
                  ),
                  child: widget
              )
            ]
        )
    );
  }
}