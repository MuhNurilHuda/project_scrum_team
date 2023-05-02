import 'package:flutter/material.dart';
import 'package:iterasi1/pages/_add_activities.dart';
import 'package:iterasi1/pages/itinerary_list.dart';
import 'package:iterasi1/pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  AddActivities(),
      debugShowCheckedModeBanner : false,
      routes: {
        '/next' : (context) => const ItineraryList(),
      },
    );
  }
}


