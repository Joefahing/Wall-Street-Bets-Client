import 'package:flutter/material.dart';

import '../widgets/side_menu.dart';
import '../widgets/responsive_container.dart';
import 'home/Home.dart';

class MainScreen extends StatelessWidget {
  @override
  build(BuildContext context) {
    return Scaffold(
      body: ResponsiveContainer(
        mobile: Container(
          child: Text('Mobile View'),
        ),
        tablet:  Row(
          children: [
            Expanded( 
              flex: 3,
              child: SideMenu()),
            Expanded(
              flex: 10,
                child: WallStreetBetIndexPage(
              title: 'Wall Street Bets Fools Index',
            )),
          ],
        ),
        desktop: Row(
          children: [
            Expanded( 
              flex: 3,
              child: SideMenu()),
            Expanded(
              flex: 10,
                child: WallStreetBetIndexPage(
              title: 'Wall Street Bets Fools Index',
            )),
          ],
        ),
      ),
    );
  }
}
