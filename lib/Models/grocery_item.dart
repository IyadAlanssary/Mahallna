import 'dart:typed_data';

class GroceryItem {
  int id;
  String name;
  late String category;
  String price;
  String imagePath;
  Uint8List? imageBytes;

  GroceryItem(
      {required this.id,
      required this.name,
      required this.category,
      required this.price,
      required this.imagePath,
      this.imageBytes});
}
