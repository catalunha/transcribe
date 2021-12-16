import 'package:flutter/material.dart';

final ThemeData appThemeDataLight = ThemeData(
  primarySwatch: Colors.green,
  primaryColor: Colors.green,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSwatch(
    accentColor: Colors.cyan[600],
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.green,
  ),
);

final ThemeData appThemeDataDark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.blue,
  primarySwatch: Colors.green,
);
