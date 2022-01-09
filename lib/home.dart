import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:products/Models/grocery_item.dart';
import 'package:products/search.dart';
import 'Models/user.dart';
import 'styles/blue_screen_of_death.dart';
import 'styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'common widgets/item_card.dart';
import 'package:products/bottom_navigation_bar.dart';
import 'package:products/Models/const.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static List<GroceryItem> items = [];

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late bool loadingTimeFinished = false;
  int hidden = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 35, bottom: 10),
          child: InkWell(
              onTap: reloadHome,
              child: SvgPicture.asset("assets/icons/app_icon_color.svg")),
        ),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 25, right: 10, bottom: 5.0),
              child: Search(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: IconButton(
                  icon: const Icon(Icons.sort),
                  tooltip: "Sort",
                  iconSize: 28,
                  onPressed: () {
                    setState(() {
                      blue();
                    });
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return dropDownSort();
                        });
                  },
                ),
              ),
            )
          ],
        ),
        Expanded(
          child: FutureBuilder<dynamic>(
              future: getAllProductsHttp(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  Timer(
                      const Duration(seconds: 4),
                      () => {
                            setState(() {
                              loadingTimeFinished = true;
                            })
                          });
                  if (!loadingTimeFinished) {
                    return const SpinKitSpinningLines(
                      itemCount: 8,
                      color: AppColors.primaryColor,
                      size: 100.0,
                    );
                  } else {
                    return const Text("No Products Available");
                  }
                } else {
                  return GridView.count(
                    physics: const AlwaysScrollableScrollPhysics(),
                    crossAxisCount: 1,
                    childAspectRatio: 174 / (230 / 1.75),
                    children: ItemCard.cards, //, ItemCard.cards
                  );
                }
              }),
        ),
      ],
    );
  }

  void blue() {
    hidden++;
    if (hidden == 7) {
      hidden = 0;
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const BlueScreenOfDeath(),
          ));
    }
  }

  Widget dropDownSort() {
    return AlertDialog(
      title: const Text('Sort by'),
      elevation: 50,
      content: Row(
        children: [
          DropdownButton(
            iconEnabledColor: Colors.teal,
            iconSize: 20,
            hint: const Text('Choose'),
            menuMaxHeight: 200,
            dropdownColor: Colors.teal.shade100,
            icon: const Icon(Icons.keyboard_arrow_down),
            onChanged: (String? newValue) {
              setState(() {
                BottomNavBar.sortValue = newValue!;
                reloadHome();
              });
            },
            items: BottomNavBar.sortChoices.map((String items) {
              return DropdownMenuItem<String>(
                value: items,
                child: Text(items),
              );
            }).toList(),
            value: BottomNavBar.sortValue,
          ),
          const Spacer(),
          DropdownButton(
            iconEnabledColor: Colors.teal,
            iconSize: 20,
            menuMaxHeight: 200,
            dropdownColor: Colors.teal.shade100,
            value: BottomNavBar.directionValue,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: BottomNavBar.directionChoices.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                BottomNavBar.directionValue = newValue!;
                reloadHome();
              });
            },
          ),
        ],
      ),
    );
  }

  void reloadHome() {
    BottomNavBar.gotResponse = false;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const BottomNavBar()));
  }

  Future getAllProductsHttp() async {
    String sort = BottomNavBar.sortValue;
    String dir = BottomNavBar.directionValue;
    if (!BottomNavBar.gotResponse) {
      BottomNavBar.gotResponse = true;
      try {
        late http.Response response;
        String token = User.currentUser.token;
        response = await http.get(
            Uri.parse(baseUrl2 + "/products?sort_by=$sort&sort_dir=$dir"),
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
            });
        var jsonData = jsonDecode(response.body);
        Home.items.clear();
        ItemCard.cards.clear();
        for (var g in jsonData) {
          var res = await http
              .get(Uri.parse(baseUrl2 + "/images/${g['image_id']}"), headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          });
          GroceryItem i = GroceryItem(
              id: g['id'],
              name: g['name'],
              imageBytes: res.bodyBytes,
              category: g['category'],
              price: g['current_price'].toString(),
              expiryDate: DateFormat('yyyy-MM-dd').format(
                  DateTime.fromMillisecondsSinceEpoch(g['expiry_date'])),
              imagePath: "$baseUrl2/images/${g['image_id']}");
          Home.items.add(i);
          ItemCard.cards.add(ItemCard(key: UniqueKey(), item: i));
        }
      } catch (e) {
        print("get products error $e");
      }
    }
    if (Home.items.isNotEmpty) {
      return Home.items;
    }
    return null;
  }
}
//TODO flutter build apk --split-per-abi
