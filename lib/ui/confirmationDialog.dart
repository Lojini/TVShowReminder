import 'dart:core';
import 'package:flutter/material.dart';
import 'package:tv_reminder/models/watchList.dart';
import 'package:tv_reminder/services/reminderApi.dart';
import 'package:tv_reminder/services/watchListApi.dart';
import 'package:tv_reminder/ui/notification.dart';

class ConfirmationDialog extends StatefulWidget {
  final String reminderDocumentId;
  final String watchlistDocumentId;
  final String pageName;
  final String text;
  final WatchList watchList;
  final String action;

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
              if (widget.action == 'delete') {
                if (widget.pageName == 'Show Details') {
                  WatchListAPI.deleteWatchlist(widget.watchlistDocumentId);
                  ReminderAPI.deleteReminder(widget.reminderDocumentId);
                  manager.removeReminder(1234);
                  Navigator.pop(context);
                } else if (widget.pageName == 'Reminder') {
                  ReminderAPI.deleteReminder(widget.reminderDocumentId);
                  WatchListAPI.updateWatchlist(
                      widget.watchlistDocumentId, false);
                  Navigator.pop(context);
                }
              } else if (widget.action == 'add') {
                WatchListAPI.addToWatchlist(widget.watchList);
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
}
