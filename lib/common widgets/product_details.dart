import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:products/common widgets/grocery_item.dart';
import 'package:products/styles/colors.dart';
import 'package:products/common widgets/get_image_header_widget.dart';
import 'package:products/view.dart';

class ProductDetailsScreen extends StatefulWidget {

  const ProductDetailsScreen({Key ? key}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();

}

bool isLike = false;

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: AppColors.myDecoration(),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
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
                    child: Row(
                      children: const [
                        Text(
                          '20',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
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
                    getImageHeaderWidget(url: 'assets/images/grocery_images/banana.png',),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: const Text(
                                  'Banana',
                                  style: TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.bold),

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
                                children: const [
                                  Text(
                                    '\$20',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              getProductDataRowWidget('Expiration date:', '12/1/2022'),
                              const Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              getProductDataRowWidget('Category:', 'category'),
                              const Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              getProductDataRowWidget('Contact:', '1234567890'),
                              const Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              getProductDataRowWidget('Quantity:', '50'),
                              const SizedBox(
                                height: 40,
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: const Text(
                                  'Comments',
                                  style: TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.bold),

                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    setState(() {

                                    });
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Icon getLikeIcon(bool isLike){
  if (isLike) {
    return const Icon(Icons.favorite);
  }
  else {
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

Widget commentItem(String name,String comment) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Column(
      children: [
        Row(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black ,
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