import 'package:flutter/material.dart';

RoundedRectangleBorder stylishCardShape = RoundedRectangleBorder(
  borderRadius: stylishBorderRadius,
);

BorderRadius stylishBorderRadius = BorderRadius.circular(12.0);

ThemeData stylishTheme = ThemeData(
  primaryColor: Colors.white,
  primaryColorDark: Colors.black,
  bottomAppBarColor: Colors.white,
  textSelectionColor: Colors.black12,
  accentColor: Color(0xffFA7B58),
  brightness: Brightness.light,
  backgroundColor: Color(0xffF2F2F2),
  unselectedWidgetColor: Colors.transparent,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  fontFamily: 'Helvetica',
  textTheme: TextTheme(
    bodyText1: TextStyle(fontSize: 16,color: Colors.black),
    headline2: TextStyle(fontSize: 22,fontStyle: FontStyle.italic,color: Colors.black),
    headline1: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Colors.black),
  )
);