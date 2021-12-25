import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:products/common%20widgets/grocery_item.dart';
import 'package:products/search.dart';
import 'styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'common widgets/item_card.dart';

class View extends StatefulWidget {
  View({Key? key}) : super(key: key);

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      body: Container(
        decoration: AppColors.myDecoration(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 10),
                child: SvgPicture.asset("assets/icons/app_icon_color.svg"),
              ),
              const Search(),
              Expanded(
                child: FutureBuilder<dynamic>(
                  future: getHttp(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const SpinKitSpinningLines(
                        itemCount: 8,
                        color: AppColors.primaryColor,
                        size: 100.0,
                      );
                    } else {
                      // return ListView.builder(
                      //    itemCount: snapshot.data.length,
                      //   itemBuilder: (context, i) {
                      return GridView.count(
                        childAspectRatio: 1.25,
                        crossAxisCount: 1,
                        semanticChildCount: snapshot.data.length,
                        children: ItemCard.cards,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  dynamic response;
  List<GroceryItem> items = [];
  Future getHttp() async {
    try {
      response = await http.get(Uri.https(
          "74bbdce5-c395-497b-9acf-3f4bbf4b7604.mock.pstmn.io",
          "api/products"));
      var jsonData = jsonDecode(response.body);
      for (var g in jsonData) {
        GroceryItem i = GroceryItem(
            id: g['id'],
            name: g['name'],
            description: g['description'],
            price: 1.999,
            imagePath: "assets/images/grocery_images/banana.png");
        items.add(i);
        ItemCard.cards.add(ItemCard(key: UniqueKey(), item: i));
      }
      //response = await dio.get('/test', queryParameters: {'id': 12, 'name': 'wendu'});
      // print(response.data.toString());
    } catch (e) {
      print("catched error");
      print(e);
    }
    return items;
  }
}
/*
    print("test");

      print(response);
      print("test2");
      print(response.data[0]['id']);
      print("response headers: ");
      print(response.headers);
      print("status code: ");
      print(response.statusCode);


 */
