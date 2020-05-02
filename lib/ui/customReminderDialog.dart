/* Separated widget file to reuse the dialog
   This file contains the code of Dialog box for adding and updating a reminder
   Used toast message to prompt after adding or updating
   References:
     for custom dialog: https://medium.com/@excogitatr/custom-dialog-in-flutter-d00e0441f1d5
     for drop down menu :https://medium.com/@naumanahmed19/flutter-dropdown-validation-357ef05d1788
 */
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tv_reminder/models/reminder.dart';
import 'package:tv_reminder/services/reminderApi.dart';
import 'package:tv_reminder/services/watchListApi.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'notification.dart';

class CustomReminderDialog extends StatefulWidget {
  final Reminder reminder;//reminder object
  final String documentId;//documentId of watchlist or reminder
  final Timestamp showDateTime;//Date and time of show

  //constructor
  CustomReminderDialog(
      {Key key, this.documentId, this.reminder, this.showDateTime})
      : super(key: key);

  @override
  _CustomReminderDialogState createState() => _CustomReminderDialogState();
}

class _CustomReminderDialogState extends State<CustomReminderDialog> {
  bool _isButtonDisabled = true;//to enable or disable the button in dialog
  String dropdownValue;
  NotificationManager manager;//notification object

  @override
  void initState() {
    super.initState();
    if (widget.documentId != null)
      dropdownValue = widget.reminder.reminderStart;
    manager = NotificationManager();
  }

  @override
  Widget build(BuildContext context) {
    //convert the date and time of the show to local timezone from UTC
    //set the format of date to Month Date, Year
    var date = DateFormat.yMMMMd("en_US")
        .format(widget.reminder.showDateTime.toDate().toLocal());
    //set the time format in 12 hour clock time
    var time =
        DateFormat.jm().format(widget.reminder.showDateTime.toDate().toLocal());
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 70),
            margin: EdgeInsets.symmetric(vertical: 55),
            decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 5.0,
                  )
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    widget.reminder.showName,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Reminder',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.calendar_today,
                            size: 20,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            date,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.access_time,
                            size: 20,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            time,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Text('Remind me before',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          DropdownButton<String>(
                            value: dropdownValue,
                            items: <String>[
                              '5 minutes',
                              '15 minutes',
                              '30 minutes',
                              '1 hour'
                            ].map((String value) {
                              return new DropdownMenuItem(
                                  value: value, child: new Text(value));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                //set the dropdown value with selected current value
                                dropdownValue = value;
                                //button in dialog to add or update gets enabled only if the dropdown value is set
                                if (widget.reminder.reminderStart !=
                                    dropdownValue)
                                  _isButtonDisabled = false;
                                else
                                  _isButtonDisabled = true;
                              });
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40))),
                    color: Colors.cyan[600],
                    onPressed: _isButtonDisabled
                        ? null
                        : () {
                           //if reminder time is not empty and already has a value,
                          // then the dialog opens to update the existing value
                            if (widget.documentId != null &&
                                widget.reminder.reminderStart != null) {
                              ReminderAPI.updateReminder(
                                  widget.documentId, dropdownValue);
                              showToast('Updated successfully');
                              Navigator.pop(context);
                            } else {
                              int remind;//set according to the selected dropdown value
                              ReminderAPI.addReminder(new Reminder(
                                  showName: widget.reminder.showName,
                                  watchlistId: widget.documentId,
                                  imageUrl: widget.reminder.imageUrl,
                                  showDateTime: widget.reminder.showDateTime,
                                  reminderStart: dropdownValue));
                              switch (dropdownValue) {
                                case '5 minutes':
                                  remind = 5;
                                  break;
                                case '15 minutes':
                                  remind = 15;
                                  break;
                                case '30 minutes':
                                  remind = 30;
                                  break;
                                case '1 hour':
                                  remind = 60;
                              }
                              //schedule reminder to alert before given time
                              manager.scheduleReminder(
                                  widget.reminder.showName,
                                  widget.reminder.showDateTime
                                      .toDate()
                                      .toLocal(),
                                  remind);
                              WatchListAPI.updateWatchlist(
                                  widget.documentId, true);
                              showToast('Added successfully');
                              Navigator.pop(context);
                            }
                          },
                    child: Container(
                      constraints: BoxConstraints(minHeight: 50, minWidth: 600),
                      alignment: Alignment.center,
                      child: Text(
                        //condition to change the text on button
                        widget.reminder.reminderStart != null &&
                                widget.documentId != null
                            ? "Update"
                            : "Add",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            right: 0.0,
            top: 40,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  backgroundColor: Colors.cyan[600],
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              left: 110,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.cyan[600]),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.reminder.imageUrl),
                  radius: 55,
                ),
              )),
        ],
      ),
    );
  }
  //show toast message
  void showToast(String text){
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[100],
        textColor: Colors.grey[600],
        fontSize: 16.0
    );
  }
}
