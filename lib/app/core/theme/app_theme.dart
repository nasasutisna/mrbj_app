import 'package:flutter/material.dart';
import 'package:mrbj_app/app/core/theme/colors_theme.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: primaryColor,
  secondaryHeaderColor: secondaryColor,
  splashColor: primaryColor,
  highlightColor: primaryColor,
  appBarTheme: AppBarTheme(color: primaryColor),
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    primary: primaryColor, //<-- SEE HERE
  ),
);
