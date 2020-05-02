import 'package:cloud_firestore/cloud_firestore.dart';

class Reminder{
  String showName;//name of the show
  String imageUrl;//url for thumbnail of show
  String watchlistId;//document id of the show belongs to the reminder
  Timestamp showDateTime;//time and date of show telecast
  String reminderStart;//reminder to alert given minutes before show time
  DocumentReference reference;//reference to Firestore document representing reminder

  //constructor
  Reminder({this.showName,this.imageUrl,this.watchlistId,this.showDateTime,this.reminderStart});

  //Map fetched data from JSON format to reminder format
  Reminder.fromMap(Map<String,dynamic> map,{this.reference}):
      assert(map['name']!=null),
      assert(map['showDateTime']!=null),
      assert(map['start']!=null),
      showName = map['name'],
      watchlistId=map['watchlistId'],
      imageUrl = map['url'],
      showDateTime = map['showDateTime'],
      reminderStart = map['start'];

  //Map reminder to Firestore DocumentSnapshot
  Reminder.fromSnapshot(DocumentSnapshot snapshot)
        :this.fromMap(snapshot.data,reference:snapshot.reference);

  //convert back to JSON
  toJson(){
    return {
      'name':showName,
      'watchlistId':watchlistId,
      'url' :imageUrl,
      'showDateTime':showDateTime,
      'start':reminderStart};

  }

}