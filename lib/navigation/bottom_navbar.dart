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

  final List<Widget> _tabViews = [
    const PaketWisata(),
    MakeNewItinerary(),
  ];

  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: _tabViews[_indexPage],
  //     bottomNavigationBar: ClipRRect(
  //       borderRadius: BorderRadius.all(Radius.circular(30.0)),
  //       child: BottomNavigationBar(
  //         backgroundColor: const Color(0xFF42AB9C),
  //         selectedItemColor: const Color(0xFFD5A364),
  //         unselectedItemColor: const Color(0xFF1C3131),
  //         showSelectedLabels: true,
  //         showUnselectedLabels: false,
  //         items: _bottomNavBarItems,
  //         currentIndex: _indexPage,
  //         onTap: (int index) {
  //           setState(() {
  //             _indexPage = index;
  //           });
  //         },
  //       ),
  //     ),
  //       );
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _tabViews[_indexPage],
          Positioned(
            bottom: 1,
            left: 4,
            right: 4,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                child: BottomNavigationBar(
                  backgroundColor: const Color(0xFF42AB9C),
                  selectedItemColor: const Color(0xFF000000),
                  unselectedItemColor: const Color(0xFF1C3131),
                  showSelectedLabels: true,
                  showUnselectedLabels: false,
                  items: _bottomNavBarItems,
                  currentIndex: _indexPage,
                  onTap: (int index) {
                    setState(() {
                      _indexPage = index;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
