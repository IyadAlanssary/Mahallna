import 'dart:convert';

import 'package:flutter/material.dart';

class getImageHeaderWidget extends StatefulWidget {
  String image;
  getImageHeaderWidget({Key? key, required this.image}) : super(key: key);

  @override
  _getImageHeaderWidgetState createState() => _getImageHeaderWidgetState();
}

class _getImageHeaderWidgetState extends State<getImageHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  alignment: Alignment.center,
                  image: Image.memory(base64Decode(widget.image)).image,
                  fit: BoxFit.contain,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(15))
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
