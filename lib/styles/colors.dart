import 'package:flutter/material.dart';

const Color primaryColor = Color.fromRGBO(88, 129, 87, 1);

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFEBF0EB),
  100: Color(0xFFCDD9CD),
  200: Color(0xFFACC0AB),
  300: Color(0xFF8AA789),
  400: Color(0xFF719470),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFF50794F),
  700: Color(0xFF476E46),
  800: Color(0xFF3D643C),
  900: Color(0xFF2D512C),
});
const int _primaryPrimaryValue = 0xFF588157;

const MaterialColor primaryAccent =
    MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFF9FFF9C),
  200: Color(_primaryAccentValue),
  400: Color(0xFF3CFF36),
  700: Color(0xFF23FF1D),
});
const int _primaryAccentValue = 0xFF6EFF69;
