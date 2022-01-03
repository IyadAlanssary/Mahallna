import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:products/styles/colors.dart';
import 'package:products/view.dart';
import 'common widgets/user.dart';
import 'const.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String searchIcon = "assets/icons/search_icon.svg";
  String dropdownvalue = 'Item 1';
  var searchItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          // showSearch(
          //   context: context,
          //   delegate: CustomSearchDelegate(),
          // );
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

  Widget filters() {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.filter_list),
          tooltip: "Filters",
          onPressed: () {},
        ),
        body: DropdownButton(
            value: dropdownvalue,
            icon: const Icon(Icons.keyboard_arrow_down),

            // Array list of items
            items: searchItems.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
              });
            }));
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return AppColors.myTheme();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(
            Icons.clear,
          )),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  List<String> names = [];
  @override
  Widget buildResults(BuildContext context) {
    for (int i = 0; i < View.items.length; i++) {
      names.add(View.items.elementAt(i).name);
    }
    List<String> matchQuery = [];
    for (var n in names) {
      if (n.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(n);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var n in names) {
      if (n.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(n);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  late var response;
  //static List<GroceryItem> items = [];
  Future getHttp() async {
    print("im in");
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
    // for (var g in jsonData) {
    //   GroceryItem i = GroceryItem(
    //       id: g['id'],
    //       name: g['name'],
    //       category: g['category'],
    //       price: g['current_price'],
    //       imagePath:
    //       "assets/images/apple.png"); //////////////////TODO:change to g['image_id']
    //   items.add(i);
    //   ItemCard.cards.add(ItemCard(key: UniqueKey(), item: i));
    //   print("found one");
    // }
  }
  //return items;
}
