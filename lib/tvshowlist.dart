import 'package:flutter/material.dart';
import 'main.dart';

class TvShowList extends StatefulWidget{
  @override
  _TvShowListState createState()=> _TvShowListState();
}

class _TvShowListState extends State<TvShowList>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageTheme().pageTheme('TV Shows', ListView(), context)
    );
  }
}