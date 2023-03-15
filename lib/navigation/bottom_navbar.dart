import 'package:flutter/material.dart';
import 'package:iterasi1/pages/paket_wisata.dart';
import 'package:iterasi1/pages/add_itinerary.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  List<Widget> ?_page;
  int _indexPage = 0;

  _BottomNavbarState() {
    _page = [
      PaketWisata(),
      AddItinerary(),
    ];
  }

  Widget PaketWisata() => Center(
    child: Text('Home'),
  );

  Widget AddItinerary() => Center(
    child: Text("Add Itinerary"),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page?[_indexPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indexPage,
        onTap: (i) => setState(() {
          _indexPage = i;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Menu 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Menu 2',
          )
        ],
      ),
    );
  }
}
