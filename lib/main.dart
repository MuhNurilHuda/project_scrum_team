import 'package:flutter/material.dart';
import 'package:iterasi1/pages/itinerary_list.dart';
import 'package:iterasi1/pages/splash_screen.dart';
import 'package:iterasi1/provider/database_provider.dart';
import 'package:iterasi1/provider/itinerary_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers : [
        ChangeNotifierProvider(create: (_) => DatabaseProvider()),
        ChangeNotifierProvider(create: (_) => ItineraryProvider())
      ],
      child: MaterialApp(
        home: const SplashScreen(),
        debugShowCheckedModeBanner : false,
        routes: {
          '/next' : (context) => ItineraryList(),
        },
      ),
    );
  }
}


