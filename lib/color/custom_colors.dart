import 'package:flutter/material.dart';

class CustomColors {
  static const int _primaryValue = 0xFF00ADA7;
  static const MaterialColor primary = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xFFE0F2F1),
      100: Color(0xFFB2DFDB),
      200: Color(0xFF80CBC4),
      300: Color(0xFF4DB6AC),
      400: Color(0xFF26A69A),
      500: Color(_primaryValue),
      600: Color(0xFF00897B),
      700: Color(0xFF00796B),
      800: Color(0xFF00695C),
      900: Color(0xFF004D40),
    },
  );

  static const int _secondaryValue = 0xFFF9732A;
  static const MaterialColor secondary = MaterialColor(
    _secondaryValue,
    <int, Color>{
      50: Color(0xFFFBE9E7),
      100: Color(0xFFFFCCBC),
      200: Color(0xFFFFAB91),
      300: Color(0xFFFF8A65),
      400: Color(0xFFFF7043),
      500: Color(_secondaryValue),
      600: Color(0xFFF4511E),
      700: Color(0xFFE64A19),
      800: Color(0xFFD84315),
      900: Color(0xFFBF360C),
    },
  );
}
