import 'package:flutter/material.dart';
import '../main.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'showDetails.dart';

// Start TvShowList
class TvShowList extends StatefulWidget {
  @override
  _TvShowListState createState() => _TvShowListState();
}
// End TvShowList

// Start _TvShowListState
class _TvShowListState extends State<TvShowList> {
  TextEditingController controller = new TextEditingController();
  List<Shows> _searchResult = [];
  List<Shows> _showDetails = [];

  Future getData() async {
    // Fetch the TV shows data from API
    http.Response response = await http.get("http://api.tvmaze.com/schedule?date=2020-04-30");
    final data = json.decode(response.body);
    setState(() {
      for (Map show in data) {
        _showDetails.add(Shows.fromJson(show));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //get Show data
    getData();
    print('count ${_showDetails.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageTheme().pageTheme('TV Shows', context,false,
            new Padding(
              padding: EdgeInsets.only(left: 5.0, right: 10.0, top: 10, bottom: 10),
              child: Column(
                  children: <Widget>[
                    new Container(
                      // Search bar
                      child: new Padding(
                        padding: EdgeInsets.only(left: 15.0, right: 5.0, top: 10),
                        child: new Card(
                          color: Colors.grey[100],
                          child: new ListTile(
                            leading: new Icon(Icons.search),
                            title: new TextField(
                              controller: controller,
                              decoration: new InputDecoration(
                                  hintText: 'Search', border: InputBorder.none),
                              // call onSearchTextChanged() function
                              onChanged: onSearchTextChanged,
                            ),
                            trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                              controller.clear();
                              onSearchTextChanged('');
                            },),
                          ),
                        ),
                      ),
                    ),
                    // Search shows details displaying
                    new Expanded(
                        child: _searchResult.length != 0 || controller.text.isNotEmpty
                            ? listView(_searchResult):listView(_showDetails)
                    )
                  ]
              ),
            )
        )
    );
  }

  // Start tvShowlist content
  Widget listView(List<Shows> list){
    return new ListView.separated(
        separatorBuilder: (context, builder) => Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
        padding: EdgeInsets.only(top: 30.0, left: 30.0, bottom: 20),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.only(left: 2.0, right: 4.0, top: 5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                                radius: 30,
                                // Show image
                                backgroundImage: NetworkImage(list[index].image)
                            ),
                            SizedBox(width: 7.0),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  // Show Name
                                  Text(
                                      "${list[index].showName}",
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold
                                      )
                                  ),
                                  // Show Network
                                  Text(
                                      "${list[index].networkName}",
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 10,
                                          color: Colors.grey
                                      )
                                  )
                                ]
                            ),
                          ],
                        ),
                      ),
                    ),

                    IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 20,
                        ),
                        color: Colors.black,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              //Show id pass to showDetails page
                              builder: (context) => ShowDetailsPage(
                                  id: list[index].id,
                                  airStamp: DateTime.parse(list[index].airstamp)
                                      .toLocal())));
                        }),
                  ]));
        });
  }
  // End TV Showlist content

  // Search function
  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _showDetails.forEach((show) {
      if (show.networkName.contains(text)) _searchResult.add(show);
    });
    setState(() {});
  }
}
// End _TvShowListState

// Start Show class
class Shows {
  final String showName, airstamp, image, networkName;
  final int id;

  Shows({this.id, this.showName, this.image, this.airstamp, this.networkName});


  factory Shows.fromJson(Map<String, dynamic> json) {
    //set API's data into variables
    return new Shows(
        id: json['show']['id'],
        networkName: json['show']['network'] == null
            ? 'AWS'
            : json['show']['network']['name'],
        showName: json['show']['name'],
        image:json['show']['image']==null?'assets/tv.jpg':json['show']['image']['original'],
        airstamp:json['airstamp']
    );
  }
}
// End Show class

