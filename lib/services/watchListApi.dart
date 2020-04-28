import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tv_reminder/models/watchList.dart';

class WatchListAPI{
  static Stream<QuerySnapshot> watchlistStream = Firestore.instance.collection('watchlist').snapshots();
  static CollectionReference reference = Firestore.instance.collection('watchlist');

  static addToWatchlist(WatchList watchList){
    Firestore.instance.runTransaction((Transaction transaction) async{
      await reference.add({
        "showId":watchList.showId,
         "showName":watchList.showName,
        "imageUrl":watchList.imageUrl,
        "dateTime":watchList.showDateTime,
        "reminder":watchList.reminder
      });
    });
  }

  static updateWatchlist(String id,bool reminder){
    Firestore.instance.runTransaction((Transaction transaction) async{
      await reference.document(id).updateData({
        "reminder":reminder,
      }).catchError((error){
        print(error);
      });
    });
  }
  
  static deleteWatchlist(String id){
    Firestore.instance.runTransaction((Transaction transaction) async{
      await reference.document(id).delete().catchError((error){
        print(error);
      });
    });
  }

}