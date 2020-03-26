import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:tv_reminder/help.dart';
import 'package:tv_reminder/watchlist.dart';
import 'package:tv_reminder/reminder.dart';
import 'package:tv_reminder/tvshowlist.dart';

class BottomNavigationBarPage extends StatefulWidget {
  @override
  _BottomNavigationBarState createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBarPage> {
  int _currentIndex=0;
  final List<Widget> _children=[
    WatchListPage(),
    TvShowList(),
    Reminder(),
    HelpPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          color: Colors.white,
          backgroundColor: Colors.cyan[600],
          items: <Widget>[
            Icon(Icons.list,size: 30,),
            Icon(Icons.tv,size: 30,),
            Icon(Icons.history,size: 30),
            Icon(Icons.help_outline,size: 30,)
          ],
          onTap: (int index)=>{
            setState((){
              this._currentIndex=index;
            })
          },
        ),
        body:_children[_currentIndex],
    );
  }
}