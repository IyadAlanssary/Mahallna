import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:products/styles/blue_screen_of_death.dart';
import 'package:products/Models/const.dart';
import 'package:products/sign_up.dart';
import 'package:products/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Models/user.dart';
import 'styles/colors.dart';
import 'common widgets/app_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = " ";

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: AppColors.myDecoration(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                //mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset("assets/icons/app_icon_color.svg"),
                  const SizedBox(height: 80),
                  const Text(
                    'Log in',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    decoration: textfld('Phone', false),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    obscureText: _isObscure,
                    decoration: textfld('Password', true),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
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
                        'Don\'t have an account yet? ',
                        style: TextStyle(fontSize: 15),
                      ),
                      InkWell(
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 15,
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
                  const SizedBox(
                    height: 20,
                  )
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
      label: "Log in",
      onPressed: () {
        checkInputs();
        checkLogin();
      },
    );
  }

  late String phone, password;
  void checkInputs() {
    phone = phoneController.text;
    password = passwordController.text;
  }

  int hidden = 0;
  void blue() {
    if (hidden == 7) {
      hidden = 0;
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const BlueScreenOfDeath(),
          ));
    }
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
                blue();
                hidden++;
              });
            }),
      );
    }
    return const SizedBox(width: 1);
  }

  Future<void> checkLogin() async {
    var map = <String, dynamic>{};
    map['phone'] = phone;
    map['password'] = password;
    var postRequest =
        await http.post(Uri.parse(baseUrl2 + "/auth/login"), body: map);
    Map<String, dynamic> resp = jsonDecode(postRequest.body);
    print(postRequest.body);

    if (postRequest.statusCode <= 201) {
      User.currentUser = User(
        id: resp["user"]["id"],
        name: resp["user"]['name'],
        phone: resp["user"]['phone'],
        token: resp["token"],
        //imageId: resp["user"]["image_id"],//TODO
      );
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_register', true);
      await prefs.setString('token', resp["token"]);
      await prefs.setInt('id', resp["user"]["id"]);
      await prefs.setString('name', resp["user"]["name"]);
      await prefs.setString('phone', resp["user"]["phone"]);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const BottomNavBar(),
          ));
    } else if (postRequest.statusCode >= 400) {
      print("\n Response status code: ");
      print(postRequest.statusCode);
      if (resp["debug"]["message"] != null) {
        setState(() {
          errorMessage = resp["debug"]["message"];
        });
      }
    }
  }
}
