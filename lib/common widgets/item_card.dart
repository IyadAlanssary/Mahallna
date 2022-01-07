import 'package:flutter/material.dart';
import 'package:products/product_details.dart';
import '../Models/grocery_item.dart';
import 'package:products/styles/colors.dart';

class ItemCard extends StatelessWidget {
  ItemCard({required Key key, required this.item}) : super(key: key);

  final GroceryItem item;
  static List<ItemCard> cards = [];
  final double width = 174;
  final double height = 220;
  final Color borderColor = AppColors.greyBorderColor;
  final double borderRadius = 28;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Container(
          height: MediaQuery.of(context).size.height / 2.6,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(
                      item.imagePath,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  item.category,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkGrey,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      item.price.toString().substring(0, 4) +
                          " lira", //TODO attention here
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    productDetailsIcon(context, item.id),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget productDetailsIcon(BuildContext context, int id) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: AppColors.primaryColor),
      child: Center(
        child: IconButton(
          icon: const Icon(Icons.navigate_next),
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
