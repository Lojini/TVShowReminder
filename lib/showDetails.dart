import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'tvshowlist.dart';
import 'main.dart';

class ShowDetailsPage extends StatefulWidget {

  final int userData;
  ShowDetailsPage(this.userData);

  @override
  _ShowDetailsPageState createState() => _ShowDetailsPageState();
}

class _ShowDetailsPageState extends State<ShowDetailsPage> {
  List data;
  List detailsData;
  int userData;

  Future getData() async {
    http.Response response = await http.get("https://www.episodate.com/api/most-popular?page=1/show-details?q=$userData");
    data = json.decode(response.body);
    setState(() {
      detailsData = data;
    });
    debugPrint(detailsData.toString());
  }

  void initState() {
    super.initState();
    userData = widget.userData;
    getData();
  }

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
                                  //image: NetworkImage(userData[index]["image_thumbnail_path"]),
                                  fit: BoxFit.cover)),
                          height: 200.0,
                          width: 200.0),

              ),
              SizedBox(width: 10.0),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Text("Name: ",
                        //"${userData[index]["name"]}",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 9.0,
                            fontWeight: FontWeight.bold
                        )
                    ),
                    Text("Permalink: ",
                        //"${userData[index]["network"]}",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12.0,
                            color: Colors.grey
                        )
                    ),
                    Text("Start date: ",
                        //"${userData[index]["name"]}",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 9.0,
                            fontWeight: FontWeight.bold
                        )
                    ),
                    Text("End date: ",
                        //"${userData[index]["network"]}",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12.0,
                            color: Colors.grey
                        )
                    ),
                    Text("Country: ",
                        //"${userData[index]["name"]}",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 9.0,
                            fontWeight: FontWeight.bold
                        )
                    ),
                    Text("Network: ",
                        //"${userData[index]["network"]}",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12.0,
                            color: Colors.grey
                        )
                    ),
                    Text("Status: ",
                        //"${userData[index]["network"]}",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12.0,
                            color: Colors.grey
                        )
                    ),
                  ]
              ),
              Container(
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
                      constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Track Show",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              ])
        ]))
    );
  }
}