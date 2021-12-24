import 'package:flutter/material.dart';
import 'package:products/common%20widgets/grocery_item.dart';
import 'package:products/search.dart';
import 'styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'common widgets/item_card.dart';

class View extends StatelessWidget {
  const View({Key? key}) : super(key: key);

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
                  childAspectRatio: 1.25,
                  children: <Widget>[
                    ItemCard(
                      item: GroceryItem.item,
                      key: UniqueKey(), //UniqueKey(),
                    ),
                    ItemCard(
                      item: GroceryItem.item2,
                      key: UniqueKey(), //UniqueKey(),
                    ),
                    ItemCard(
                      item: GroceryItem.item6,
                      key: UniqueKey(), //UniqueKey(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
