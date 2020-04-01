import 'package:cloud_firestore/cloud_firestore.dart';

class WatchList{
  int showId;
  String showName;
  String imageUrl;
  DocumentReference reference;

  WatchList({this.showId,this.showName,this.imageUrl});

  WatchList.fromMap(Map<String,dynamic> map,{this.reference}):
        assert(map['showName']!=null),
        assert(map['showId']!=null),
        showId= map['showId'],
        showName=map['showName'],
        imageUrl=map['imageUrl'];

  WatchList.fromSnapshot(DocumentSnapshot snapshot)
      :this.fromMap(snapshot.data,reference:snapshot.reference);

  toJson(){
    return {'showId':showId,
            'showName':showName,
            'imageUrl':imageUrl
    };
  }

}