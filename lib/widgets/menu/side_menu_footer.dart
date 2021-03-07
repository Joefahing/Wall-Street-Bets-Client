import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/theme_data.dart' as theme;

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
