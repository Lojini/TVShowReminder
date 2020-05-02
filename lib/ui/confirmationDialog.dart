/* Separated widget file to reuse in other pages
   This file contains the code for Alert dialog that appears when adding or deleting
   In addition,Used toast message to prompt after add or delete operation
   References:
      https://pub.dev/packages/fluttertoast
      https://medium.com/flutterpub/flutter-alert-dialog-to-custom-dialog-966195157da8
 */
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:tv_reminder/models/watchList.dart';
import 'package:tv_reminder/services/reminderApi.dart';
import 'package:tv_reminder/services/watchListApi.dart';
import 'package:tv_reminder/ui/notification.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConfirmationDialog extends StatefulWidget {
  final String reminderDocumentId;//document Id of a reminder
  final String watchlistDocumentId;//document Id of a show in watchlist
  final String pageName;//used to change the operation according to the page that invokes the dialog
  final String text;//text to show in the dialog
  final WatchList watchList;//watchlist object
  final String action;//delete or add operation

  //constructor
  ConfirmationDialog(
      {Key key,
      this.reminderDocumentId,
      this.watchlistDocumentId,
      this.pageName,
      this.text,
      this.watchList,
      this.action})
      : super(key: key);

  @override
  _ConfirmationDialogState createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  NotificationManager manager=new NotificationManager();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //if the action(operation) is to add,it shows heart icon
      //if delete operation,it shows title as 'confirm delete'
      title: widget.action == 'add'
          ? Align(
              alignment: Alignment.topLeft,
              child: Icon(Icons.favorite, color: Colors.red))
          : Text('Confirm delete'),
      content: Text(widget.text),
      actions: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          RaisedButton(
            color: Colors.cyan[600],
            child: Text('Yes'),
            onPressed: () {
              //conditions to handle operations
              if (widget.action == 'delete') {
                if (widget.pageName == 'Show Details') {
                  //while deleting watchlist,reminder will also be deleted
                  WatchListAPI.deleteWatchlist(widget.watchlistDocumentId);
                  ReminderAPI.deleteReminder(widget.reminderDocumentId);
                  //remove the notification after reminder is deleted
                  manager.removeReminder(1234);
                  //show toast message
                  showToast('Deleted successfully');
                  Navigator.pop(context);
                } else if (widget.pageName == 'Reminder') {
                  ReminderAPI.deleteReminder(widget.reminderDocumentId);
                  //update reminder state in watchlist to false with corresponding deletion of reminder
                  WatchListAPI.updateWatchlist(
                      widget.watchlistDocumentId, false);
                  showToast('Deleted successfully');
                  Navigator.pop(context);
                }
              } else if (widget.action == 'add') {
                WatchListAPI.addToWatchlist(widget.watchList);
                showToast('Added successfully');
                Navigator.pop(context);
              }
            },
          ),
          SizedBox(
            width: 10,
          ),
          RaisedButton(
            color: Colors.red,
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ])
      ],
    );
  }
  //show toast message
  void showToast(String text){
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[100],
        textColor: Colors.grey[600],
        fontSize: 16.0
    );
  }
}
