import 'package:flutter/material.dart';

class Reminder extends StatefulWidget{
  @override
  _ReminderState createState()=> _ReminderState();
}

class _ReminderState extends State<Reminder>{
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
                  'Reminder',
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