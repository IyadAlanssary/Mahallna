import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'styles/colors.dart';
import 'splash_screen.dart';
import 'log_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData.light().copyWith(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.primaryColor,
          selectionHandleColor: AppColors.primaryColor,
        ),
        focusColor: AppColors.primaryColor,
        scaffoldBackgroundColor: const Color.fromRGBO(224, 224, 224, 1),
        primaryColor: AppColors.primaryColor,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: AppColors.primaryColor),
      ),
      home: const LogIn(),
    );
  }
}
