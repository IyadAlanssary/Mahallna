import 'package:flutter/material.dart';
import 'package:products/sign_up.dart';
import 'package:products/bottom_navigation_bar.dart';
import 'styles/colors.dart';
import 'common widgets/app_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                mainAxisSize: MainAxisSize.max,
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
                    controller: userNameController,
                    textInputAction: TextInputAction.next,
                    decoration: textfld('Username', false),
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
                    height: 60,
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const BottomNavBar()),
        );
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
  } /*
  Future<void> checkLogin() async {
    var map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    final response = await http.post(Uri.parse(Assets.link + "login"),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Accept": "application/json"
        },
        encoding: Encoding.getByName('utf-8'),
        body: map);
    Map<String, dynamic> resp = jsonDecode(response.body);
    if (response.statusCode == 201) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => MainPage(
                  token: resp["token"].toString(),
                  id: resp["user"]["id"].toString())));
    } else if (response.statusCode == 422) {
      if (resp["errors"]["email"] != null) {
        setState(() {
          emailShadowColor = Assets.errorShadowColor;
          error = resp["errors"]["email"].toString();
        });
      }
      if (resp["errors"]["password"] != null) {
        setState(() {
          passwordShadowColor = Assets.errorShadowColor;
          error = resp["errors"]["password"].toString();
        });
      }
    }
    print(response.body);
  }
  */
}
