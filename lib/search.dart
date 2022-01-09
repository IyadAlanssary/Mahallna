import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:products/home.dart';
import 'package:search_page/search_page.dart';
import 'Models/grocery_item.dart';
import 'product_details.dart';
import 'styles/colors.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String searchIcon = "assets/icons/search_icon.svg";
  List<GroceryItem> searchItems = Home.items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width - 100,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          searchFilter();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              searchIcon,
            ),
            const SizedBox(
              width: 12,
            ),
            const Text(
              "Search Store",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7C7C7C)),
            ),
          ],
        ),
      ),
    );
  }

  void searchFilter() {
    showSearch(
      context: context,
      delegate: SearchPage<GroceryItem>(
        items: searchItems,
        searchLabel: "Search",
        itemStartsWith: true,
        searchStyle: const TextStyle(
          color: Colors.white,
        ),
        showItemsOnEmpty: true,
        barTheme: ThemeData(
          textTheme: ThemeData.light().textTheme.apply(
                fontFamily: "SourceSans3",
                bodyColor: Colors.white,
              ),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.white,
            selectionHandleColor: Colors.white,
            selectionColor: Colors.teal.shade200,
          ),
          appBarTheme: AppBarTheme(
            elevation: 30,
            color: AppColors.primaryColor.withOpacity(0.8),
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.teal.shade100,
          ),
        ),
        suggestion: const Center(
          child: Text('Filter search by name, category or expiry date'),
        ),
        failure: const Center(
          child: Text('No Grocery Items found :('),
        ),
        filter: (groceryItem) => [
          groceryItem.name,
          groceryItem.category,
          groceryItem.expiryDate.toString(),
        ],
        builder: (groceryItem) => ListTile(
          title: Text(groceryItem.name),
          subtitle: Text(groceryItem.category),
          trailing: Text(
              groceryItem.expiryDate.toString()), //'${groceryItem.price} Lira'
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProductDetailsScreen(id: groceryItem.id);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
