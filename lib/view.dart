import 'package:flutter/material.dart';
import 'package:products/common%20widgets/grocery_item.dart';
import 'package:products/search.dart';
import 'styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'common widgets/item_card.dart';

class View extends StatelessWidget {
  View({Key? key}) : super(key: key);
  final GroceryItem item = GroceryItem(
      name: "Organic Bananas",
      description: "7 pieces",
      price: 4.99,
      imagePath: "assets/images/grocery_images/banana.png");

  final GroceryItem item2 = GroceryItem(
      name: "Red Apple",
      description: "1kg, Price",
      price: 4.99,
      imagePath: "assets/images/grocery_images/apple.png");
  final GroceryItem item3 = GroceryItem(
      name: "Bell Pepper Red",
      description: "1kg, Price",
      price: 4.99,
      imagePath: "assets/images/grocery_images/pepper.png");

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
                  child: GridView.count(
                    crossAxisCount: 1,
                    //mainAxisSpacing: 0,
                    //crossAxisSpacing: 5,
                    childAspectRatio:
                        1.25, /////test/////////////////////////////////////
                    children: <Widget>[
                      //children: List.generate(40, (index) {
                      ItemCard(
                        item: item,
                        key: UniqueKey(), //UniqueKey(),
                      ),
                      ItemCard(
                        item: item2,
                        key: UniqueKey(), //UniqueKey(),
                      ),
                      ItemCard(
                        item: item3,
                        key: UniqueKey(), //UniqueKey(),
                      ),
                    ],
                    //   return Card(
                    //    child: Image.network("https://robohash.org/$index"),
                    // ); //robohash.org api provide you different images for any number you are giving
                    // ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
