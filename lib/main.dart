import 'package:flutter/material.dart';

import './components/theme_data.dart';
import 'pages/main_screen.dart';
import 'pages/routes.dart';
import 'pages/unanimated_route.dart';

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
      home: MainScreen(pageName: 'index'),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/index':
            return UnanimatedRoute(settings: settings, builder: (_) => Routes.indexPage);
          case '/trending':
            return UnanimatedRoute(settings: settings, builder: (_) => Routes.trendingPage);
          case '/algo':
            return UnanimatedRoute(settings: settings, builder: (_) => Routes.algoPage);
          case '/subscription':
            return UnanimatedRoute(settings: settings, builder: (_) => Routes.subscriptionPage);
          case '/setting':
            return UnanimatedRoute(settings: settings, builder: (_) => Routes.settingPage);
          case '/about':
            return UnanimatedRoute(settings: settings, builder: (_) => Routes.aboutPage);

          default:
            return UnanimatedRoute(settings: settings, builder: (_) => Routes.indexPage);
        }
      },
    );
  }
}
