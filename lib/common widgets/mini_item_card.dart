import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:products/common%20widgets/edit_product_screen.dart';
import 'package:products/common%20widgets/product_details.dart';
import 'package:products/common%20widgets/user.dart';
import '../bottom_navigation_bar.dart';
import '../const.dart';
import 'grocery_item.dart';
import 'package:products/styles/colors.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:http/http.dart' as http;

class MiniItemCard extends StatelessWidget {
  MiniItemCard({required Key key, required this.item}) : super(key: key);

  final GroceryItem item;
  static List<MiniItemCard> miniCards = [];
  final double height = 80;
  final Color borderColor = AppColors.greyBorderColor;
  final double borderRadius = 24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            //height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.4),
                  BlendMode.dstATop,
                ),
                image: const AssetImage(
                  "assets/images/banner_background.png",
                ),
                fit: BoxFit.none,
              ),
              border: Border.all(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(
                borderRadius,
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                child: Row(
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    editWidget(context, item.id),
                    const SizedBox(
                      width: 8,
                    ),
                    infoWidget(context, item.id),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget infoWidget(BuildContext context, double id) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.primaryColor),
      child: Center(
        child: IconButton(
          icon: const Icon(FontAwesome.info),
          color: Colors.white,
          iconSize: 25,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProductDetailsScreen(id: id);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget editWidget(BuildContext context, double id) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.orange.shade700),
        child: Center(
          child: IconButton(
            icon: const Icon(Icons.mode_edit),
            color: Colors.white,
            iconSize: 25,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return EditProduct(productId: id);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

late var response;
List<GroceryItem> miniItems = [];
Future getHttp() async {
  print("im in");
  if (!BottomNavBar.gotMiniResponse) {
    BottomNavBar.gotMiniResponse = false;
    try {
      String token = User.currentUser.token;
      response =
          await http.get(Uri.parse(baseUrl2 + "/users/my_products"), headers: {
        //'Content-Type': 'application/json',
        //'Accept': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      });
      print("im in response");
    } catch (e) {
      print(e);
    }
    var jsonData = jsonDecode(response.body);
    print("im in json");
    for (var g in jsonData) {
      GroceryItem i = GroceryItem(
          id: g['id'],
          name: g['name'],
          category: g['category'],
          price: g['unit_price'],
          imagePath:
              "assets/images/grocery_images/banana.png"); //////////////////TODO:change to g['image_id']
      miniItems.add(i);
      MiniItemCard.miniCards.add(MiniItemCard(key: UniqueKey(), item: i));
      print("im in done");
    }
  }
  return miniItems;
}
