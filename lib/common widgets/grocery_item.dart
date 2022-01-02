class GroceryItem {
  double id;
  late String name;
  late String category;
  late double price;
  late String imagePath;

  GroceryItem(
      {required this.id,
      required this.name,
      required this.category,
      required this.price,
      required this.imagePath});

  factory GroceryItem.fromJson(Map<dynamic, dynamic> json) => GroceryItem(
        id: json["id"],
        name: json["name"],
        //imageId: json["image_id"].toDouble(),       //////////////
        category: json["category"],
        price: json["current_price"],
        imagePath: "assets/images/grocery_images/banana.png",
      );
}
