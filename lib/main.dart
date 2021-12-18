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
      debugShowCheckedModeBanner: false,
      title: 'Grocery App',
      theme: AppColors.myTheme(),
      home: const LogIn(),
    );
  }
}
