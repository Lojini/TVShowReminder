import 'package:cloud_firestore/cloud_firestore.dart';

class WatchList{
  String showId;
  DocumentReference reference;

  WatchList({this.showId});

  WatchList.fromMap(Map<String,dynamic> map,{this.reference}):
        assert(map['showName']!=null),
        showId= map['showId'];

  WatchList.fromSnapshot(DocumentSnapshot snapshot)
      :this.fromMap(snapshot.data,reference:snapshot.reference);

  toJson(){
    return {'showId':showId};
  }

}