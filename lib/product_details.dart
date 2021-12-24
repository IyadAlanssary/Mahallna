import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:products/log_in.dart';
import 'package:products/common widgets/grocery_item.dart';
import 'package:products/styles/colors.dart';
import 'package:products/common widgets/item_counter_widget.dart';
import 'package:products/common widgets/get_image_header_widget.dart';
import 'common widgets/app_button.dart';

class ProductDetailsScreen extends StatefulWidget {

  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();

}

bool isLike = false;

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        backgroundColor: Colors.transparent,
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const LogIn();
                      },
                    ));
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: AppColors.darkGrey,
                ),
              ],
            ),
            getImageHeaderWidget(url: 'images/kitkat.jpg',),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text(
                          'KitKat',
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
                          color: Colors.blueGrey,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          ItemCounterWidget(
                            onAmountChanged: (newAmount) {
                              setState(() {

                              });
                            }, key: null,
                          ),
                          const Spacer(),
                          const Text(
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
                          color: Colors.blueGrey,
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
    );
  }
}

Icon getLikeIcon(bool isLike){
  if (isLike) {
    return const Icon(Icons.thumb_up);
  }
  else {
    return const Icon(Icons.thumb_up_alt_outlined);
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
                color: Colors.blueGrey,
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