import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tv_reminder/models/watchList.dart';
import 'package:tv_reminder/services/reminderApi.dart';
import 'package:tv_reminder/services/watchListApi.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:tv_reminder/ui/confirmationDialog.dart';
import 'dart:async';
import 'dart:convert';
import '../main.dart';

// Start Show DetailsPage
class ShowDetailsPage extends StatefulWidget {
  final int id;
  final DateTime airStamp;

  ShowDetailsPage({this.id, this.airStamp});

  @override
  _ShowDetailsPageState createState() => _ShowDetailsPageState();
}
// End Show DetailsPage

// Start _ShowDetailsPageState
class _ShowDetailsPageState extends State<ShowDetailsPage> {
  int showId;
  Map data;
  WatchList watchList;
  String name, image, day, country, network, documentId, reminderId;
  double rating = 4.3;
  bool showExists = false;
  var date, time;

  Future getData(int showId) async {
    // Fetch the TV shows data from API
    http.Response response =
        await http.get("http://api.tvmaze.com/shows/$showId");
    //debugPrint(response.body);

    //set API's data into variables
    setState(() {
      data = json.decode(response.body);
      name = data['name'];
      image = data["image"]["original"];
      country = data['network']['country']['name'];
      network = data['network']['name'];
      date = DateFormat.yMMMMd("en_US").format(widget.airStamp);
      time = DateFormat.jm().format(widget.airStamp);
      rating = data['rating']['average'] == null
          ? double.parse(data['rating']['average'])
          : 4.3;
      watchList = new WatchList(
          showId: showId,
          showName: name,
          imageUrl: image,
          showDateTime: widget.airStamp,
          reminder: false);
    });

    debugPrint(data.toString());
  }

  checkExists(String show) async {
    QuerySnapshot queryName = await WatchListAPI.reference
        .where('showName', isEqualTo: show)
        .getDocuments();
    setState(() {
      if (queryName.documents.length == 1) {
        showExists = true;
        documentId = queryName.documents[0].documentID;
      } else {
        showExists = false;
      }
    });
  }

  //Check reminder if exist or not
  checkIfReminderExists(String name) async {
    QuerySnapshot query = await ReminderAPI.reference
        .where('name', isEqualTo: name)
        .getDocuments();
    setState(() {
      if (query.documents.length == 1) {
        reminderId = query.documents[0].documentID;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    showId = widget.id;
    getData(showId);
    checkExists(name);
    checkIfReminderExists(name);
  }

  @override
  Widget build(BuildContext context) {
    checkExists(name);
    checkIfReminderExists(name);
    return Scaffold(
      //Start body
        body: PageTheme().pageTheme('$name', context,true,
        ListView(
            children: [
            Stack(
               children: [
                Container(
                 height: MediaQuery.of(context).size.height - 82.0,
                 width: MediaQuery.of(context).size.width,
                 color: Colors.transparent),
                Positioned(
                  top: 5.0,
                  left: (MediaQuery.of(context).size.width / 2) - 60.0,
                  child: Container(
                    //Show image
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: image != null ?
                        NetworkImage(image)
                            :AssetImage("assets/tv.jpg"),
                      ),
                          height: 130.0,
                          width: 130.0)

                ),
                SizedBox(width: 10.0,),
                Positioned(
                 top: 130.0,
                 left: 25.0,
                 right: 25.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Align(
                          heightFactor: 2,
                          alignment: Alignment.center,
                         child:SmoothStarRating(
                          rating: rating,
                          allowHalfRating: false,
                          filledIconData: Icons.star,
                          halfFilledIconData: Icons.star_half,
                          color: Colors.amber,
                          size: 30,
                          borderColor: Colors.amber,
                        ),
                        ),
                        SizedBox(height: 20,),
                        Text("Name: $name \n",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold
                            )
                        ),
                        // Show Date
                        Text("Start date: $date \n",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold
                            )
                        ),
                        // Show time
                        Text("Start time: $time \n",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold
                            )
                        ),
                        // Show Country
                        Text("Country: $country \n",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold
                            )
                        ),
                        // Show Network
                        Text("Network: $network \n",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold
                            )
                        ),

                      ]

                  )
              ),

                //Add show into watchlist
                Positioned(
                    top: 450.0,
                    left: 80.0,
                    right: 80.0,
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: showExists
                            ? () {
                                return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ConfirmationDialog(
                                        reminderDocumentId: reminderId,
                                        watchlistDocumentId: documentId,
                                        pageName: 'Show Details',
                                        action: 'delete',
                                        text:
                                            "Are you sure you want to remove this show from the list?\n\nReminder for this show will be deleted",
                                      );
                                    });
                              }
                            : () {
                                return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ConfirmationDialog(
                                        watchList: watchList,
                                        pageName: 'Show Details',
                                        action: 'add',
                                        text:
                                            'Do you want to add this show to your watch list?',
                                      );
                                    });
                              },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF00ACC1), Color(0xFF80DEEA)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 400.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: showExists
                                ? Text(
                                    "Added to watchlist",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  )
                                : Text(
                                    "Add to Watchlist",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ),
                        ),
                      ),
                    )
                )
              ])
           ] )//End body
            )
    );
  }
}
// Start _ShowDetailsPageState
