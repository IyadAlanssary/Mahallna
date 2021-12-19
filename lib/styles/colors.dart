import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color(0xff009688);
  static const darkGrey = Color(0xff7C7C7C);
  static String gilroyFontFamily = "Gilroy";

  static ThemeData myTheme() {
    return ThemeData.light().copyWith(
      //visualDensity: VisualDensity.adaptivePlatformDensity, /////does not change anything
      textTheme: ThemeData.light().textTheme.apply(
            fontFamily: 'SourceSans3',
          ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.primaryColor,
        selectionHandleColor: AppColors.primaryColor,
      ),
      focusColor: AppColors.primaryColor,
      scaffoldBackgroundColor: const Color.fromRGBO(224, 224, 224, 1),
      primaryColor: AppColors.primaryColor,
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: AppColors.primaryColor),
    );
  }
}

/*
primaryTextTheme: ThemeData.light().textTheme.apply(
          fontFamily: gilroy..,
        ),
    accentTextTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'RobotoMono',
        ),
 */
