class User {
  static late User currentUser;
  String token;
  double id;
  String name;
  String phone;
  late String imageId;

  User({
    required this.token,
    required this.id,
    required this.name,
    required this.phone,
    //this.imageId//TODO
  });
}
