import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
   String name, image, date, time, day, country, network, timeZone, rating;


  Future getData(int userData) async {
    http.Response response = await http.get("http://api.tvmaze.com/shows/$userData");
    //debugPrint(response.body);
     setState(() {
       data = json.decode(response.body);
       name=data['name'];
       debugPrint(name);
       image=data["image"]["original"];
       date=data['premiered'];
       time=data['schedule']['time'];
       day=data['schedule']['days'];
       country=data['network']['country']['name'];
       network=data['network']['name'];
       timeZone=data['network']['country']['timezone'];
       rating=data['rating']['average'];
    });

     debugPrint(data.toString());
  }
  @override
  void initState() {
    super.initState();
    userData=widget.id;
    this.getData(userData);
  }

  @override
  Widget build(BuildContext context) {
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
                  child: Container(
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
                        Text("Start date: $date \n",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold
                            )
                        ),
                        Text("Start time: $time \n",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold
                            )
                        ),
                        Text("Show day: $day \n",
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
                        Text("Time Zone: $timeZone \n",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold
                            )
                        ),
                        Text("Rating: $rating \n",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold
                            )
                        )
                      ]

                  )
              ),
              Positioned(
                top: 480.0,
                left: 80.0,
                right: 80.0,
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {},
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
                          child: Text(
                            "Add Watchlist",
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
}