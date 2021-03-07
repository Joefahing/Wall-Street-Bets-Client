import 'dart:ui';

import 'package:flutter/material.dart';

final lightOrange = Color(0x44FFC746);
final lightPink = Color(0x44FF8585);
final lightGreen = Color(0x4461B15A);
final lightSilver = Color(0x99BBBFCA);
final lightGray = Color(0xCCF2F2F2);
final darkSilver = Color(0x99000000);
final mediumGrey = Color(0xFF575757);
final darkOrange = Color(0xFFFF884B);
final darkGreen = Color(0xFF87AAAA);
final darkGrey = Colors.grey[800];
final limeGreen = Color(0xFF16C79A);
final fireRed = Color(0xFFFF4646);
final sunsetYellow = Color(0xFFFFC75F);
final leafGreen = Color(0xFF16C79A);

final wordSpacing = 2.0;
final baseFontSize = 5.0;
final borderRadius = 10.0;

final headline1 = TextStyle(
  fontFamily: 'Nunito',
  fontSize: baseFontSize * 5,
  fontWeight: FontWeight.w800,
);

final headline2 = TextStyle(
  fontFamily: 'Nunito',
  fontSize: baseFontSize * 4,
  fontWeight: FontWeight.w800,
);

final headline3 = TextStyle(
  fontFamily: 'Nunito',
  fontSize: baseFontSize * 3.5,
  fontWeight: FontWeight.w700,
);

final headline4 = TextStyle(
  fontFamily: 'Nunito',
  fontSize: baseFontSize * 3,
  fontWeight: FontWeight.w700,
);

final subhead1 = TextStyle(
  fontFamily: 'Nunito',
  fontSize: baseFontSize * 3,
  fontWeight: FontWeight.w700,
);

final bodyText = TextStyle(
  fontFamily: 'Nunito',
  fontSize: baseFontSize * 3,
  color: darkSilver,
  fontWeight: FontWeight.normal,
);

final bodyText2 = TextStyle(
  fontFamily: 'Nunito',
  fontSize: baseFontSize * 3,
  color: darkSilver,
  fontWeight: FontWeight.bold,
);

final mainTheme = ThemeData(
  primaryColor: darkOrange,
  scaffoldBackgroundColor: lightGray,
  cardTheme: CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    ),
  ),
  primaryTextTheme: TextTheme(
    bodyText1: TextStyle(color: Colors.green),
    bodyText2: TextStyle(
      color: Colors.red,
    ),
  ),
  textTheme: TextTheme(
    headline1: TextStyle(fontFamily: 'Nunito', fontSize: 18, fontWeight: FontWeight.w800),
    bodyText2: TextStyle(
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w800,
      fontSize: 15,
    ),
  ),
);

TextStyle getSubHeadWithColor(Color color) {
  return TextStyle(
    color: color,
    fontFamily: 'Nunito',
    fontSize: baseFontSize * 3,
    fontWeight: FontWeight.w700,
  );
}
