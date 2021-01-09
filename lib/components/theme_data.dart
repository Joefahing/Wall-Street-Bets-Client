import 'dart:ui';

import 'package:flutter/material.dart';

final lightGray = Color(0xFFF1F1F1);
final lightOrange = Color(0x44FFC746);
final lightPink = Color(0x44FF8585);
final lightGreen = Color(0x4461B15A);
final darkOrange = Color(0xFFFF884B);
final limeGreen = Color(0xFF16C79A);
final fireRed = Color(0xFFFF4646);

final wordSpacing = 2.0;
final baseFontSize = 5.0;

final headline1 = TextStyle(
  fontFamily: 'Nunito',
  fontSize: baseFontSize * 5,
  fontWeight: FontWeight.w800,
);

final headline2 = TextStyle(
  fontFamily: 'Nunito',
  fontSize: baseFontSize * 4,
  fontWeight: FontWeight.w700,
);

final headline3 = TextStyle(
  fontFamily: 'Nunito',
  fontSize: baseFontSize * 3.5,
  fontWeight: FontWeight.w700,
);

final bodyText = TextStyle(
  fontFamily: 'Nunito',
  fontSize: baseFontSize * 3,
  fontWeight: FontWeight.normal,
);

final mainTheme = ThemeData(
  primaryColor: darkOrange,
  scaffoldBackgroundColor: lightGray,
  cardTheme: CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
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
