/*  This page displays the Favourite tv shows fetched from watchlist document in firestore.
    Swiper is used to display the shows. Button placed at the right corner of a tv show card
    opens a popup menu button to handle navigation to details page,reminder and deletion of a show from watchlist
    Reference :
        https://pub.dev/packages/flutter_swiper
        https://codelabs.developers.google.com/codelabs/flutter-firebase/#8
        for popup menu: https://flutteropen.gitbook.io/flutter-widgets/flutter-widgets-14-flutter-popup-menu-button
 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:tv_reminder/models/reminder.dart';
import 'package:tv_reminder/services/reminderApi.dart';
import 'package:tv_reminder/services/watchListApi.dart';
import 'package:tv_reminder/ui/showDetails.dart';
import '../main.dart';
import 'confirmationDialog.dart';
import 'customReminderDialog.dart';

class WatchListPage extends StatefulWidget {
  @override
  _WatchListPageState createState() => _WatchListPageState();
}

//enumeration with the list of options to be in popup menu
enum MoreOptions { info, remove, addReminder, updateReminder }

class _WatchListPageState extends State<WatchListPage> {
  Map data;
  String date, time, timeZone, reminderId, showName, imageUrl, reminderStart;
  Timestamp showDateTime;

  //check if a reminder exists for given show name
  checkIfReminderExists(String name) async {
    QuerySnapshot query = await ReminderAPI.reference
        .where('name', isEqualTo: name)
        .getDocuments();
    setState(() {
      if (query.documents.length == 1) {
        reminderId = query.documents[0].documentID;
        showName = query.documents[0]['name'];
        imageUrl = query.documents[0]['url'];
        showDateTime = query.documents[0]['showDateTime'];
        reminderStart = query.documents[0]['start'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageTheme().pageTheme(
            'Watch List',
            context,
            null,
            StreamBuilder(
              stream: WatchListAPI.watchlistStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData || snapshot.data == null)
                  return CircularProgressIndicator();
                else if (snapshot.data.documents.length == 0) {
                  return emptyPage();
                } else {
                  return Swiper(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      var list = snapshot.data.documents[index];
                      return new Stack(children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 70, bottom: 70),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.cyan[600],
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(list['imageUrl'])),
                          ),
                        ),
                        Positioned(
                            right: 7.0, top: 80, child: popUpMenu(true, list))
                      ]);
                    },
                    viewportFraction: 0.7,
                    control: SwiperControl(color: Colors.white),
                    scale: 0.8,
                  );
                }
              },
            )));
  }
  //pop up menu with options
  Widget popUpMenu(bool isExists, var list) {
    checkIfReminderExists(list['showName']);
    return new PopupMenuButton<MoreOptions>(
      child: Container(
        decoration: ShapeDecoration(
          color: Color(0xFF00ACC1),
          shape: StadiumBorder(
            side: BorderSide(color: Color(0xFF00ACC1), width: 7),
          ),
        ),
        child: Icon(
          Icons.more_horiz,
          color: Colors.white,
        ),
      ),
      padding: EdgeInsets.zero,
      onSelected: (value) {
        switch (value) {
          case MoreOptions.info:
            //navigate to Show's detail page
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShowDetailsPage(
                      id: list['showId'],
                      airStamp: list['dateTime'].toDate(),
                    )));
            break;
          case MoreOptions.addReminder:
            //open the dialog to set reminder
            showDialog(
              context: context,
              builder: (context) => CustomReminderDialog(
                  documentId: list.documentID,
                  reminder: Reminder(
                      showName: list['showName'],
                      showDateTime: list['dateTime'],
                      imageUrl: list['imageUrl'])),
            );
            break;
          case MoreOptions.updateReminder:
            //open the dialog to update reminder
            showDialog(
              context: context,
              builder: (context) => CustomReminderDialog(
                  documentId: reminderId,
                  reminder: Reminder(
                      showName: showName,
                      imageUrl: imageUrl,
                      showDateTime: showDateTime,
                      reminderStart: reminderStart)),
            );
            break;
          case MoreOptions.remove:
            //opens the alert dialog to delete a show from watchlist
            showDialog(
                context: context,
                builder: (context) {
                  return ConfirmationDialog(
                    reminderDocumentId: reminderId,
                    watchlistDocumentId: list.documentID,
                    pageName: 'Show Details',
                    action: 'delete',
                    text:
                        "Are you sure you want to remove this show from the list?\n\nReminder for this show will be deleted",
                  );
                });
        }
      },
      itemBuilder: (context) => <PopupMenuEntry<MoreOptions>>[
        const PopupMenuItem<MoreOptions>(
            value: MoreOptions.info,
            child: ListTile(
                leading: Icon(
                  Icons.info_outline,
                  size: 30,
                ),
                title: Text(
                  'Info',
                  style: TextStyle(fontSize: 12),
                ),
                contentPadding: EdgeInsets.zero)),
        //if the show doesn't have a reminder,then the option in popmenu shows "add reminder"
        //else shows "edit reminder"
        list['reminder'] == true
            ? const PopupMenuItem<MoreOptions>(
                value: MoreOptions.updateReminder,
                child: ListTile(
                    leading: Icon(
                      Icons.edit,
                      size: 30,
                    ),
                    title:
                        Text('Edit Reminder', style: TextStyle(fontSize: 12)),
                    contentPadding: EdgeInsets.zero))
            : const PopupMenuItem<MoreOptions>(
                value: MoreOptions.addReminder,
                child: ListTile(
                    leading: Icon(
                      Icons.add_circle,
                      size: 30,
                    ),
                    title: Text('Add Reminder', style: TextStyle(fontSize: 12)),
                    contentPadding: EdgeInsets.zero)),
        const PopupMenuDivider(),
        const PopupMenuItem<MoreOptions>(
            value: MoreOptions.remove,
            child: ListTile(
                leading: Icon(Icons.delete),
                title: Text('Remove', style: TextStyle(fontSize: 12)),
                contentPadding: EdgeInsets.zero))
      ],
    );
  }

  //to display when watchlist is empty
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
          Text('You have no shows!!',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFFd2d9d9),
                  fontFamily: 'Montserrat')),
          SizedBox(
            height: 10,
          ),
          Text(
            'Add to watchlist \n from tv shows',
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
}
