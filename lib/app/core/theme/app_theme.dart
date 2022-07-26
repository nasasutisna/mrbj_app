import 'package:flutter/material.dart';
import 'package:mrbj_app/app/core/theme/colors_theme.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: primaryColor,
  secondaryHeaderColor: secondaryColor,
  splashColor: primaryColor,
  highlightColor: primaryColor,
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
);
