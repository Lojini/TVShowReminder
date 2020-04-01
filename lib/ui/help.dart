import 'package:flutter/material.dart';
import '../main.dart';

class HelpPage extends StatefulWidget{
  @override
  _HelpPageState createState()=> _HelpPageState();
}

class _HelpPageState extends State<HelpPage>{
  @override
  Widget build(BuildContext context) {
    final Heading = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'How Do I Follow a show?',
        style: TextStyle(fontSize: 28.0, fontFamily:'Montserrat',color: Colors.black),
      ),
    );

    final first = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '1. Tap the title of a show or the show poster to access the show pages.',
        style: TextStyle(fontSize: 16.0,fontFamily:'Montserrat', color: Colors.black),
      ),
    );

    final second = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '2. There will be a yellow banner at the bottom of the page that says "ADD THIS SHOW".',
        style: TextStyle(fontSize: 16.0, fontFamily:'Montserrat',color: Colors.black),
      ),
    );

    final third = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '3. Tap the banner to follow the show.',
        style: TextStyle(fontSize: 16.0, fontFamily:'Montserrat',color: Colors.black),
      ),
    );

    final content = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(30.0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[Heading, first, second, third],
      ),
    );

    return Scaffold(
        body:PageTheme().pageTheme('Help', context, content,
    ));
  }
}