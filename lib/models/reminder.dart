import 'package:cloud_firestore/cloud_firestore.dart';

class Reminder{
  String showName;
  String imageUrl;
  String watchlistId;
  Timestamp showDateTime;
  String reminderStart;
  DocumentReference reference;

  Reminder({this.showName,this.imageUrl,this.watchlistId,this.showDateTime,this.reminderStart});

  Reminder.fromMap(Map<String,dynamic> map,{this.reference}):
      assert(map['name']!=null),
      assert(map['showDateTime']!=null),
      assert(map['start']!=null),
      showName = map['name'],
      watchlistId=map['watchlistId'],
      imageUrl = map['url'],
      showDateTime = map['showDateTime'],
      reminderStart = map['start'];


  Reminder.fromSnapshot(DocumentSnapshot snapshot)
        :this.fromMap(snapshot.data,reference:snapshot.reference);

  toJson(){
    return {
      'name':showName,
      'watchlistId':watchlistId,
      'url' :imageUrl,
      'showDateTime':showDateTime,
      'start':reminderStart};

  }

}