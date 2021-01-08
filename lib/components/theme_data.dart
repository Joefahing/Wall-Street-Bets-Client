import 'package:flutter/material.dart';

final lightGray = Color(0xFFF4F4F4);
final lightOrange = Color(0x44FFC746);
final lightPink = Color(0x44FF8585);
final lightGreen = Color(0x4461B15A);
final darkOrange = Color(0xFFFF884B);
final limeGreen = Color(0xFF16C79A);
final fireRed = Color(0xFFFF4646);

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
      color: Colors.green,
    ),
  ),
  textTheme: TextTheme(
    bodyText2: TextStyle(color: Colors.black),
  ),
);
