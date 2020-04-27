import 'package:flutter/material.dart';
import '../main.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'showDetails.dart';

// Start TvShowList
class TvShowList extends StatefulWidget{
  @override
  _TvShowListState createState()=> _TvShowListState();
}
// End TvShowList

// Start _TvShowListState
class _TvShowListState extends State<TvShowList>{
  List data;
  List userData;

  Future getData() async {
    // API Connection
    http.Response response = await http.get("http://api.tvmaze.com/schedule?date=2020-04-30");
    //debugPrint(response.body);
    data = json.decode(response.body);
    setState(() {
      userData = data;
    });

  }

  @override
  void initState() {
    super.initState();
    //get Show data
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTheme().pageTheme('TV Shows', context,
          ListView.separated(
            separatorBuilder:(context,builder) =>Divider(
              color: Colors.grey,
              thickness: 0.5,
          ),
              padding: EdgeInsets.only(top: 30.0, left: 10.0, bottom: 20),
              itemCount: userData == null ? 0 : userData.length,
              itemBuilder: (BuildContext context, int index){
                return Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 10.0, top: 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              child: Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 30,
                                    // Show image
                                    backgroundImage: userData[index]["show"]["image"] != null ?
                                    NetworkImage(userData[index]["show"]["image"]["original"])
                                        :AssetImage("assets/tv.jpg"),
                                    ),

                                    SizedBox(width: 7.0),
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:[
                                          // Show Name
                                          Text(
                                              "${userData[index]["show"]["name"]}",
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.bold
                                              )
                                          ),
                                          userData[index]["show"]["network"] != null ?
                                          // Show Network
                                          Text(
                                              "${userData[index]["show"]["network"]["name"]}",
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 11.0,
                                                  color: Colors.grey
                                              )
                                          ):Text(
                                              "AWS",
                                              style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 12.0,
                                              color: Colors.grey
                                            )
                                          ),
                                        ]
                                    )
                                  ]
                              )),
                          IconButton(
                              icon: Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 20,),
                              color: Colors.black,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  //Show id pass to showDetails page
                                    builder: (context) => ShowDetailsPage(id:userData[index]["show"]["id"])
                                    builder: (context) => ShowDetailsPage(id:userData[index]["show"]["id"],airStamp:userData[index]["air_stamp"])
                                ));
                              }
                          ),
                        ]
                    )
                );
              }
          ) ),

    );
  }
}
// End _TvShowListState

