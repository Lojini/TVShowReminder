import 'package:cloud_firestore/cloud_firestore.dart';

class WatchListAPI{
  static Stream<QuerySnapshot> reminderStream = Firestore.instance.collection('reminder').snapshots();
  static CollectionReference reference = Firestore.instance.collection('reminder');

  addReminder(int id){
    Firestore.instance.runTransaction((Transaction transaction) async{
      await reference.add({
        "showId":id,
      });
    });
  }

  deleteReminder(String id){
    Firestore.instance.runTransaction((Transaction transaction) async{
      await reference.document(id).delete().catchError((error){
        print(error);
      });
    });
  }
}