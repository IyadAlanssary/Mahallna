import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:products/styles/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:products/common widgets/image_local.dart';
import 'package:products/common widgets/new_product_txt_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
  static const String id = 'add_product_screen';
}

class _AddProductState extends State<AddProduct> {
  File? image;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                ///////////////TODO
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
                                              color:
                                                  Colors.grey.withOpacity(0.8),
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
                                onChanged: (value) {},
                                onSaved: (val) {},
                              ),
                            ),
                            //name
                            ProductText(
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
                            // social account
                            // ProductText(
                            //   hint: 'Social Account',
                            //   icon: const Icon(Icons.facebook_rounded),
                            //   type: TextInputType.url,
                            //   onChanged: (value) {},
                            // ),
                            // phone
                            ProductText(
                              hint: 'Phone',
                              icon: const Icon(Icons.phone),
                              type: TextInputType.phone,
                              onChanged: (value) {},
                            ),
                            // original price
                            ProductText(
                              hint: 'Original Price',
                              icon: const Icon(FontAwesomeIcons.dollarSign),
                              type: TextInputType.phone,
                              onChanged: (value) {},
                            ),
                            // quantity
                            ProductText(
                              hint: 'Quantity',
                              icon: const Icon(Icons.workspaces_filled),
                              type: TextInputType.number,
                              onChanged: (value) {},
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
                                  onChanged: (value) {},
                                )),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: ProductText(
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
                                  hint: 'days 2',
                                  maxLength: 3,
                                  type: TextInputType.number,
                                  onChanged: (value) {},
                                )),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: ProductText(
                                  hint: 'Sale 2',
                                  maxLength: 2,
                                  type: TextInputType.number,
                                  onChanged: (value) {},
                                )),
                              ],
                            ),
                            // default sale
                            ProductText(
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
}
