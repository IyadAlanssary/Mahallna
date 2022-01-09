import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:products/Models/user.dart';
import 'package:products/styles/colors.dart';
import 'package:products/common widgets/mini_item_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:products/log_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Models/const.dart';
import 'bottom_navigation_bar.dart';

class Profile extends StatefulWidget {
  //final String token;

  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool loadingTimeFinished = false;
  String myProductsMessage = 'My Products';
  String firstLetterOfName = User.currentUser.name[0];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () => logOut(),
              icon: const Icon(Icons.exit_to_app),
              iconSize: 28,
              color: AppColors.primaryColor,
              tooltip: 'Log Out',
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 15),
              child: CircleAvatar(
                child: Text(
                  firstLetterOfName.toUpperCase(),
                  style: const TextStyle(fontSize: 48, color: Colors.white),
                ),
                radius: 50.0,
                backgroundColor: Colors.black54,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              User.currentUser.name,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Text(
              User.currentUser.phone,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15, left: 20),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                myProductsMessage,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<dynamic>(
              future: getMiniItemsHttp(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  Timer(
                      const Duration(seconds: 5),
                      () => {
                            setState(() {
                              loadingTimeFinished = true;
                            })
                          });
                  if (!loadingTimeFinished) {
                    return const SpinKitSpinningLines(
                      itemCount: 30,
                      color: AppColors.primaryColor,
                      size: 100.0,
                    );
                  } else {
                    return const Text("You Don't have any products");
                  }
                } else {
                  return GridView.count(
                    childAspectRatio: 5,
                    crossAxisCount: 1,
                    children: MiniItemCard.miniCards,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> logOut() async {
    try {
      String token = User.currentUser.token;
      var response =
          await http.post(Uri.parse(baseUrl2 + "/auth/logout"), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      });
      BottomNavBar.gotMiniResponse = false;
      BottomNavBar.gotResponse = false;
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('is_register');
      prefs.remove('token');
      prefs.remove('name');
      prefs.remove('phone');
      prefs.remove('id');
      print("\n Response status code: ");
      print(response.statusCode);
    } catch (e) {
      print(e);
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LogIn(),
      ),
    );
  }
}
