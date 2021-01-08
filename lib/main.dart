import 'package:flutter/material.dart';

import 'package:wsb_dashboard/pages/Home.dart';

void main() {
  runApp(WallStreetBets());
}
/// Material card Text uses bodyText2 Theme

class WallStreetBets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wall Street Bets Fools Index',
      theme: ThemeData(
        primaryColor: Colors.white,
        backgroundColor: Colors.white70,

        primaryTextTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.green),
          bodyText2: TextStyle(color: Colors.green)
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black), 
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: WallStreetBetHomePage(title: 'Wall Street Bets Fools Index'),
    );
  }
}
