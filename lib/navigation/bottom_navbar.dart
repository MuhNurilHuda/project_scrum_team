import 'package:flutter/material.dart';
import 'package:iterasi1/pages/paket_wisata.dart';
import 'package:iterasi1/pages/add_itinerary.dart';
import 'package:iterasi1/pages/make_itinerary.dart';
import 'package:iterasi1/pages/schedule/make_itinerary.dart';
import 'package:iterasi1/pages/make_itinerary.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  // List<Widget> ?_page;
  int _indexPage = 0;

  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.list),
      label: 'Itinerary',
    )
  ];

  List<Widget> _tabViews = [
    PaketWisata(),
    MakeNewItinerary(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabViews[_indexPage],
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavBarItems,
        currentIndex: _indexPage,
        onTap: (int index) {
          setState(() {
            _indexPage = index;
          });
        },
      ),
    );
  }
}
