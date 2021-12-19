import 'package:flutter/material.dart';
//keyboardType: TextInputType.phone, in  text field
import 'log_in.dart';
import 'styles/colors.dart';
import 'common widgets/app_button.dart';

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
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextField(
                  textInputAction: TextInputAction.next, ///////////////////test
                  decoration: textfld('Full Name'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  textInputAction: TextInputAction.next,
                  decoration: textfld('Username'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  decoration: textfld('Password'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  decoration: textfld('Confirm Password'),
                ),
                const SizedBox(
                  height: 40,
                ),
                getButton(context),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
      label: "Sign Up",
      onPressed: () {
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //   builder: (BuildContext context) {
        //     return const DashboardScreen();
        //   },
        // ));
      },
    );
  }
}
