///The side menu will contain
///1. background color: ?
///2. Everything is centered
///3. Name Crayonse
///4. Menu Items
/// 1. Wall Strret Bet Index
/// 2. Trending Symbols
/// 3. Algo trading
///
///

import 'package:flutter/material.dart';
import 'side_menu_button.dart';
import '../../components/theme_data.dart' as theme;

import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SideMenu extends StatefulWidget {
  SideMenu({Key key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final horizontalPadding = 10.0;
  final verticalPadding = 25.0;
  final iconSize = 40.0;
  final backgroundColor = Colors.white;

  final logo = 'assets/images/crayon_logo.png';
  final algoIcon = 'assets/images/algorithmn_menu.svg';
  final indexMenuIcon = 'assets/images/index_menu.svg';
  final aboutMeIcon = 'assets/images/man_menu.svg';
  final subscriptionIcon = 'assets/images/subscription_menu.svg';
  final settingIcon = 'assets/images/settings_menu.svg';
  final trendingIcon = 'assets/images/trending.svg';

  String clickedButton = 'index';

  onButtonClicked(String label) {
    setState(() {
      clickedButton = label;
    });
  }

  build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: horizontalPadding,
      ),
      height: double.infinity,
      decoration: BoxDecoration(color: backgroundColor),
      child: Column(
        children: [
          //This row will be come the header of the side menu
          Padding(
            padding: EdgeInsets.only(left: verticalPadding),
            child: Row(
              children: [
                Container(
                  width: iconSize + 10,
                  height: iconSize + 10,
                  decoration: BoxDecoration(
                    color: theme.darkGrey,
                    borderRadius: BorderRadius.circular(theme.borderRadius),
                  ),
                  child: Center(
                    child: SizedBox(
                      height: iconSize,
                      width: iconSize,
                      child: Image.asset(logo),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                RichText(
                  text: TextSpan(
                    style: theme.headline2,
                    children: [
                      TextSpan(text: 'CRA', style: TextStyle(color: theme.fireRed)),
                      TextSpan(text: 'Y', style: TextStyle(color: theme.sunsetYellow)),
                      TextSpan(text: 'ONS', style: TextStyle(color: theme.leafGreen)),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 40),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                SideMenuButton(
                  text: 'Wall Street Bet Index',
                  label: 'index',
                  iconName: indexMenuIcon,
                  color: clickedButton == 'index' ? theme.darkGreen : theme.mediumGrey,
                  isSelected: clickedButton == 'index',
                  verticalPaddings: verticalPadding,
                  onPress: onButtonClicked,
                ),
                SideMenuButton(
                  text: 'Trending Symbols',
                  label: 'trending',
                  iconName: trendingIcon,
                  color: clickedButton == 'trending' ? theme.darkGreen : theme.mediumGrey,
                  isSelected: clickedButton == 'trending',
                  verticalPaddings: verticalPadding,
                  onPress: onButtonClicked,
                ),
                SideMenuButton(
                  text: 'Algorithm Trading',
                  label: 'algo',
                  iconName: algoIcon,
                  color: clickedButton == 'algo' ? theme.darkGreen : theme.mediumGrey,
                  isSelected: clickedButton == 'algo',
                  verticalPaddings: verticalPadding,
                  onPress: onButtonClicked,
                ),
                SideMenuButton(
                  text: 'Subscription',
                  label: 'subscription',
                  iconName: subscriptionIcon,
                  color: clickedButton == 'subscription' ? theme.darkGreen : theme.mediumGrey,
                  isSelected: clickedButton == 'subscription',
                  verticalPaddings: verticalPadding,
                  onPress: onButtonClicked,
                ),
                SideMenuButton(
                  text: 'Settings',
                  label: 'settings',
                  iconName: settingIcon,
                  color: clickedButton == 'settings' ? theme.darkGreen : theme.mediumGrey,
                  isSelected: clickedButton == 'settings',
                  verticalPaddings: verticalPadding,
                  onPress: onButtonClicked,
                ),
              ],
            ),
          ),
          SideMenuButton(
            text: 'Who Am I?',
            label: 'who',
            iconName: aboutMeIcon,
            color: clickedButton == 'who' ? theme.darkGreen : theme.mediumGrey,
            isSelected: clickedButton == 'who',
            verticalPaddings: verticalPadding,
            onPress: onButtonClicked,
          ),

          SideMenuFooter()
        ],
      ),
    );
  }
}

class SideMenuFooter extends StatelessWidget {
  final donationIcon = 'assets/images/donation_menu.svg';
  final url = 'https://www.buymeacoffee.com/';
  final verticalPadding = 25.0;
  final footerHeigh = 50.0;
  final iconSize = 25.0;
  final itemColor = theme.mediumPink;
  final backgroundColor = Colors.white;

  @override
  build(BuildContext context) {
    return Container(
      color: backgroundColor,
      height: footerHeigh,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: Material(
              color: backgroundColor,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.only(left: verticalPadding),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        donationIcon,
                        height: iconSize,
                        width: iconSize,
                        color: itemColor,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text('Support This Project', style: TextStyle(color: itemColor)),
                    ],
                  ),
                ),
                onTap: () => {launch(url)},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
