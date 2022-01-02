import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:products/common%20widgets/grocery_item.dart';
import 'package:products/search.dart';
import 'styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'common widgets/item_card.dart';
import 'package:products/bottom_navigation_bar.dart';
import 'package:products/const.dart';
import 'package:dio/dio.dart';

class View extends StatefulWidget {
  View({Key? key}) : super(key: key);

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 35, bottom: 10),
          child: SvgPicture.asset("assets/icons/app_icon_color.svg"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
          child: Search(),
        ),
        Expanded(
          child: FutureBuilder<dynamic>(
              future: getHttp(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const SpinKitSpinningLines(
                    itemCount: 30,
                    color: AppColors.primaryColor,
                    size: 100.0,
                  );
                } else {
                  return GridView.count(
                    crossAxisCount: 1,
                    childAspectRatio: 174 / (230 / 1.8),
                    children: ItemCard.cards, //, ItemCard.cards
                  );
                }
              }),
        ),
      ],
    );
  }

  late var response;
  static List<GroceryItem> items = [];
  Future getHttp() async {
    print("im in");
    if (!BottomNavBar.gotResponse) {
      BottomNavBar.gotResponse = true;
      try {
        print("\n1\n");
        response = await http.get(Uri.parse(baseUrl2 + "/products"), headers: {
          //'Content-Type': 'application/json',
          //'Accept': 'application/json',
          HttpHeaders.authorizationHeader:
              'Bearer 4|OBzB0AF3ePGH2bWifEPngKuOeFqgc16lWQqkMuak',
        });
      } catch (e) {
        print(e);
      }
      var jsonData = jsonDecode(response.body);
      for (var g in jsonData) {
        GroceryItem i = GroceryItem(
            id: g['id'],
            name: g['name'],
            category: g['category'],
            price: g['current_price'],
            imagePath:
                "assets/images/grocery_images/banana.png"); //////////////////TODO:change to g['image_id']
        items.add(i);
        ItemCard.cards.add(ItemCard(key: UniqueKey(), item: i));
        print("found one");
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
/*
Failed Attempt No.1
try {
        Dio dio = Dio();
        print("im in dio");
        //dio.options.headers['content-Type'] = 'application/json';
        print("im in header");
        response = await dio.get(
          baseUrl2 + '/products',
          options: Options(
            headers: {
              "Authorization":
                  "Bearer 4|OBzB0AF3ePGH2bWifEPngKuOeFqgc16lWQqkMuak",
            },
          ),
        );
        print(response.data);
      } catch (e) {
        print("\n\n\n wwwww");
        print(e);
        print("\n\n\nwwwwwww");
      }
 */
/*
/*
        final Map parsed = json.decode(response.body);
        print("\n\n\nooooooooooooooooooooooooooooo");
        print(parsed);

        final groc = GroceryItem.fromJson(parsed);
        print("\n\n\nwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
        print(groc);
        print("NEW");
         */
         //jsonData = jsonData "[" + response.body + "]";
      //jsonData = json.encode(jsonData);
      //Map jsonData = jsonDecode(response.body);
      //print(jsonData);
      //////////////////////////
        list = (jsonData as List)
            .map((data) => GroceryItem.fromJson(data))
            .toList();
      //////////////////
      //for(GroceryItem gg in groceryItemFromJson(String str)){

        // }
        // final List parsedList = json.decode(response.body);
        // list = parsedList.map((val) => GroceryItem.fromJson(val)).toList();
        //////////////

 */

}
