import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:tv_reminder/models/reminder.dart';
import 'package:tv_reminder/services/watchListApi.dart';
import 'package:tv_reminder/ui/showDetails.dart';
import '../main.dart';
import 'customReminderDialog.dart';


class WatchListPage extends StatefulWidget {
  @override
  _WatchListPageState createState() => _WatchListPageState();
}

class _WatchListPageState extends State<WatchListPage> {
  bool isButtonDisabled = false;
  Map data;
  String date,time,timeZone;
  DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageTheme().pageTheme('Watch List', context,null,
          StreamBuilder(
            stream: WatchListAPI.watchlistStream,
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if (!snapshot.hasData || snapshot.data==null)
                  return CircularProgressIndicator();
              else if(snapshot.data.documents.length == 0){
                  return emptyPage();}
               else {
                return Swiper(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    var list= snapshot.data.documents[index];
                         return new Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 50, bottom: 60),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image:NetworkImage(list['imageUrl'])
                              ),
                            ),
                            child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ShowDetailsPage(id: list['showId'])
                                  ));
                                }
                            ),
                          ),
                          Positioned(
                              right: 7.0,
                              top: 60,
                                 child:list['reminder']==null||list['reminder']==false?GestureDetector(
                                   onTap: (){
                                     showDialog(
                                       context: context,
                                       builder: (context) =>
                                           CustomReminderDialog(
                                               documentId:list.documentID,
                                               reminder: Reminder(
                                                   showName: list['showName'],
                                                   showDateTime:list['dateTime'],
                                                   imageUrl: list['imageUrl'])
                                           ),
                                     );
                                   },
                                   child: Align(
                                     alignment: Alignment.topRight,
                                     child: CircleAvatar(
                                       backgroundColor: Colors.cyan[600],
                                       child: Icon(Icons.notifications_none,
                                         color: Colors.white,),),

                                   ),
                    ):Align(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                              backgroundColor: Colors.cyan[600],
                              child: Icon(Icons.notifications_active,
                                color: Colors.white,),),

                          )
                          )
                        ]
                    );
                  },
                  viewportFraction: 0.7,
                  control: SwiperControl(color: Colors.white),
                  scale: 0.8,
                );
              }
             },
        )
        )
    );
  }

  Widget emptyPage(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/sad_Tv.png',
            height: 100,
            width: 150,),
          Text('You have no shows!!',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFFd2d9d9),
                fontFamily: 'Montserrat'
            )
          ),
          SizedBox(height: 10,),
          Text('Add to watchlist \n from tv shows',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFFd2d9d9),
                fontFamily: 'Montserrat'
            ),
          ),
        ],
      ),
    );
  }
}