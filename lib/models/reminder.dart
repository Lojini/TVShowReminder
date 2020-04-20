import 'package:cloud_firestore/cloud_firestore.dart';

class Reminder{
  String showName;
  String imageUrl;
  DateTime showDateTime;
  String reminderStart;
  DocumentReference reference;

  Reminder({this.showName,this.imageUrl,this.showDateTime,this.reminderStart});

  Reminder.fromMap(Map<String,dynamic> map,{this.reference}):
      assert(map['name']!=null),
      assert(map['date']!=null),
      assert(map['time']!=null),
      assert(map['start']!=null),
      showName = map['name'],
      imageUrl = map['url'],
      showDateTime = map['showDateTime'],
      reminderStart = map['start'];


  Reminder.fromSnapshot(DocumentSnapshot snapshot)
        :this.fromMap(snapshot.data,reference:snapshot.reference);

  toJson(){
    return {
      'name':showName,
      'url' :imageUrl,
      'showDateTime':showDateTime,
      'start':reminderStart};

  }

}