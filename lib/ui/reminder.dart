import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tv_reminder/models/reminder.dart';
import 'package:tv_reminder/services/reminderApi.dart';
import 'package:tv_reminder/ui/customReminderDialog.dart';
import '../main.dart';

class ReminderPage extends StatefulWidget{
  @override
  _ReminderState createState()=> _ReminderState();
}

class _ReminderState extends State<ReminderPage>{
  Widget buildBody(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
        stream: ReminderAPI.reminderStream,
        builder: (context,snapshot) {
          if (!snapshot.hasData || snapshot.data==null)
            return CircularProgressIndicator();
          else if(snapshot.data.documents.length == 0)
            return emptyPage();
          else
            return buildList(context, snapshot.data.documents);
        }
    );
  }

  Widget buildList(BuildContext context,List<DocumentSnapshot> snapshot){
    return ListView(
      children:snapshot.map((data) => buildListItem(context,data)).toList(),
    );
  }

  Widget buildListItem(BuildContext context,DocumentSnapshot data){
    final reminder = Reminder.fromSnapshot(data);
    return Padding(
      key: ValueKey(data.documentID),
      padding: EdgeInsets.only(left:0.0),
      child: InkWell(
        onTap: () {
           showDialog(
             context: context,
             builder: (context)=> CustomReminderDialog(
                                documentId:data.documentID,
                                reminder:Reminder(
                                 showName: reminder.showName,
                                 imageUrl: reminder.imageUrl,
                                 showDate: reminder.showDate,
                                 showTime: reminder.showTime,
                                 reminderStart: reminder.reminderStart)
           ),
           );
        },
          child:Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Hero(
                      tag: reminder.imageUrl,
                      child: CircleAvatar(
                        radius:40.0 ,
                        backgroundImage: NetworkImage(reminder.imageUrl),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          reminder.showName,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize:18.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'On ${reminder.showDate} at ${reminder.showTime}',
                              style:TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 15.0,
                                color: Colors.grey
                              )
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Icon(Icons.notifications_none,color: Colors.grey,),
                            Text('Remind before ${reminder.reminderStart}',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 15.0,
                                color: Colors.grey
                            ),)
                          ],
                        )
                      ],
                    ),
                    IconButton(
                     icon:Icon(Icons.delete_outline,size: 35,color: Colors.grey,),
                      onPressed: (){
                          _confirmDialog(context,data.documentID);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Divider(color: Colors.grey, thickness: 0.5,),
            ],
          )
    )
    );
  }

  Future _confirmDialog(BuildContext context,String documentID){
    return showDialog(
        context:context,
        builder: (context) {
           return AlertDialog(
             title: Text('Confirm delete'),
             content:Text('Are you sure you want to delete this reminder?'),
             actions: <Widget>[
               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:<Widget>[
                  RaisedButton(
                     color: Colors.cyan[600],
                    child:Text('Yes,Delete it!'),
                    onPressed: (){
                     ReminderAPI.deleteReminder(documentID);
                     Navigator.pop(context);
                 },
               ),
                  SizedBox(width: 10,),
                  RaisedButton(
                    color: Colors.red,
                     child: Text('Cancel'),
                     onPressed: (){
                      Navigator.pop(context);
                     },
                  )
                ]
               )
             ],
           );
        });
  }

  Widget emptyPage(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/sad_Tv.png',
          height: 100,
          width: 100,),
          Text('You have no reminder!!',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.grey,
                fontFamily: 'Montserrat'
            ),
          ),
          Text('Add your reminder from watchlist ',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.grey,
                fontFamily: 'Montserrat'
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageTheme().pageTheme('Reminder', context,
            ListView(
              primary: false,
               padding: EdgeInsets.only(left: 25.0,right: 20.0),
               children: <Widget>[
                 Padding(
                   padding: EdgeInsets.only(top: 35.0),
                   child: Container(
                     height: MediaQuery.of(context).size.height-300.0,
                     child: buildBody(context)
                   ),
                 )
               ],
            ))
    );
  }
}