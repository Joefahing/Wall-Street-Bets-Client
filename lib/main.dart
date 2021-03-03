import 'package:flutter/material.dart';

import './components/theme_data.dart';
import 'pages/main_screen.dart';

void main() {
  runApp(WallStreetBets());
}

/// Material card Text uses bodyText2 Theme

class WallStreetBets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wall Street Bets Fools Index',
      theme: mainTheme,
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
