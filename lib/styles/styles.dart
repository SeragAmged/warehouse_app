import 'package:flutter/material.dart';
import 'colors.dart';

const TextTheme globalTextTheme = TextTheme(
  bodyMedium: TextStyle(),
  bodySmall: TextStyle(
    height: 1.3,
  ),
  titleLarge: TextStyle(),
  titleSmall: TextStyle(),
  bodyLarge: TextStyle(
    fontSize: 18.0,
  ),
  titleMedium: TextStyle(
    height: 1.4,
  ),
  displayMedium: TextStyle(),
);

ThemeData lightTheme = ThemeData(
  primaryColor: primaryColor,
  primarySwatch: primary,
  fontFamily: 'jannah',
  scaffoldBackgroundColor: Colors.grey.shade100,
  textTheme: globalTextTheme.apply(
    bodyColor: Colors.black,
    displayColor: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontSize: 20,
      // fontWeight: FontWeight.bold,
      fontFamily: 'jannah',
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 0,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.grey,
    showSelectedLabels: true,
    showUnselectedLabels: true,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.black,
  ),
);

ThemeData darkTheme = ThemeData(
  primaryColor: primaryColor,
  primarySwatch: primary,
  scaffoldBackgroundColor: Colors.black,
  fontFamily: 'jannah',
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  textTheme: globalTextTheme.apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.black,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: 'jannah',
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 0,
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.black,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
    showSelectedLabels: false,
    showUnselectedLabels: false,
  ),
);
