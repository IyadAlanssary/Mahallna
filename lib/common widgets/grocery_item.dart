class GroceryItem {
  int id;
  String name;
  late String category;
  String price;
  String imagePath;

  GroceryItem(
      {required this.id,
      required this.name,
      required this.category,
      required this.price,
      required this.imagePath});
}
