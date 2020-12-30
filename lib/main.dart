import 'package:flutter/material.dart';

import 'package:wsb_dashboard/widgets/home.dart';

void main() {
  runApp(WallStreetBets());
}

class WallStreetBets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wall Street Bets Fools Index',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: WallStreetBetHomePage(title: 'Wall Street Bets Fools Index'),
    );
  }
}
