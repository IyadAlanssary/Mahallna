import 'dart:async';
import 'package:flutter/material.dart';
import 'package:products/welcome_screen.dart';
import 'package:products/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 4),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const WelcomeScreen(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            "assets/icons/app_icon_color.svg",
            width: 48,
            height: 56,
          ),
          const Text(
            'Mahallna',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              letterSpacing: 4,
            ),
          ),
        ],
      )),
    );
  }
}
