import 'package:flutter/material.dart';
import 'main.dart';

class HelpPage extends StatefulWidget{
  @override
  _HelpPageState createState()=> _HelpPageState();
}

class _HelpPageState extends State<HelpPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:PageTheme().pageTheme('Help', Container(), context)
    );
  }
}