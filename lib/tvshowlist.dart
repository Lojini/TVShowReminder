import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'main.dart';
import 'showDetails.dart';

class TvShowList extends StatefulWidget{

  @override
  _TvShowListState createState()=> _TvShowListState();
}

class _TvShowListState extends State<TvShowList>{
  Map data;
  List userData;

  Future getData() async {
    http.Response response = await http.get("https://www.episodate.com/api/most-popular?page=1");
    data = json.decode(response.body);
    setState(() {
      userData = data["tv_shows"];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: PageTheme().pageTheme('TV Shows', context,
          ListView.builder(

              padding: EdgeInsets.only(top: 30.0, left: 10.0, bottom: 20),
              itemCount: userData == null ? 0 : userData.length,
              itemBuilder: (BuildContext context, int index){
                return Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 10.0, top: 20.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              child: Row(

                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(userData[index]["image_thumbnail_path"]),
                                    ),

                                    SizedBox(width: 10.0),
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:[
                                          Text(
                                              "${userData[index]["name"]}",
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 9.0,
                                                  fontWeight: FontWeight.bold
                                              )
                                          ),
                                          Text(
                                              "${userData[index]["network"]}",
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 12.0,
                                                  color: Colors.grey
                                              )
                                          )
                                        ]
                                    )
                                  ]
                              )),
                          IconButton(
                              icon: Icon(Icons.arrow_forward),
                              color: Colors.black,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ShowDetailsPage(userData[index])
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

