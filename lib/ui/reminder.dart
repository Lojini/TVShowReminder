/* This page shows the reminder list and
   each item in the list can be dragged to left for more options.
   References:
      https://codelabs.developers.google.com/codelabs/flutter-firebase/#8
      https://pub.dev/packages/flutter_slidable
 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tv_reminder/models/reminder.dart';
import 'package:tv_reminder/services/reminderApi.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tv_reminder/ui/confirmationDialog.dart';
import '../main.dart';
import 'customReminderDialog.dart';

class ReminderPage extends StatefulWidget {
  @override
  _ReminderState createState() => _ReminderState();
}

class _ReminderState extends State<ReminderPage> {
  Widget buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: ReminderAPI.reminderStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null)
            return CircularProgressIndicator();
          else if (snapshot.data.documents.length == 0)
            //if list has reminders to show,
            return emptyPage();
          else
            return buildList(context, snapshot.data.documents);
        });
  }

  Widget buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      primary: false,
      padding: EdgeInsets.only(top: 40, left: 25.0, right: 20.0),
      children: snapshot.map((data) => buildListItem(context, data)).toList(),
    );
  }

  //build each item in the list
  Widget buildListItem(BuildContext context, DocumentSnapshot data) {
    final reminder = Reminder.fromSnapshot(data);
    return Column(
      children:[
      new Slidable(
      delegate: new SlidableDrawerDelegate(),
      actionExtentRatio: 0.20,
      secondaryActions: <Widget>[
        new IconSlideAction(
          caption: 'Edit',
          color: Colors.grey[100],
          icon: Icons.edit,
          onTap: () {
            //open custom dialog to update reminder
            showDialog(
              context: context,
              builder: (context) => CustomReminderDialog(
                  documentId: data.documentID,
                  reminder: Reminder(
                      showName: reminder.showName,
                      imageUrl: reminder.imageUrl,
                      showDateTime: reminder.showDateTime,
                      reminderStart: reminder.reminderStart)),
            );
          },
        ),
        new IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            //shows the alert dialog before deleting reminder
            showDialog(
                context: context,
                builder: (context) {
                  return ConfirmationDialog(
                      action: 'delete',
                      pageName: 'Reminder',
                      text: 'Are you sure you want to remove this reminder?',
                      reminderDocumentId: data.documentID,
                      watchlistDocumentId: reminder.watchlistId);
                });
          },
        ),
      ],
      child: Container(
        padding: EdgeInsets.only(left: 20,top: 8),
        child: Column(
            children: <Widget>[
              Container(
                child: Row(children: <Widget>[
                  Hero(
                    tag: reminder.imageUrl,
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(reminder.imageUrl),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            reminder.showName,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.notifications_none,
                                color: Colors.grey,
                                size: 20,
                              ),
                              Text(
                                   //convert the date format to Month,date year and time format to 12 hours clock
                                   //displays the time that reminder notification set
                                  '${DateFormat.yMMMMd("en_US").add_jm().format(reminder.showDateTime.toDate().subtract(Duration(minutes: int.parse(reminder.reminderStart.split(" ")[0]))))}',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 11.0,
                                      color: Colors.grey)),
                            ],
                          ),
                          SizedBox(height: 8,)
                        ]),
                  ),
                ]),
              ),
            ]),
      ),
    ),
        Divider(color: Colors.grey[300],thickness: 1.0,),
    ]
    );
  }

  //to display when the reminder list is empty
  Widget emptyPage() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/sad_Tv.png',
            height: 100,
            width: 150,
          ),
          Text(
            'You have no reminder!!',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFFd2d9d9),
                fontFamily: 'Montserrat'),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Add your reminder \n  from watchlist ',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFFd2d9d9),
                fontFamily: 'Montserrat'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageTheme()
            .pageTheme('Reminder', context, null, buildBody(context)));

  }
}
