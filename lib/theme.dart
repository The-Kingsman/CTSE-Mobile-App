import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    primarySwatch: Colors.green,
    accentColor: Colors.teal,
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(
      color: Color(0xff3399ff),
      fontSize: 20,
    ),
    bodyText2: TextStyle(
      color: Colors.black,
    ),
    headline1: TextStyle(
      fontSize: 20,
      color: Color(0xff3399ff),
    ),
  );
}

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    filled: true,
    fillColor: Colors.white,
    labelStyle: const TextStyle(color: Colors.black),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Colors.blue, width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.red.shade200, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Colors.blue, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
    ),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(
      color: Colors.grey[800],
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.grey[800],
        fontSize: 20,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.5,
      ),
    ),
  );
}
