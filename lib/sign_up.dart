import 'package:flutter/material.dart';
import 'log_in.dart';
import 'styles/colors.dart';
import 'common widgets/app_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isObscure = true;
  TextEditingController userNameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppColors.myDecoration(),
        height: double.maxFinite,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50, 70, 50, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 1, //31
                  ),
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: fullNameController,
                    textInputAction: TextInputAction.next,
                    decoration: textfld('Full Name', false),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: userNameController,
                    textInputAction: TextInputAction.next,
                    decoration: textfld('Username', false),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: passwordController,
                    textInputAction: TextInputAction.next,
                    obscureText: _isObscure,
                    decoration: textfld('Password', true),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: confirmPasswordController,
                    textInputAction: TextInputAction.done,
                    obscureText: _isObscure,
                    decoration: textfld('Confirm Password', true),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  getButton(context),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(fontSize: 15),
                      ),
                      InkWell(
                          child: const Text(
                            'Log in',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LogIn()),
                            );
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration textfld(String text, bool eye) {
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
      suffixIcon: eyeButton(eye),
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

  SizedBox eyeButton(bool eye) {
    if (eye) {
      return SizedBox(
        child: IconButton(
            splashColor: AppColors.primaryColor,
            color: AppColors.primaryColor,
            iconSize: 20,
            icon: Icon(!_isObscure ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            }),
      );
    }
    return const SizedBox(width: 1);
  }
}
