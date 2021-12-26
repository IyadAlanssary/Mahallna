import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:products/common%20widgets/product_details.dart';
import 'grocery_item.dart';
import 'package:products/styles/colors.dart';
import 'package:http/http.dart' as http;

class MiniItemCard extends StatelessWidget {
  MiniItemCard({required Key key, required this.item}) : super(key: key);

  final GroceryItem item;
  static List<MiniItemCard> miniCards = [];
  final double height = 80;
  final Color borderColor = AppColors.greyBorderColor;
  final double borderRadius = 28;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                Spacer(),
                  addWidget(context, item.id),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }

  Widget addWidget(BuildContext context,int id) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: AppColors.primaryColor),
      child: Center(
        child: IconButton(
          icon: const Icon(Icons.add),
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
}

dynamic response;
bool gotResponse = false;
List<GroceryItem> items = [];
Future getHttp() async {
  if (!gotResponse) {
    gotResponse = true;
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
            price: 1.99,
            imagePath: "assets/images/grocery_images/banana.png");
        items.add(i);
        MiniItemCard.miniCards.add(MiniItemCard(key: UniqueKey(), item: i));
      }
      //response = await dio.get('/test', queryParameters: {'id': 12, 'name': 'wendu'});
      // print(response.data.toString());
    } catch (e) {
      print("catched error");
      print(e);
    }
  }
  return items;
}

