import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:products/common%20widgets/grocery_item.dart';
import 'package:products/search.dart';
import 'common widgets/user.dart';
import 'styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'common widgets/item_card.dart';
import 'package:products/bottom_navigation_bar.dart';
import 'package:products/const.dart';

class View extends StatefulWidget {
  const View({Key? key}) : super(key: key);

  static List<GroceryItem> items = [];

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {
  late bool loadingTimeFinished = false;

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
                  Timer(
                      const Duration(seconds: 5),
                      () => {
                            setState(() {
                              loadingTimeFinished = true;
                            })
                          });
                  if (!loadingTimeFinished) {
                    return const SpinKitSpinningLines(
                      itemCount: 30,
                      color: AppColors.primaryColor,
                      size: 100.0,
                    );
                  } else {
                    return const Text("No Products Available");
                  }
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

  Future getHttp() async {
    print("im in");
    if (!BottomNavBar.gotResponse) {
      BottomNavBar.gotResponse = true;
      try {
        String token = User.currentUser.token;
        print("\n1\n");
        response = await http.get(Uri.parse(baseUrl2 + "/products"), headers: {
          //'Content-Type': 'application/json',
          //'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
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
                "assets/images/apple.png"); //////////////////TODO:change to g['image_id']
        View.items.add(i);
        ItemCard.cards.add(ItemCard(key: UniqueKey(), item: i));
        print("found one");
      }
    }
    return View.items;
  }
}
