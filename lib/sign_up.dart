import 'package:flutter/material.dart';

import 'log_in.dart';
import 'styles/colors.dart';
import 'common widgets/app_button.dart';
import 'common widgets/app_text.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 30,
                ),
                AppText(
                  text: 'Sign Up',
                  textAlign: TextAlign.center,
                  key: UniqueKey(),
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextField(
                  decoration: textfld('Full Name'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: textfld('User Name'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  obscureText: true,
                  decoration: textfld('Password'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  obscureText: true,
                  decoration: textfld('Confirm Password'),
                ),
                const SizedBox(
                  height: 40,
                ),
                getButton(),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Row(
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(fontSize: 13),
                      ),
                      InkWell(
                          child: const Text(
                            'Log in',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LogIn()),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void doNothing() {}

  InputDecoration textfld(String text) {
    return InputDecoration(
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      labelStyle: const TextStyle(
        color: AppColors.darkGrey,
      ),
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      labelText: text,
    );
  }

  Widget getButton() {
    return AppButton(
      label: "Sign Up",
      fontWeight: FontWeight.w600,
      padding: const EdgeInsets.symmetric(vertical: 25),
      onPressed: () {
        //onGetStartedClicked(context);
      },
    );
  }
}
