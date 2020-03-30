import 'dart:core';
import 'package:flutter/material.dart';
import 'package:tv_reminder/models/reminder.dart';
import 'package:tv_reminder/services/reminderApi.dart';

class CustomReminderDialog extends StatefulWidget{
  final Reminder reminder;
  final String documentId;

  CustomReminderDialog({Key key,this.documentId,this.reminder}):super(key:key);

 @override
  _CustomReminderDialogState createState()=>_CustomReminderDialogState();

}
class _CustomReminderDialogState extends State<CustomReminderDialog>{
  bool _IsButtonDisabled= true;
   String  dropdownValue;

  @override
  void initState(){
    super.initState();
    dropdownValue = widget.reminder.reminderStart;
  }

  @override
  Widget build(BuildContext context){
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children:[
          Container(
            padding: EdgeInsets.only(top: 70),
            margin: EdgeInsets.symmetric(vertical:55),
            decoration: new BoxDecoration(
                color: Colors.white,
                shape:BoxShape.rectangle,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color:Colors.black,
                    blurRadius: 5.0,
                  )
                ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment:Alignment.topCenter,
                  child:Text(
                    widget.reminder.showName,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'
                    ),
                  ) ,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:<Widget>[
                      Text('Reminder',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),),
                      SizedBox(height: 20,),
                      Row(
                        children: <Widget>[
                          Icon(Icons.calendar_today,size: 30,color: Colors.grey,),
                          SizedBox(width: 10,),
                          Text(widget.reminder.showDate,
                            style: TextStyle(
                              fontSize: 14,
                            ),),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          Icon(Icons.access_time,size: 30,color: Colors.grey,),
                          SizedBox(width: 10,),
                          Text(widget.reminder.showTime,
                            style: TextStyle(
                              fontSize: 14,
                            ),),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Text('Remind me before',
                              style: TextStyle(
                                fontSize: 14.0,)
                          ),
                          SizedBox(width: 10,),
                          DropdownButton<String>(
                            value: dropdownValue,
                            items: <String>['5 minutes','15 minutes','30 minutes','1 hour'].map((String value){
                              return new DropdownMenuItem(
                                  value:value,
                                  child:new Text(value)
                              );
                            }).toList(),
                            onChanged: (value){
                              setState(() {
                                dropdownValue = value;
                                if(widget.reminder.reminderStart != dropdownValue)
                                  _IsButtonDisabled = false;
                                else
                                  _IsButtonDisabled = true;
                              });
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.0,),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40)
                        )
                    ),
                    color: Colors.cyan[600],
                    onPressed: _IsButtonDisabled ? null : (){
                      if(widget.documentId!=null && dropdownValue!=null){
                        ReminderAPI.updateReminder(widget.documentId, dropdownValue);
                        Navigator.pop(context);
                       }
                      else
                        ReminderAPI.addReminder(new Reminder(
                            showName: widget.reminder.showName,
                            imageUrl: widget.reminder.imageUrl,
                            showDate: widget.reminder.showDate,
                            showTime: widget.reminder.showTime,
                            reminderStart: widget.reminder.reminderStart));
                     },
                    child:Container(
                      constraints: BoxConstraints(minHeight: 50,minWidth: 600),
                      alignment: Alignment.center,
                      child:Text(
                        widget.reminder.showName !=null && widget.documentId!=null ? "Update" : "Add"
                      ,style: TextStyle(
                          fontSize: 16,color: Colors.white
                      ),),
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
              onTap: (){
                Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  backgroundColor: Colors.cyan[600],
                  child: Icon(Icons.close,color: Colors.white,),
                ),
              ),
            ),

          ),
          Positioned(
              left: 110,
              child:Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.cyan[600]
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.reminder.imageUrl),
                  radius: 55,
                ),
              )
          ),
        ],
      ),
    );
  }
}