import 'package:flutter/material.dart';
import 'package:iterasi1/model/destination_list.dart';
import 'package:iterasi1/pages/add_itinerary.dart';
import 'package:iterasi1/pages/details_page.dart';
import 'package:iterasi1/navigation/bottom_navbar.dart';

class PaketWisata extends StatefulWidget {
  const PaketWisata({Key? key}) : super(key: key);

  @override
  _PaketWisataState createState() => _PaketWisataState();
}

class _PaketWisataState extends State<PaketWisata> {
  int _currentIndex = 0;
  Color _bgColor = const Color(0xFF1C3131);
  Color _cardColor = const Color(0xFFD5A364);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        title: const Text(
          'Daftar Wisata',
        ),
        backgroundColor: Colors.lightBlue[900],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final TourismPlace place = tourismPlaceList[index];
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailsPage(place: place);
              }));
            },
            child: listItem(place),
          );
        },
        itemCount: tourismPlaceList.length,
      ),
    );
  }

  Widget listItem(TourismPlace place) {
    return Card(
      color: _cardColor,
      margin: EdgeInsets.all(15.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      // color: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                place.imageAsset,
                width: 600,
                height: 200,
                fit: BoxFit.cover,
              ),
              ListTile(
                title: Text(place.name),
                subtitle: Text(place.location),
              )
            ],
          ),
        ),
      ),
    );
  }
}
