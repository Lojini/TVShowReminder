import 'package:cloud_firestore/cloud_firestore.dart';

class WatchList{
  int showId;//show id
  String showName;//name of the show
  String imageUrl;//url for thumbnail of the show
  bool reminder;//whether show has a reminder or not
  DateTime showDateTime;//time and date of show telecast
  DocumentReference reference;//reference to Firestore document representing watchlist

  //constructor
  WatchList({this.showId,this.showName,this.imageUrl,this.showDateTime,this.reminder});

  //Map fetched data from JSON format to watchlist format
  WatchList.fromMap(Map<String,dynamic> map,{this.reference}):
        assert(map['showName']!=null),
        assert(map['showId']!=null),
        showId= map['showId'],
        showName=map['showName'],
        showDateTime=map['showDateTime'],
        imageUrl=map['imageUrl'],
        reminder=map['reminder'];

  //Map Watchlist to Firestore DocumentSnapshot
  WatchList.fromSnapshot(DocumentSnapshot snapshot)
      :this.fromMap(snapshot.data,reference:snapshot.reference);

  //convert back to JSON
  toJson(){
    return {'showId':showId,
            'showName':showName,
            'showDateTime':showDateTime,
            'imageUrl':imageUrl,
            'reminder':reminder
    };
  }

}