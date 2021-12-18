import 'package:flutter/material.dart';
import 'styles/colors.dart';
import 'package:products/search.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewLess extends StatelessWidget {
  const ViewLess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset("assets/icons/app_icon_color.svg"),
                ),
                const Search(),
                const Expanded(
                  child: ViewFul(),
                ),
              ]),
        ),
      ),
    );
  }
}

class ViewFul extends StatefulWidget {
  const ViewFul({Key? key}) : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<ViewFul> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppColors.myTheme(),
      home: GridView.count(
        crossAxisCount: 2,
        //children: const <Widget>[
        children: List.generate(40, (index) {
          return Card(
            child: Image.network("https://robohash.org/$index"),
          ); //robohash.org api provide you different images for any number you are giving
        }),
        // FlutterLogo(),
        // FlutterLogo(),
        // FlutterLogo(),
        // FlutterLogo(),
        // FlutterLogo(),
        // FlutterLogo(),
        // FlutterLogo(),
        // FlutterLogo(),
        // FlutterLogo(),
        // FlutterLogo(),
        // FlutterLogo(),
        // FlutterLogo(),
        //],
      ),
    );
  }
}
