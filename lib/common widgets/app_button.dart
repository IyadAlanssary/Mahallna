import 'package:flutter/material.dart';
import 'package:products/styles/colors.dart';

class AppButton extends StatelessWidget {
  final String label;
  final double roundness;
  final FontWeight fontWeight;
  //late Widget trailingWidget;
  final Function onPressed;

  const AppButton({
    Key? key,
    required this.label,
    this.roundness = 18,
    this.fontWeight = FontWeight.bold,
    //this.trailingWidget,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // was Container
      width: double.maxFinite,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: AppColors.primaryColor,
          elevation: 0.0,
          padding: const EdgeInsets.symmetric(vertical: 24),
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(roundness)),
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold, ////////////
          ),
        ),
        //   backgroundColor:
        //       MaterialStateProperty.all<Color>(AppColors.primaryColor),
        child: Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            Center(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: fontWeight,
                ),
              ),
            ),
            // if (trailingWidget != null)
            //   Positioned(
            //     top: 0,
            //     right: 25,
            //     child: trailingWidget,
            //   )
          ],
        ),
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          }
        },
      ),
    );
  }
}
