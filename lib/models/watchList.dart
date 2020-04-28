import 'package:cloud_firestore/cloud_firestore.dart';

class WatchList{
  int showId;
  String showName;
  String imageUrl;
  bool reminder;
  DateTime showDateTime;
  DocumentReference reference;

  WatchList({this.showId,this.showName,this.imageUrl,this.showDateTime,this.reminder});

  WatchList.fromMap(Map<String,dynamic> map,{this.reference}):
        assert(map['showName']!=null),
        assert(map['showId']!=null),
        showId= map['showId'],
        showName=map['showName'],
        showDateTime=map['showDateTime'],
        imageUrl=map['imageUrl'],
        reminder=map['reminder'];

  WatchList.fromSnapshot(DocumentSnapshot snapshot)
      :this.fromMap(snapshot.data,reference:snapshot.reference);

  toJson(){
    return {'showId':showId,
            'showName':showName,
            'showDateTime':showDateTime,
            'imageUrl':imageUrl,
            'reminder':reminder
    };
  }

}