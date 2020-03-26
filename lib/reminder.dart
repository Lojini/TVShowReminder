import 'package:flutter/material.dart';
import 'main.dart';

class Reminder extends StatefulWidget{
  @override
  _ReminderState createState()=> _ReminderState();
}

class _ReminderState extends State<Reminder>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageTheme().pageTheme('Reminder', ListView(), context)
    );
  }
}