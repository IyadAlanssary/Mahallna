import 'dart:convert';
import 'package:products/const.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_navigation_bar.dart';
import 'common widgets/user.dart';
import 'log_in.dart';
import 'styles/colors.dart';
import 'common widgets/app_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String errorMessage = " ";
  bool _isObscure = true;
  TextEditingController phoneController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppColors.myDecoration(),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset("assets/icons/app_icon_color.svg"),
                  const SizedBox(height: 35),
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
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    decoration: textfld('Phone', false),
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
                  const SizedBox(height: 8),
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
        if (checkInputs()) {
          signUp();
        }
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

  late String fullName, phone, password, confirmPassword;
  bool checkInputs() {
    fullName = fullNameController.text;
    phone = phoneController.text;
    password = passwordController.text;
    confirmPassword = confirmPasswordController.text;
    if (password != confirmPassword) {
      setState(() {
        errorMessage = "Password and Confirm Password must match";
      });
      return false;
    }
    return true;
  }

  late var response;
  Future<void> signUp() async {
    var map = <String, dynamic>{};
    map['name'] = fullName;
    map['phone'] = phone;
    map['password'] = password;
    response =
        await http.post(Uri.parse(baseUrl2 + "/auth/register"), body: map);
    Map<String, dynamic> resp = jsonDecode(response.body);
    if (response.statusCode <= 201) {
      User.currentUser = User(
        id: resp["user"]['id'],
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
        MaterialPageRoute(builder: (_) => const BottomNavBar()),
      );
    } else if (response.statusCode >= 400) {
      print("\n Response status code: ");
      print(response.statusCode);
      if (resp["debug"]["message"] != null) {
        setState(() {
          errorMessage = resp["debug"]["message"];
        });
      }
    }
  }
}
