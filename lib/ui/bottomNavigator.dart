/*This is separated reusable widget for bottom navigator
  References:
  https://pub.dev/packages/curved_navigation_bar
 */
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:tv_reminder/ui/reminder.dart';
import 'package:tv_reminder/ui/tvshowlist.dart';
import 'package:tv_reminder/ui/watchlist.dart';
import 'help.dart';

class BottomNavigationBarPage extends StatefulWidget {
  @override
  _BottomNavigationBarState createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBarPage> {
  //set when a new tab is tapped
  int _currentIndex = 0;
  //list of UI pages
  final List<Widget> _children = [
    WatchListPage(),
    TvShowList(),
    ReminderPage(),
    HelpPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        color: Colors.white,
        backgroundColor: Color(0xFF00ACC1),
        items: <Widget>[
          Icon(
            Icons.list,
            size: 30,
          ),
          Icon(
            Icons.tv,
            size: 30,
          ),
          Icon(Icons.alarm, size: 30),
          Icon(
            Icons.help_outline,
            size: 30,
          )
        ],
        onTap: (int index) => {
          setState(() {
            //update tab index with tapped tab's index
            this._currentIndex = index;
          })
        },
      ),
      //change the body of the scaffold widget with the current index
      body: _children[_currentIndex],
    );
  }
}
