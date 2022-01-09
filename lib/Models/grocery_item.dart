import 'dart:typed_data';

class GroceryItem {
  int id;
  String name;
  String category;
  String price;
  String imagePath;
  Uint8List? imageBytes;
  String expiryDate;

  GroceryItem(
      {required this.id,
      required this.name,
      required this.category,
      required this.price,
      required this.imagePath,
      required this.expiryDate,
      this.imageBytes});
}

class MiniGroceryItem {
  int id;
  String name;

  MiniGroceryItem({
    required this.id,
    required this.name,
  });
}
