import 'package:flutter/material.dart';
import 'package:products/sign_up.dart';
import 'package:products/view.dart';

import 'styles/colors.dart';
import 'common widgets/app_button.dart';
import 'splash_screen.dart';

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        //resizeToAvoidBottomInset: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 70),
                const Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                TextField(
                  textInputAction: TextInputAction.next,
                  decoration: textfld('User Name'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  decoration: textfld('Password'),
                ),
                const SizedBox(
                  height: 60,
                ),
                getButton(context),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account yet? ',
                      style: TextStyle(fontSize: 13),
                    ),
                    InkWell(
                        child: const Text(
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
                                builder: (context) => const SignUp()),
                          );
                        }),
                  ],
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

  Widget getButton(BuildContext context) {
    return AppButton(
      label: "Log in",
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ViewLess()),
        );

        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => const View()));

        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //   builder: (BuildContext context) {
        //     return const View();
        //   },
        // ));
      },
    );
  }
}
