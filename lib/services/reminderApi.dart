import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tv_reminder/models/reminder.dart';

class ReminderAPI{
    static Stream<QuerySnapshot> reminderStream = Firestore.instance.collection('reminder').snapshots();

    static CollectionReference reference = Firestore.instance.collection('reminder');

    static addReminder(Reminder reminder){
      Firestore.instance.runTransaction((Transaction transaction) async{
        await reference.add({
          "name":reminder.showName,
          "url" :reminder.imageUrl,
          "date":reminder.showDate,
          "time":reminder.showTime,
          "start":reminder.reminderStart
        });
      });
    }

    static deleteReminder(String id){
      Firestore.instance.runTransaction((Transaction transaction) async{
        await reference.document(id).delete().catchError((error){
          print(error);
        });
      });
    }

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