import 'package:flutter/material.dart';
import 'package:iterasi1/pages/paket_wisata.dart';
import 'package:iterasi1/pages/itinerary_table.dart';
import 'package:iterasi1/navigation/bottom_navbar.dart';
import 'package:iterasi1/pages/splash_screen.dart';
import 'package:iterasi1/pages/itinerary_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      routes: {
        '/next' : (context) => const ItineraryList(),
      },
    );
  }
}


