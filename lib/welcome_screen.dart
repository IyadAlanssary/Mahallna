import 'package:flutter/material.dart';
//import 'package:flutter/painting.dart';
import 'common widgets/app_button.dart';
import 'styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'log_in.dart';

class WelcomeScreen extends StatelessWidget {
  final String imagePath = "assets/images/welcome_image.png";
  final String iconPath = "assets/icons/app_icon.svg";

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Spacer(),
                SvgPicture.asset(
                  iconPath,
                  width: 48,
                  height: 56,
                ),
                const SizedBox(
                  height: 10,
                ),
                welcomeTextWidget(),
                sloganText(),
                const SizedBox(
                  height: 20,
                ),
                getButton(context),
                const SizedBox(
                  height: 25,
                )
              ],
            ),
          ),
        ));
  }

  Widget welcomeTextWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          "Welcome",
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        Text(
          "to our store",
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget sloganText() {
    return Text(
      "Get your groceries as fast as in hour",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: const Color(0xffFCFCFC).withOpacity(0.7),
      ),
    );
  }

  Widget getButton(BuildContext context) {
    return AppButton(
        label: "Get Started",
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const LogIn();
              },
            ),
          );
        });
  }
}
