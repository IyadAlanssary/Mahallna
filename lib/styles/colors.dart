import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color(0xff009688);
  static const darkGrey = Color(0xff7C7C7C);
  static const greyBorderColor = Color(0xffcccccc);
  static String gilroyFontFamily = "Gilroy"; //not used any more
  static String sourceSansFontFamily = "SourceSans3";

  static ThemeData myTheme() {
    return ThemeData.light().copyWith(
      textTheme: ThemeData.light().textTheme.apply(
            fontFamily: sourceSansFontFamily,
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

  static Decoration myDecoration() {
    return BoxDecoration(
      image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(0.8),
            BlendMode.dstATop,
          ),
          image: const AssetImage(
            "assets/images/banner_background.png",
          ),
          fit: BoxFit.fitHeight),
    );
  }
}
