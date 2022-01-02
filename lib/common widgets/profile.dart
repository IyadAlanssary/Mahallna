import 'dart:io';

import 'package:flutter/material.dart';
import 'package:products/styles/colors.dart';
import 'package:products/common widgets/mini_item_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:products/log_in.dart';
import 'package:http/http.dart' as http;

import '../const.dart';

class Profile extends StatefulWidget {
  final String token;
  const Profile({Key? key, required this.token}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () => logOut(widget.token),
              icon: const Icon(Icons.exit_to_app),
              iconSize: 28,
              color: AppColors.primaryColor,
              tooltip: 'Log Out',
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 5, bottom: 15),
              child: CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.black,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Text(
              'Hamsho',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 15, left: 20),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'My Products:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<dynamic>(
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const SpinKitSpinningLines(
                    itemCount: 8,
                    color: AppColors.primaryColor,
                    size: 100.0,
                  );
                } else {
                  // return ListView.builder(
                  //    itemCount: snapshot.data.length,
                  //   itemBuilder: (context, i) {
                  return GridView.count(
                    childAspectRatio: 4,
                    crossAxisCount: 1,
                    children: MiniItemCard.miniCards,
                  );
                }
              },
              future: getHttp(widget.token),
            ),
          ),
        ],
      ),
    );
  }

  late var response;

  Future<void> logOut(String token) async {
    try {
      response =
          await http.post(Uri.parse(baseUrl2 + "/auth/logout"), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      });
      if (response.statusCode <= 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LogIn(),
          ),
        );
      } else if (response.statusCode >= 400) {
        print("\n Response status code: ");
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}
