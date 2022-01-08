//import 'dart:ui';

import 'package:flutter/widgets.dart';

class GroceryItem {
  int id;
  String name;
  late String category;
  String price;
  late String imageId;
  Image image;

  GroceryItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    imageId,
    required this.image,
  });
}
