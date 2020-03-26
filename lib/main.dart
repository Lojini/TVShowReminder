import 'package:flutter/material.dart';
import 'splash.dart';
import 'bottomNavigator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
      routes: <String, WidgetBuilder>{
        '/Home': (BuildContext context) => new BottomNavigationBarPage()
      },
    );
  }
}

//to reuse the widget
class PageTheme{
  pageTheme(String text,Widget widget,BuildContext context){
    return new Container(
        color:  Colors.cyan[600],
        child:ListView(
            children:[
              Padding(
                padding: EdgeInsets.all(25),
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
                  height: MediaQuery.of(context).size.height - 175.0,
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