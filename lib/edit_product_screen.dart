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
                                        onChanged: (value) {},
                                      ),
                                      //description
                                      // ProductText(
                                      //   hint: 'Description',
                                      //   icon: const Icon(Icons.article_rounded),
                                      //   type: TextInputType.multiline,
                                      //   onChanged: (value) {},
                                      // ),
                                      ProductText(
                                        initial: true,
                                        initialText: product.contactPhone,
                                        hint: 'Phone',
                                        icon: const Icon(Icons.phone),
                                        type: TextInputType.phone,
                                        onChanged: (value) {},
                                      ),
                                      // original price
                                      ProductText(
                                        initial: true,
                                        initialText: product.unitPrice,
                                        hint: 'Original Price',
                                        icon: const Icon(
                                            FontAwesomeIcons.dollarSign),
                                        type: TextInputType.phone,
                                        onChanged: (value) {},
                                      ),
                                      // quantity
                                      ProductText(
                                        initial: true,
                                        initialText:
                                            '${product.availableQuantity}',
                                        hint: 'Quantity',
                                        icon:
                                            const Icon(Icons.workspaces_filled),
                                        type: TextInputType.number,
                                        onChanged: (value) {},
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
      await http.get(Uri.parse(baseUrl2 + "/products/366871311303184384"), headers: {
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
        name: jsonData['name'],
        category: jsonData['category'],
        availableQuantity: jsonData['available_quantity'],
        unitPrice: jsonData['unit_price'].toString(),
        contactPhone: jsonData['contact_phone'],
      );

      product = p;
    } catch (e) {
      print("caught error");
      print(e);
    }
    return product;
  }
  Future postProduct() async {
    print('in Add');
    Map<String,dynamic> prod = {
      "image": "WW91IGxhenkgYmFzdGFyZHMgZ28gaW1wbGVtZW50IHRoZSBtdWx0aXBhcnQvZm9ybS1kYXRhIGVuY29kZXIuCg==",
      "details": {
        "name": "Potato",
        "description": "The type you like the most.",
        "category": "Vegetables",
        "available_quantity": 69,
        "expiry_date": 3640366075,
        "unit_price": 86585544.15898922,
        "contact_phone": "+963949654321",
        "initial_sale": 69,
        "first_period_days": 81665552,
        "first_period_sale": 69,
        "second_period_days": 92282931,
        "second_period_sale": 69
      }
    };
    String token = User.currentUser.token;
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse('http://localhost:8000/api/products'));
    //var postRequest = await http.post(Uri.parse(baseUrl2 + "products"), body: prod);
    request.body = json.encode(prod);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode <= 201) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }
}

class Product {
  late int id;
  late String name;
  late String category;
  late int availableQuantity;
  late String unitPrice;
  late String contactPhone;

  Product(
      {required this.id,
      required this.name,
      required this.category,
      required this.availableQuantity,
      required this.unitPrice,
      required this.contactPhone});
}

