class GroceryItem {
  int id;
  late String name;
  late String description;
  late double price;
  late String imagePath;

  GroceryItem(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imagePath});
}
/*
  static GroceryItem item = GroceryItem(
      name: "Organic Bananas",
      description: "7 pieces",
      price: 4.99,
      imagePath: "assets/images/grocery_images/banana.png");
  static GroceryItem item2 = GroceryItem(
      name: "Red Apple",
      description: "1kg, Price",
      price: 4.99,
      imagePath: "assets/images/grocery_images/Dominic.jpg");
  static GroceryItem item6 = GroceryItem(
      name: "Diet Coke",
      description: "355ml, Price",
      price: 1.99,
      imagePath: "assets/images/beverages_images/diet_coke.png");
*/
