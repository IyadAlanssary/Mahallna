import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:products/bottom_navigation_bar.dart';
import 'package:products/welcome_screen.dart';
import 'package:products/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Models/user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isRegistered = false, createdUser = false;

  Future<void> sharedPreference() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      isRegistered = prefs.getBool('is_register')!;
      if (isRegistered) {
        User.currentUser = User(
          id: prefs.getInt('id')!,
          name: prefs.getString('name')!,
          phone: prefs.getString('phone')!,
          token: prefs.getString('token')!,
        );
        createdUser = true;
      }
    } catch (e) {
      print("in splash error $e");
    }
  }

  @override
  void initState() {
    sharedPreference();
    super.initState();
    Timer(
        const Duration(seconds: 4),
        () => {
              if (isRegistered && createdUser)
                {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BottomNavBar(),
                      ))
                }
              else
                {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const WelcomeScreen(),
                      ))
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.primaryColor,
      body: Container(
        decoration: AppColors.myDecoration(),
        child: Center(
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
                color: Colors.teal,
                fontSize: 36,
                letterSpacing: 4,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
