import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tv_reminder/services/reminderApi.dart';
import 'package:tv_reminder/services/watchListApi.dart';
import 'dart:async';
import 'dart:convert';
import '../main.dart';

class ShowDetailsPage extends StatefulWidget {
  final int id;
  ShowDetailsPage({this.id});

  @override
  _ShowDetailsPageState createState() => _ShowDetailsPageState();
}

class _ShowDetailsPageState extends State<ShowDetailsPage> {
   int userData;
   Map data;
   String name, url, air_date, start_date, end_date, country, network, status,documentId,reminderId;
   bool showExists=false;

  Future getData(int userData) async {
    http.Response response = await http.get("https://www.episodate.com/api/show-details?q=$userData");
     setState(() {
       data = json.decode(response.body);
       name=data['tvShow']['name'];
       url=data['tvShow']['image_thumbnail_path'];
       air_date=data['tvShow']['air_date'];
       start_date=data['tvShow']['start_date'];
       end_date=data['tvShow']['end_date'];
       country=data['tvShow']['country'];
       network=data['tvShow']['network'];
       status=data['tvShow']['status'];
    });
  }
   checkExists(String show) async{
     QuerySnapshot queryName = await WatchListAPI.reference.where('showName',isEqualTo: show).getDocuments();
     setState(() {
       if(queryName.documents.length==1) {
         showExists = true;
         documentId=queryName.documents[0].documentID;
       }
       else {
         showExists = false;
       }
     });

   }

   checkIfReminderExists(String name) async{
     QuerySnapshot query = await ReminderAPI.reference.where('showName',isEqualTo: name).getDocuments();
     setState(() {
       if(query.documents.length==1) {
         reminderId=query.documents[0].documentID;
       }
     });

   }

  @override
  void initState() {
    super.initState();
    userData=widget.id;
    getData(userData);
    checkExists(name);
    checkIfReminderExists(name);
  }

  @override
  Widget build(BuildContext context) {
    checkExists(name);
    checkIfReminderExists(name);
    return Scaffold(
        body: PageTheme().pageTheme('$name', context,
        ListView(children: [
            Stack(children: [
              Container(
                height: MediaQuery.of(context).size.height - 82.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent),
              Positioned(
                  top: 5.0,
                  left: (MediaQuery.of(context).size.width / 2) - 60.0,
                  child: url!=null ? Container(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(url),
                      ),
                          height: 130.0,
                          width: 130.0):
                      Container(
                        child: Text("Loading.."),
                      )

              ),
              SizedBox(width: 10.0,),
              Positioned(
                top: 145.0,
                left: 25.0,
                right: 25.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text("Name: $name \n",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold
                            )
                        ),
                        Text("Permalink: $air_date \n",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold
                            )
                        ),
                        Text("Start date: $start_date \n",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold
                            )
                        ),
                        Text("End date: $end_date \n",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold
                            )
                        ),
                        Text("Country: $country \n",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold
                            )
                        ),
                        Text("Network: $network \n",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold
                            )
                        ),
                        Text("Status: $status \n",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ]

                  )
              ),
              Positioned(
                top: 450.0,
                left: 80.0,
                right: 80.0,
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: showExists?() {
                    _confirmDialog(context,"Are you sure you want to remove this show from the list?\n\nReminder for this show will be deleted",true);
                     }:(){
                    _confirmDialog(context,'Do you want to add this show to your watch list?',false);
                     },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [Color(0xFF00ACC1), Color(0xFF80DEEA)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30.0)
                        ),
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: showExists?Text(
                        "Added to watchlist",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ):Text(
                          "Add to watchlist",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white
                          ),
                          ),
                        ),
                      ),
                    ),
                  )

              )

              ])
        ]))
    );
  }

   Future _confirmDialog(BuildContext context,String text,bool isAdded){
     return showDialog(
         context:context,
         builder: (context) {
           return AlertDialog(
             title: Align(alignment:Alignment.topLeft,child:Icon(Icons.favorite,color: Colors.red)),
             content:Text(text),
             actions: <Widget>[
               Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children:<Widget>[
                     RaisedButton(
                       color: Colors.cyan[600],
                       child:Text('Yes'),
                       onPressed: isAdded?(){
                         WatchListAPI.deleteWatchlist(documentId);
                         ReminderAPI.deleteReminder(reminderId);
                         Navigator.pop(context);
                       }:
                       (){
                         WatchListAPI.addToWatchlist(userData,name,url,null);
                         Navigator.pop(context);
                       }
                     ),
                     SizedBox(width: 10,),
                     RaisedButton(
                       color: Colors.red,
                       child: Text('Cancel'),
                       onPressed: (){
                         Navigator.pop(context);
                       },
                     )
                   ]
               )
             ],
           );
         });
   }
   
}