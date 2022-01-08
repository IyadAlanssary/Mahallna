import 'dart:convert';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:products/styles/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:products/common widgets/image_local.dart';
import 'package:products/common widgets/new_product_txt_field.dart';
import 'package:image_picker/image_picker.dart';
import 'Models/const.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'Models/const.dart';
import 'Models/user.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
  static const String id = 'add_product_screen';
}

class _AddProductState extends State<AddProduct> {
  late String? name;
  late String? phone;
  late String? quantity;
  late String? originalPrice;
  late String? category;
  late String? expiryDate;
  late double? initialSale;
  late double? firstPeriodSale;
  late String? firstPeriodDays;
  late double? secondPeriodSale;
  late String? secondPeriodDays;
  File? image;
  String? imageString;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                setState(() {
                  postProduct();
                });
              },
              icon: const Icon(Icons.check),
              color: AppColors.primaryColor,
              iconSize: 28,
              tooltip: 'Add',
            ),
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
                                : Builder(builder: (context) {
                                  print('path ' + image.toString());
                                  return ImageLocal(image!);
                                }),
                            const SizedBox(
                              height: 30,
                            ),
                            Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: const ColorScheme.light().copyWith(
                                  primary: AppColors.primaryColor,
                                ),
                              ),
                              child: DateTimePicker(
                                cursorColor: AppColors.primaryColor,
                                style: const TextStyle(
                                    color: AppColors.primaryColor),
                                initialValue: DateTime.now().toString(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                icon: const Icon(Icons.event),
                                dateLabelText: 'Expiration Date',
                                onChanged: (value) {
                                  expiryDate = value;
                                  if (expiryDate != null) {
                                    expiryDate = DateTime
                                        .parse(expiryDate!)
                                        .millisecondsSinceEpoch.toString();
                                    print(expiryDate);
                                  }
                                },
                                onSaved: (val) {
                                  expiryDate = val;
                                  if (expiryDate != null) {
                                    expiryDate = DateTime
                                        .parse(expiryDate!)
                                        .millisecondsSinceEpoch.toString();
                                    print(expiryDate);
                                  }

                                },
                              ),
                            ),
                            //name
                            ProductText(
                              hint: 'Name',
                              maxLines: 1,
                              icon: const Icon(Icons.drive_file_rename_outline),
                              onChanged: (value) {
                                name = value;
                              },
                            ),
                            ProductText(
                              hint: 'Phone',
                              icon: const Icon(Icons.phone),
                              type: TextInputType.phone,
                              onChanged: (value) {
                                phone = value;
                              },
                            ),
                            // original price
                            ProductText(
                              hint: 'Original Price',
                              icon: const Icon(FontAwesomeIcons.dollarSign),
                              type: TextInputType.phone,
                              onChanged: (value) {
                                originalPrice = value;
                              },
                            ),
                            ProductText(
                              hint: 'Category',
                              icon: const Icon(Icons.view_list),
                              type: TextInputType.multiline,
                              onChanged: (value) {
                                category = value;
                              },
                            ),
                            // quantity
                            ProductText(
                              hint: 'Quantity',
                              icon: const Icon(Icons.workspaces_filled),
                              type: TextInputType.number,
                              onChanged: (value) {
                                quantity = value;
                              },
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            //DarkBar('Sales Periods', 50),
                            const ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                'Sales Plan:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            // first period and price
                            Row(
                              children: [
                                Expanded(
                                    child: ProductText(
                                  hint: 'days',
                                  maxLength: 3,
                                  type: TextInputType.number,
                                  onChanged: (value) {
                                    firstPeriodDays = value;
                                  },
                                )),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: ProductText(
                                  hint: 'Sale',
                                  maxLength: 2,
                                  type: TextInputType.number,
                                  onChanged: (value) {
                                    firstPeriodSale = double.tryParse(value!);
                                  },
                                )),
                              ],
                            ),
                            // second period and price
                            Row(
                              children: [
                                Expanded(
                                    child: ProductText(
                                  hint: 'days 2',
                                  maxLength: 3,
                                  type: TextInputType.number,
                                  onChanged: (value) {
                                    secondPeriodDays = value;
                                  },
                                )),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: ProductText(
                                  hint: 'Sale 2',
                                  maxLength: 2,
                                  type: TextInputType.number,
                                  onChanged: (value) {
                                    secondPeriodSale = double.tryParse(value!);
                                  },
                                )),
                              ],
                            ),
                            // default sale
                            ProductText(
                              hint: 'default sale',
                              maxLength: 2,
                              type: TextInputType.number,
                              onChanged: (value) {
                                initialSale = double.tryParse(value!);
                              },
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
    );
  }

  Future imagePicker() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
        this.imageString = base64Encode(imageTemp.readAsBytesSync());
        //print(imageString);
      });
    } on PlatformException catch (e) {
      print('could not load image');
    }
  }

  Future postProduct() async {
    print('in Add');
    Map<String,dynamic> prod = {
      "image": imageString,
      "details": {
        "name": name,
        "description": "The type you like the most.",
        "category": category,
        "available_quantity": quantity,
        "expiry_date": expiryDate,
        "unit_price": originalPrice,
        "contact_phone": phone,
        "initial_sale": initialSale,
        "first_period_days": firstPeriodDays,
        "first_period_sale": firstPeriodSale,
        "second_period_days": firstPeriodDays,
        "second_period_sale": secondPeriodSale
      }
    };
    String token = User.currentUser.token;
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse(baseUrl2 + '/products'));
    //var postRequest = await http.post(Uri.parse(baseUrl2 + "products"), body: prod);
    request.body = json.encode(prod);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode <= 201) {
      print(await response.stream.bytesToString());
    }
    else {
      print(await response.stream.bytesToString());
    }
  }
}
