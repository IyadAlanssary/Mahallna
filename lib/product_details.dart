import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:products/Models/user.dart';
import 'package:products/styles/colors.dart';
import 'package:products/common widgets/get_image_header_widget.dart';
import 'package:products/home.dart';
import 'package:products/Models/const.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductDetailsScreen extends StatefulWidget {
  int id;
  ProductDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

bool isLike = false;

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<dynamic>(
        future: getHttp(widget.id),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(
              decoration: AppColors.myDecoration(),
              child: const SpinKitSpinningLines(
                itemCount: 8,
                color: AppColors.primaryColor,
                size: 100.0,
              ),
            );
          } else {
            return Container(
              decoration: AppColors.myDecoration(),
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop(MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const Home();
                              },
                            ));
                          },
                          icon: const Icon(Icons.arrow_back),
                          color: AppColors.primaryColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Text(
                                '${product.viewsCount}',
                                style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(
                                Icons.remove_red_eye,
                                color: AppColors.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          getImageHeaderWidget(
                            url: 'assets/images/apple.png',
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Column(
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    product.name,
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isLike = !isLike;
                                      });
                                    },
                                    icon: getLikeIcon(isLike),
                                    color: Colors.red,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '\$${product.unitPrice}',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                getProductDataRowWidget('Expiration date:',
                                    '${product.expiryDate}'),
                                const Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                                getProductDataRowWidget(
                                    'Category:', product.category),
                                const Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                                getProductDataRowWidget(
                                    'Contact:', product.contactPhone),
                                const Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                                getProductDataRowWidget('Quantity:',
                                    '${product.availableQuantity}'),
                                const SizedBox(
                                  height: 40,
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: const Text(
                                    'Comments',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.comment),
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                commentItem('hamsho', 'pullshit'),
                                commentItem('hamsho', 'pullshit'),
                                commentItem('hamsho', 'pullshit'),
                                commentItem('hamsho', 'pullshit'),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  late Product product;
  Future getHttp(int id) async {
    try {
      String token = User.currentUser.token;
      print("in details");
      print(id);
      var response =
          await http.get(Uri.parse(baseUrl2 + "/products/$id"), headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      });
      var jsonData = jsonDecode(response.body);
      print(jsonData["id"]);
      //print(jsonData["sales_plan"]["initial_sale"]);
      // SalesPlan salesPlan = SalesPlan(
      //   initialSale: jsonData["sales_plan"]["initial_sale"],
      //   firstPeriodDays: jsonData["sales_plan"]["first_period_days"],
      //   firstPeriodSale: jsonData["sales_plan"]["first_period_sale"],
      //   secondPeriodDays: jsonData["sales_plan"]["second_period_days"],
      //   secondPeriodSale: jsonData["sales_plan"]["second_period_sale"],
      // );
      Product p = Product(
        id: jsonData['id'],
        imageId: jsonData['image_id'],
        name: jsonData['name'],
        category: jsonData['category'],
        availableQuantity: jsonData['available_quantity'],
        liked: jsonData['liked'],
        expiryDate: jsonData['expiry_date'],
        unitPrice: jsonData['unit_price'].toString(),
        viewsCount: jsonData['views_count'].toString(),
        contactPhone: jsonData['contact_phone'],
      );

      product = p;
    } catch (e) {
      print("caught error");
      print(e);
    }
    return product;
  }
}

Icon getLikeIcon(bool isLike) {
  if (isLike) {
    return const Icon(Icons.favorite);
  } else {
    return const Icon(Icons.favorite_border);
  }
}

Widget getProductDataRowWidget(String label, String data) {
  return Container(
    margin: const EdgeInsets.only(
      top: 20,
      bottom: 20,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              data,
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget commentItem(String name, String comment) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Column(
      children: [
        Row(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 20,
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
            Row(
              children: <Widget>[
                Text(name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(comment),
                ),
              ],
            )
          ],
        ),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        ),
      ],
    ),
  );
}

class Product {
  late int id;
  late int imageId;
  late String name;
  late String category;
  late int availableQuantity;
  late bool liked;
  late int expiryDate;
  late String unitPrice;
  late String viewsCount;
  late String contactPhone;

  Product(
      {required this.id,
      required this.imageId,
      required this.name,
      required this.category,
      required this.availableQuantity,
      required this.liked,
      required this.expiryDate,
      required this.unitPrice,
      required this.viewsCount,
      required this.contactPhone});
}

// class SalesPlan {
//   SalesPlan({
//     required this.initialSale,
//     required this.firstPeriodDays,
//     required this.firstPeriodSale,
//     required this.secondPeriodDays,
//     required this.secondPeriodSale,
//   });
//
//   int initialSale;
//   int firstPeriodDays;
//   int firstPeriodSale;
//   int secondPeriodDays;
//   int secondPeriodSale;
// }
