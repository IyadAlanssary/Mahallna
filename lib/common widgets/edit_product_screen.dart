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
import '../const.dart';
import '../view.dart';

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
                                return View();
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

                              },
                              icon: const Icon(Icons.check),
                              color: AppColors.primaryColor,
                            )
                        ),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      image == null
                                          ? InkWell(
                                        onTap: () async {
                                          print('pressed');
                                          imagePicker();
                                        },
                                        child: Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            /*border: Border.all(color: darkSecondaryColor,width: 3),*/
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.8),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: const Offset(0,
                                                      7), //changes position of shadow
                                                )
                                              ],
                                              color: AppColors.darkGrey,
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(15))),
                                          child: const Center(
                                            child: Icon(
                                              Icons.camera_alt_outlined,
                                              size: 70,
                                            ),
                                          ),
                                        ),
                                      )
                                          : ImageLocal(image!),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      //name
                                      ProductText(
                                        initial: true,
                                        initialText: product.name,
                                        hint: 'Name',
                                        maxLines: 1,
                                        icon: const Icon(Icons.drive_file_rename_outline),
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
                                        initialText: '${product.unitPrice}',
                                        hint: 'Original Price',
                                        icon: const Icon(FontAwesomeIcons.dollarSign),
                                        type: TextInputType.phone,
                                        onChanged: (value) {},
                                      ),
                                      // quantity
                                      ProductText(
                                        initial: true,
                                        initialText: '${product.availableQuantity}',
                                        hint: 'Quantity',
                                        icon: const Icon(Icons.workspaces_filled),
                                        type: TextInputType.number,
                                        onChanged: (value) {},
                                      ),
                                      const SizedBox(height: 40,),
                                      //DarkBar('Sales Periods', 50),
                                      const ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(
                                          'Sales Plan:',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      // first period and price
                                      Row(
                                        children: [
                                          Expanded(
                                              child: ProductText(
                                                initial: true,
                                                initialText: '${product.salesPlan.firstPeriodDays}',
                                                hint: 'days',
                                                maxLength: 3,
                                                type: TextInputType.number,
                                                onChanged: (value) {},
                                              )),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded (
                                              child: ProductText(
                                                initial: true,
                                                initialText: '${product.salesPlan.firstPeriodSale}',
                                                hint: 'Sale',
                                                maxLength: 2,
                                                type: TextInputType.number,
                                                onChanged: (value) {},
                                              )),
                                        ],
                                      ),
                                      // second period and price
                                      Row(
                                        children: [
                                          Expanded(
                                              child: ProductText(
                                                initial: true,
                                                initialText: '${product.salesPlan.secondPeriodDays}',
                                                hint: 'days 2',
                                                maxLength: 3,
                                                type: TextInputType.number,
                                                onChanged: (value) {},
                                              )),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded (
                                              child: ProductText(
                                                initial: true,
                                                initialText: '${product.salesPlan.secondPeriodSale}',
                                                hint: 'Sale 2',
                                                maxLength: 2,
                                                type: TextInputType.number,
                                                onChanged: (value) {},
                                              )),
                                        ],
                                      ),
                                      // default sale
                                      ProductText(
                                        initial: true,
                                        initialText: '${product.salesPlan.initialSale}',
                                        hint: 'default sale',
                                        maxLength: 2,
                                        type: TextInputType.number,
                                        onChanged: (value) {},
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

  Future imagePicker() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('could not load image');
    }
  }

  dynamic response;
  late Product product;
  Future getHttp(int id) async {
    try {
      response = await http.get(Uri.https(baseUrl, "/products/$id"));
      print(response.body);
      var jsonData = jsonDecode(response.body);
      print(jsonData["id"]);
      print(jsonData["sales_plan"]["initial_sale"]);
      SalesPlan salesPlan = SalesPlan(
        initialSale: jsonData["sales_plan"]["initial_sale"],
        firstPeriodDays: jsonData["sales_plan"]["first_period_days"],
        firstPeriodSale: jsonData["sales_plan"]["first_period_sale"],
        secondPeriodDays: jsonData["sales_plan"]["second_period_days"],
        secondPeriodSale: jsonData["sales_plan"]["second_period_sale"],
      );
      Product p = Product(
        id: jsonData['id'],
        imageId: jsonData['image_id'],
        name: jsonData['name'],
        category: jsonData['category'],
        availableQuantity: jsonData['available_quantity'],
        liked: jsonData['liked'],
        expiryDate: jsonData['expiry_date'],
        unitPrice: jsonData['unit_price'],
        viewsCount: jsonData['views_count'],
        contactPhone: jsonData['contact_phone'],
        salesPlan: salesPlan,
      );

      product = p;

      //response = await dio.get('/test', queryParameters: {'id': 12, 'name': 'wendu'});
      // print(response.data.toString());
    } catch (e) {
      print("catched error");
      print(e);
    }
    return product;
  }

}

class Product {
  late int id;
  late int imageId;
  late String name;
  late String category;
  late int availableQuantity;
  late bool liked;
  late int expiryDate;
  late double unitPrice;
  late double viewsCount;
  late String contactPhone;
  late SalesPlan salesPlan;

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
        required this.salesPlan});
}

class SalesPlan {
  SalesPlan({
    required this.initialSale,
    required this.firstPeriodDays,
    required this.firstPeriodSale,
    required this.secondPeriodDays,
    required this.secondPeriodSale,
  });

  int initialSale;
  int firstPeriodDays;
  int firstPeriodSale;
  int secondPeriodDays;
  int secondPeriodSale;
}
