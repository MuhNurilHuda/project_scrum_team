import 'package:flutter/material.dart';

class ItineraryList extends StatelessWidget {
  const ItineraryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Itinerary List"),
          backgroundColor: Colors.lightBlue,
        ),
      ),
    );
  }
}
