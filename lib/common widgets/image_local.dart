import 'dart:io';
import 'package:flutter/material.dart';

class ImageLocal extends StatelessWidget {
  final File _image;
  const ImageLocal(this._image);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            /*border: Border.all(color: darkSecondaryColor,width: 3),*/
              color: Colors.grey,
              image: DecorationImage(
                alignment: Alignment.center,
                image: FileImage(_image),
                //image: AssetImage('assets/images/Kitkat_product.png'),
                fit: BoxFit.cover,

              ),
              borderRadius: const BorderRadius.all(Radius.circular(15))
          ),
        ),
        const SizedBox(height: 20),
        /*Image.network(url,),*/
      ],
    );
  }
}