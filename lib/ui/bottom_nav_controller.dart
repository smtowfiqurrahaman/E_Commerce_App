import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../const/AppColor.dart';
import 'BottomNavPages/cart.dart';
import 'BottomNavPages/favourite.dart';
import 'BottomNavPages/home.dart';
import 'BottomNavPages/profile.dart';
import 'BottomNavPages/searchs.dart';

class BottomNavController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavControllerr(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BottomNavControllerr extends StatefulWidget {
  _BottomNavControllerrState createState() => _BottomNavControllerrState();
}

class _BottomNavControllerrState extends State<BottomNavControllerr> {
  final _pages = [
    Cart(),
    Favourite(),
    Home(),
    Searchscreen(),
    Profile(),
    // Home(),
  ];
  var _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: AppColor.dblue,
        title: Text(
          "KI-LAGBA",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 2,
        backgroundColor: Colors.transparent,
        color: AppColor.dblue,
        height: 50,
        animationCurve: Curves.easeInOutSine,
        animationDuration: Duration(milliseconds: 400),
        items: [
          Icon(Icons.add_shopping_cart, size: 25, color: Colors.white),
          Icon(Icons.favorite, size: 25, color: Colors.white),
          Icon(Icons.home, size: 25, color: Colors.white),
          Icon(Icons.search, size: 25, color: Colors.white),
          Icon(Icons.account_circle, size: 25, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          }); //set State
        }, //ontap index
      ), //Bottom nav bar
      body: _pages[_currentIndex],
    );
  }
}
