import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../main.dart';

class WatchListPage extends StatefulWidget {
  @override
  _WatchListPageState createState() => _WatchListPageState();
}

class _WatchListPageState extends State<WatchListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageTheme().pageTheme('Watch List', context,
          Swiper(
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                padding: EdgeInsets.all(2),
                margin: EdgeInsets.symmetric(vertical: 50),
                decoration: BoxDecoration(
                  boxShadow:[
                    BoxShadow(color: Colors.black,blurRadius: 5.0)],
                    borderRadius: BorderRadius.circular(20),
                    image:DecorationImage(
                       image: NetworkImage('https://static.episodate.com/images/tv-show/thumbnail/35624.jpg'),
                      fit: BoxFit.fill
                  )
                 ),
              );
            },
            itemCount: 3,
            viewportFraction: 0.7,
            control: SwiperControl(color: Colors.white),
            scale: 0.8,
          ),
        )
    );
  }
}