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
  final horizontalPadding = 10;
  final verticalPadding = 10;

  build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(color: Colors.blue[100]),
      child: Column(
        children: [
          //This row will be come the header of the side menu
          Row(
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: Container(
                  color: Colors.blue,
                ),
              ),
              Text('Crayons'),
            ],
          ),
          SizedBox(height: 50),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                MainMenuButton(text: 'Wall Street Bet Index'),
                Divider(),
                MainMenuButton(text: 'Trending Symbols'),
                Divider(),
                MainMenuButton(text: 'Algorithm Trading'),
                Divider(),
                MainMenuButton(text: 'Subscription'),
                Divider(),
                MainMenuButton(text: 'Setting'),
              ],
            ),
          ),
          MainMenuButton(text: 'Donation')
        ],
      ),
    );
  }
}

class MainMenuButton extends StatelessWidget {
  final String text;
  //final icon;

  MainMenuButton({
    @required this.text,
  });

  @override
  build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.blue[100],
        child: InkWell(
          focusColor: Colors.grey[600],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.mail, color: Colors.black, size: 30),
              SizedBox(
                width: 20,
              ),
              Text(text),
            ],
          ),
          onTap: () => {print('Inkwell is tapped')},
        ),
      ),
    );
  }
}
