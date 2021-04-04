import 'package:flutter/material.dart';
import 'package:wsb_dashboard/pages/error/error_page.dart';

import '../widgets/menu/side_menu.dart';
import '../widgets/responsive_container.dart';

import 'index/index_page.dart';
import 'trending/trending_page.dart';
import 'algo/algo_page.dart';
import 'subscription/subscription_page.dart';
import 'setting/setting_page.dart';
import 'about/about_page.dart';
import 'error/error_page.dart';

class MainScreen extends StatelessWidget {
  final Map<String, Widget> pages = {
    'index': WallStreetBetIndexPage(),
    'trending': TrendingPage(),
    'algo': AlgoPage(),
    'subscription': SubscriptionPage(),
    'about': AboutPage(),
    'setting': SettingPage(),
    'error': ErrorPage(),
  };

  final String pageName;

  MainScreen({
    @required this.pageName,
  });

  @override
  build(BuildContext context) {
    return Scaffold(
      body: ResponsiveContainer(
        mobile: Container(
          child: Text('Mobile View'),
        ),
        tablet: Row(
          children: [
            Expanded(flex: 3, child: SideMenu()),
            Expanded(
              flex: 10,
              child: pages.containsKey(this.pageName) ? pages[pageName] : pages['error'],
            ),
          ],
        ),
        desktop: Row(
          children: [
            Expanded(flex: 3, child: SideMenu()),
            Expanded(
              flex: 10,
              child: pages.containsKey(this.pageName) ? pages[pageName] : pages['error'],
            ),
          ],
        ),
      ),
    );
  }
}
