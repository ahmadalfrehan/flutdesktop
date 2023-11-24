import 'package:flutdesktop/config/style.dart';
import 'package:flutter/material.dart';

class MyAppTheme {
  static final myTheme = ThemeData(
      fontFamily: 'Karla',
      primarySwatch: primarySwatch,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: colorHead,
      ));
}
