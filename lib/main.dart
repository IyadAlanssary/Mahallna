// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'styles/colors.dart';
import 'common widgets/app_button.dart';
import 'common widgets/app_text.dart';
import 'splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData.light().copyWith(
        //fontFamily: gilroyFontFamily,
        //visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Color.fromRGBO(224, 224, 224, 1),
        primaryColor: AppColors.primaryColor,
      ),
      home: const MyHomePage(title: 'Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // ignore: prefer_const_constructors
            AppText(
              text: 'Log in',
              textAlign: TextAlign.center,
              key: UniqueKey(),
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 120,
            ),
            TextField(
              decoration: textfld('User Name'),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              obscureText: true,
              decoration: textfld('Password'),
            ),
            SizedBox(
              height: 60,
            ),
            getButton(),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Row(
                children: [
                  Text(
                    'Don\'t have an account yet? ',
                    style: TextStyle(fontSize: 13),
                  ),
                  InkWell(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SplashScreen()),
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void doNothing() {}

  InputDecoration textfld(String text) {
    return InputDecoration(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      labelStyle: TextStyle(
        color: AppColors.darkGrey,
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      labelText: text,
    );
  }

  Widget getButton() {
    return app_button(
      label: "Log in",
      fontWeight: FontWeight.w600,
      padding: EdgeInsets.symmetric(vertical: 25),
      onPressed: () {
        //onGetStartedClicked(context);
      },
    );
  }
}
