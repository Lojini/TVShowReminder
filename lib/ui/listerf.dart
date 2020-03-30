import 'package:flutter/material.dart';
import 'package:tv_reminder/ui/bottomNavigator.dart';
import '../main.dart';

class ListerPage extends StatefulWidget {
  @override
  _ListerPageState createState() => _ListerPageState();
}

class _ListerPageState extends State<ListerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarPage(),
        body: PageTheme().pageTheme('Watch List',context,
            ListView(

            ))
    );
  }
}