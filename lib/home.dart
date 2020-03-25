import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.white,
          backgroundColor: Colors.cyan[600],
          items: <Widget>[
            Icon(Icons.tv,size: 30,),
            Icon(Icons.list,size: 30,),
            Icon(Icons.history,size: 30),
            Icon(Icons.help_outline,size: 30,)
          ],
        ),
        body: Container(
          color:  Colors.cyan[600],
          child: ListView(
            children:[
              Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  'Watch List',
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
                child: ListView(
                  children: <Widget>[

                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}