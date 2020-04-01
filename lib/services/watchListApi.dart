import 'package:cloud_firestore/cloud_firestore.dart';

class WatchListAPI{
  static Stream<QuerySnapshot> watchlistStream = Firestore.instance.collection('watchlist').snapshots();
  static CollectionReference reference = Firestore.instance.collection('watchlist');

  static addToWatchlist(int id,String showName,String url,String reminder){
    Firestore.instance.runTransaction((Transaction transaction) async{
      await reference.add({
        "showId":id,
         "showName":showName,
        "imageUrl":url,
        "reminder":reminder
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