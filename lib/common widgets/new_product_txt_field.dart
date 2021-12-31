import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:products/styles/colors.dart';

class ProductText extends StatelessWidget {
  ValueChanged<String?> onChanged;
  late String hint;
  int? maxLines;
  TextInputType? type = TextInputType.name;
  Icon? icon;
  int? maxLength;
  bool initial = false;
  String? initialText;
  ProductText(
      {Key? key,
      required this.hint,
      required this.onChanged,
      this.maxLines,
      this.type,
      this.icon,
      this.maxLength,
      this.initial = false,
      this.initialText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: AppColors.primaryColor,
              ),
        ),
        child: TextField(
          controller: initial
              ? TextEditingController(text: initialText)
              : TextEditingController(),
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp('[-.,]')),
          ],
          maxLines: maxLines,
          maxLength: maxLength,
          keyboardType: type,
          onChanged: (value) {
            onChanged(value);
            // value entered by user
          },
          decoration: InputDecoration(
            focusColor: AppColors.primaryColor,
            prefixIcon: icon,
            fillColor: Colors.transparent,
            filled: true,
            hintText: hint,
            hintStyle: const TextStyle(
                color: AppColors.darkGrey, fontWeight: FontWeight.bold),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
