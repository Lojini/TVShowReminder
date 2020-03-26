import 'package:flutter/material.dart';

class TvShowList extends StatefulWidget{
  @override
  _TvShowListState createState()=> _TvShowListState();
}

class _TvShowListState extends State<TvShowList>{
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
                  'TV Shows',
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