import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:project/utils/constants.dart';

ThemeData themeData() {
  return ThemeData(
    appBarTheme: appBarTheme(),
    primaryColor: kPrimaryColor,
    primarySwatch: Colors.grey,
    primaryColorDark: kPrimaryColor,
    accentColor: kPrimaryColor,

    // canvasColor: Colors.transparent,

    textTheme: textTheme(),
    fontFamily: "Cairo",
    scaffoldBackgroundColor: Colors.white,
    // inputDecorationTheme: inputDecorationTheme(),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    elevation: 4.0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline6: TextStyle(
          color: Colors.black, fontSize: 19, fontWeight: FontWeight.w700),
    ),
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(
      color: Colors.black,
    ),
    bodyText2: TextStyle(color: Colors.black),
    button: TextStyle(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(28.0)),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}
