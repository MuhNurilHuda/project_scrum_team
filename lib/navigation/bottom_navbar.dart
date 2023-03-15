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

    );
  }
}
