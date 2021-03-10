import 'package:flutter/material.dart';

import './components/theme_data.dart';
import 'pages/main_screen.dart';
import 'pages/routes.dart';

void main() {
  runApp(WallStreetBets());
}

/// Material card Text uses bodyText2 Theme

class WallStreetBets extends StatelessWidget {
  final customRoute = Routes();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wall Street Bets Fools Index',
      theme: mainTheme,
      debugShowCheckedModeBanner: false,
      home: MainScreen(pageName: 'index'),
      routes: {
        customRoute.index: (context) => customRoute.indexPage,
        customRoute.trending: (context) => customRoute.trendingPage,
        customRoute.algo: (context) => customRoute.algoPage,
        customRoute.subscription: (context) => customRoute.subscriptionPage,
        customRoute.setting: (context) => customRoute.settingPage,
        customRoute.about: (context) => customRoute.aboutPage,
      },
    );
  }
}
