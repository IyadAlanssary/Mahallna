import 'package:flutter/material.dart';
import 'styles/colors.dart';
import 'splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mahallna',
      theme: AppColors.myTheme(),
      home: const SplashScreen(),
    );
  }
}
