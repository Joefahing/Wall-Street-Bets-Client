///The side menu will contain
///1. background color: ?
///2. Everything is centered
///3. Name Crayons
///4. Menu Items
/// 1. Wall Strret Bet Index
/// 2. Trending Symbols
/// 3. Algo trading
///
///

import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(color: Colors.blue[100]),
      child: Column(
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: Container(
              color: Colors.blue,
            ),
          ),
          Text('Crayon'),
        ],
      ),
    );
  }
}
