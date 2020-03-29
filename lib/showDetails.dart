import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'tvshowlist.dart';
import 'main.dart';

class ShowDetailsPage extends StatefulWidget {
  @override
  _ShowDetailsPageState createState() => _ShowDetailsPageState();
}

class _ShowDetailsPageState extends State<ShowDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageTheme().pageTheme('Show Details', context,
        ListView(children: [
            Stack(children: [
              Container(
                height: MediaQuery.of(context).size.height - 82.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent),
              Positioned(
                  top: -20.0,
                  left: (MediaQuery.of(context).size.width / 2) - 100.0,
                  child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/sun.jpg'),
                                  fit: BoxFit.cover)),
                          height: 200.0,
                          width: 200.0)
              ),

            ])
        ]
        ))
    );
  }
}