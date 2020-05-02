import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tv_reminder/models/reminder.dart';

class ReminderAPI{
    //fetch data as stream
    static Stream<QuerySnapshot> reminderStream = Firestore.instance.collection('reminder').snapshots();
    //reference to collections of reminder
    static CollectionReference reference = Firestore.instance.collection('reminder');

    //add reminder
    static addReminder(Reminder reminder){
      Firestore.instance.runTransaction((Transaction transaction) async{
        await reference.add({
          "name":reminder.showName,
          "watchlistId":reminder.watchlistId,
          "url" :reminder.imageUrl,
          "showDateTime":reminder.showDateTime,
          "start":reminder.reminderStart
        });
      });
    }
    //delete a reminder
    static deleteReminder(String id){
      Firestore.instance.runTransaction((Transaction transaction) async{
        await reference.document(id).delete().catchError((error){
          print(error);
        });
      });
    }

    //update the reminder time in reminder
    static updateReminder(String id,String time){
      Firestore.instance.runTransaction((Transaction transaction) async{
        await reference.document(id).updateData({
          "start":time,
        }).catchError((error){
          print(error);
        });
      });
    }
}