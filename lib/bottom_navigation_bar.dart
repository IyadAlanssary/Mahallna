import 'package:flutter/material.dart';
import 'package:products/view.dart';
import 'package:products/common widgets/profile.dart';
import 'package:products/common widgets/add_product_screen.dart';
import 'styles/colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);
  static bool gotResponse = false;
  static bool gotMiniResponse = false;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget change(int index) {
    if (index == 0) {
      return const Home();
    } else if (index == 1) {
      return const AddProduct();
    } else {
      return const Profile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppColors.myDecoration(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: change(_selectedIndex), //New
            ),
            BottomNavigationBar(
              showUnselectedLabels: false,
              backgroundColor: Colors.transparent,
              elevation: 50,
              selectedFontSize: 14,
              selectedIconTheme:
                  const IconThemeData(color: AppColors.primaryColor, size: 22),
              selectedItemColor: AppColors.primaryColor,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'View',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'Add Product',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              onTap: _onItemTapped,
              currentIndex: _selectedIndex,
            ),
          ],
        ),
      ),
    );
  }
}
