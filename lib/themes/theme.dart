import 'package:flutter/material.dart';

final ThemeData myTheme = ThemeData(
  useMaterial3: false,
  primarySwatch: Colors.blue,
  buttonTheme: const ButtonThemeData(buttonColor: Colors.blue),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF202020),
    onPrimary: Color(0xFF505050),
    secondary: Color(0xFFBBBBBB),
    onSecondary: Color(0xFFEAEAEA),
    error: Color(0xFFF32424),
    onError: Color(0xFFF32424),
    background: Color(0xFFF1F2F3),
    onBackground: Color(0xFFFFFFFF),
    surface: Color.fromARGB(255, 60, 212, 10),
    onSurface: Color(0xFF54B435),
  ),
  textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 20.0),
      bodyMedium: TextStyle(fontSize: 16.0),
      bodySmall: TextStyle(fontSize: 12.0)),
);
