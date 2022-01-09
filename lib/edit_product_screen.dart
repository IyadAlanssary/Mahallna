import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:products/styles/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:products/common widgets/image_local.dart';
import 'package:products/common widgets/new_product_txt_field.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'Models/const.dart';
import 'Models/user.dart';
import 'home.dart';

class EditProduct extends StatefulWidget {
  int productId;
  EditProduct({Key? key, required this.productId}) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
  static const String id = 'edit_product_screen';
}

class _EditProductState extends State<EditProduct> {
  late String? name;
  late String? phone;
  late String? quantity;
  late String? originalPrice;
  late String? category;
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<dynamic>(
        future: getHttp(widget.productId),
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
              height: double.maxFinite,
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
                                return Home();
                              },
                            ));
                          },
                          icon: const Icon(Icons.arrow_back),
                          color: AppColors.primaryColor,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  postProduct();
                                });
                              },
                              icon: const Icon(Icons.check),
                              color: AppColors.primaryColor,
                            )),
                      ],
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 15, 10, 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      //name
                                      ProductText(
                                        initial: true,
                                        initialText: product.name,
                                        hint: 'Name',
                                        maxLines: 1,
                                        icon: const Icon(
                                            Icons.drive_file_rename_outline),
                                        onChanged: (value) {
                                          name = value;
                                        },
                                      ),
                                      ProductText(
                                        initial: true,
                                        initialText: product.contactPhone,
                                        hint: 'Phone',
                                        icon: const Icon(Icons.phone),
                                        type: TextInputType.phone,
                                        onChanged: (value) {
                                          phone = value;
                                        },
                                      ),
                                      // original price
                                      ProductText(
                                        initial: true,
                                        initialText: product.unitPrice,
                                        hint: 'Original Price',
                                        icon: const Icon(
                                            FontAwesomeIcons.dollarSign),
                                        type: TextInputType.phone,
                                        onChanged: (value) {
                                          originalPrice = value;
                                        },
                                      ),
                                      ProductText(
                                        initial: true,
                                        hint: 'Category',
                                        initialText: product.category,
                                        icon: const Icon(Icons.view_list),
                                        type: TextInputType.multiline,
                                        onChanged: (value) {
                                          category = value;
                                        },
                                      ),
                                      ProductText(
                                        initial: true,
                                        initialText:
                                            '${product.availableQuantity}',
                                        hint: 'Quantity',
                                        icon:
                                            const Icon(Icons.workspaces_filled),
                                        type: TextInputType.number,
                                        onChanged: (value) {
                                          quantity = value;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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

  dynamic response;
  late Product product;
  Future getHttp(int id) async {
    try {
      String token = User.currentUser.token;
      print("in edit");
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
        availableQuantity: jsonData['available_quantity'].toString(),
        liked: jsonData['liked'],
        expiryDate: jsonData['expiry_date'],
        unitPrice: jsonData['unit_price'].toString(),
        viewsCount: jsonData['views_count'].toString(),
        contactPhone: jsonData['contact_phone'],
          initialSale: jsonData["initial_sale"].toString(),
          firstPeriodDays: jsonData["first_period_days"].toString(),
          firstPeriodSale: jsonData["first_period_sale"].toString(),
          secondPeriodDays: jsonData["second_period_days"].toString(),
          secondPeriodSale: jsonData["second_period_sale"].toString(),
      );
      print('hiosaifojoa, ' + p.category);

      name = p.name;
      phone = p.contactPhone;
      originalPrice = p.unitPrice;
      category = p.category;
      quantity = p.availableQuantity;

      product = p;
    } catch (e) {
      print("caught error");
      print(e);
    }
    return product;
  }
  Future postProduct() async {
    String token = User.currentUser.token;
    var response =
    await http.get(Uri.parse(baseUrl2 + "/images/${product.imageId}"), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });

    Map<String,dynamic> prod = {
      "image": response.body,
      "details": {
        "name": name ?? product.name,
        "description": "The type you like the most.",
        "category": category ?? product.category,
        "available_quantity": quantity ?? product.availableQuantity,
        "expiry_date": product.expiryDate,
        "unit_price": originalPrice ?? product.unitPrice,
        "contact_phone": phone ?? product.contactPhone,
        "initial_sale": product.initialSale,
        "first_period_days": product.firstPeriodDays,
        "first_period_sale": product.firstPeriodSale,
        "second_period_days": product.secondPeriodDays,
        "second_period_sale": product.secondPeriodSale
      }
    };
    print('prod: ' + prod.toString());
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('PUT', Uri.parse(baseUrl2 + '/products/${product.id}'));
    //var postRequest = await http.post(Uri.parse(baseUrl2 + "products"), body: prod);
    request.body = json.encode(prod);
    request.headers.addAll(headers);

    http.StreamedResponse res = await request.send();

    if (response.statusCode <= 201) {
      print(await res.stream.bytesToString());
    }
    else {
      print(await res.stream.bytesToString());
    }
  }
}

class Product {
  late int id;
  late int imageId;
  late String name;
  late String category;
  late String availableQuantity;
  late bool liked;
  late int expiryDate;
  late String unitPrice;
  late String viewsCount;
  late String contactPhone;

  String initialSale;
  String firstPeriodDays;
  String firstPeriodSale;
  String secondPeriodDays;
  String secondPeriodSale;

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
        required this.contactPhone,
        required this.initialSale,
        required this.firstPeriodDays,
        required this.firstPeriodSale,
        required this.secondPeriodDays,
        required this.secondPeriodSale,
      });
}

