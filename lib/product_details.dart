import 'dart:io';
import 'dart:typed_data';
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
import 'common widgets/new_product_txt_field.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ProductDetailsScreen extends StatefulWidget {
  int id;
  ProductDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

bool isLike = false;

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String? comment;

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
                                product.viewsCount,
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
                            image: product.imageBytes,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      product.name,
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          product.likesCount,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            if (await likeRequest(
                                                widget.id, !isLike)) {
                                              setState(() {
                                                isLike = !isLike;
                                              });
                                            }
                                          },
                                          icon: getLikeIcon(isLike),
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '\$${product.currentPrice}',
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
                                getProductDataRowWidget(
                                    'Expiration date:',
                                    DateFormat('yyyy-MM-dd').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            product.expiryDate))),
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
                                const ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    'Comments',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Icon(
                                    Icons.comment,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: ProductText(
                                          hint: 'Type something',
                                          icon: const Icon(Icons.comment),
                                          type: TextInputType.multiline,
                                          onChanged: (value) {
                                            comment = value;
                                          }),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        print(comment);
                                        if (comment != null) {
                                          if (await commentRequest(
                                              widget.id, comment!)) {
                                            setState(() {});
                                          }
                                        }
                                      },
                                      icon: const Icon(Icons.check),
                                      color: AppColors.primaryColor,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: product.comments.length,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return commentItem(
                                          product.comments[index]['user_name']
                                              .toString(),
                                          product.comments[index]['content']);
                                    }),
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
      dynamic jsonData = jsonDecode(response.body);
      print('tisdmtsd + ' + response.body);
      print(jsonData["id"]);

      response = await http.get(
          Uri.parse(baseUrl2 + "/images/${jsonData['image_id']}"),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          });
      var res = await http
          .get(Uri.parse(baseUrl2 + "/products/$id/comments"), headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      });
      print('comments: ' + res.body);
      var comments = jsonDecode(res.body);

      Product p = Product(
          id: jsonData['id'],
          imageId: jsonData['image_id'],
          imageBytes: response.bodyBytes,
          name: jsonData['name'],
          category: jsonData['category'],
          availableQuantity: jsonData['available_quantity'],
          liked: jsonData['liked'],
          expiryDate: jsonData['expiry_date'],
          unitPrice: jsonData['unit_price'].toString(),
          viewsCount: jsonData['views_count'].toString(),
          likesCount: jsonData['likes_count'].toString(),
          contactPhone: jsonData['contact_phone'],
          currentPrice: jsonData['current_price'].toString(),
          comments: comments);

      product = p;
      // print(product.imageString);

    } catch (e) {
      print("caught error");
      print(e);
    }
    return product;
  }
}

Future<bool> likeRequest(int id, bool isLike) async {
  try {
    String token = User.currentUser.token;
    if (isLike) {
      await http.post(Uri.parse(baseUrl2 + "/products/$id/like"), headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      });
    } else {
      await http.delete(Uri.parse(baseUrl2 + "/products/$id/like"), headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      });
    }
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> commentRequest(int id, String body) async {
  try {
    String token = User.currentUser.token;
    http.Response response;

    print('body: ' + body);

    response = await http.post(
      Uri.parse(baseUrl2 + "/products/$id/comments"),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({"content": body}),
    );

    print('res body: ' + response.body);

    if (response.statusCode == 404) return false;

    return true;
  } catch (e) {
    print(e);
    return false;
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
  String firstLetterOfName = name[0];
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Column(
      children: [
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CircleAvatar(
                child: Text(
                  firstLetterOfName.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                backgroundColor: Colors.black54,
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
  late Uint8List imageBytes;
  late String name;
  late String category;
  late int availableQuantity;
  late bool liked;
  late int expiryDate;
  late String unitPrice;
  late String currentPrice;
  late String viewsCount;
  late String likesCount;
  late String contactPhone;
  List<dynamic> comments;

  Product(
      {required this.id,
      required this.imageId,
      required this.imageBytes,
      required this.name,
      required this.category,
      required this.availableQuantity,
      required this.liked,
      required this.expiryDate,
      required this.unitPrice,
      required this.viewsCount,
      required this.likesCount,
      required this.contactPhone,
      required this.currentPrice,
      required this.comments});
}
