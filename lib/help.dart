import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget{
  @override
  _HelpPageState createState()=> _HelpPageState();
}

class _HelpPageState extends State<HelpPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color:  Colors.cyan[600],
          child: ListView(
            children:[
              Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  'Help',
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