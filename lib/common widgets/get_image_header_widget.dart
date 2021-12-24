import 'package:flutter/material.dart';

class getImageHeaderWidget extends StatefulWidget {
  String url;
  getImageHeaderWidget({Key? key, required this.url}) : super(key: key);

  @override
  _getImageHeaderWidgetState createState() => _getImageHeaderWidgetState();
}

class _getImageHeaderWidgetState extends State<getImageHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(

              boxShadow:[BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0,7),  //changes position of shadow
              )],
              color: Colors.white,
              image: DecorationImage(
                alignment: Alignment.center,

                image: AssetImage(widget.url),
                fit: BoxFit.cover,

              ),
              borderRadius: const BorderRadius.all(Radius.circular(15))
          ),
        ),
        const SizedBox(height: 20),

      ],
    );
  }
}

// Container(
// child: Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: const [
// Center(
// child: Image(
// image: AssetImage('images/kitkat.jpg'),
// height: 200,
// width: 300,
// ),
// ),
// ],
// ),
// decoration: const BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.only(
// bottomLeft: Radius.circular(25),
// topLeft: Radius.circular(25),
// bottomRight: Radius.circular(25),
// topRight: Radius.circular(25),
// ),
// gradient: LinearGradient(
// colors: [
// Colors.white,
// Colors.white,
// ],
// begin: FractionalOffset(0.0, 0.0),
// end: FractionalOffset(0.0, 1.0),
// stops: [0.0, 1.0],
// tileMode: TileMode.clamp),
// ),
// );