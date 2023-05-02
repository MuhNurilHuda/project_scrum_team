import 'package:flutter/material.dart';
import 'package:iterasi1/pages/_add_activities.dart';
import 'package:iterasi1/pages/itinerary_list.dart';
import 'package:iterasi1/pages/splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:iterasi1/provider/database_provider.dart';
import 'package:iterasi1/provider/itinerary_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set the SystemChrome
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MaterialApp(
      home:  AddActivities(),
      debugShowCheckedModeBanner : false,
      routes: {
        '/next' : (context) => const ItineraryList(),
      },
=======
    return MultiProvider(
      providers : [
        ChangeNotifierProvider(create: (_) => DatabaseProvider()),
        ChangeNotifierProvider(create: (_) => ItineraryProvider())
      ],
      child: MaterialApp(
        home: const SplashScreen(),
        debugShowCheckedModeBanner : false,
        routes: {
          ItineraryList.route : (context) => ItineraryList(),
        },
      ),
>>>>>>> 96ba3f47bd485297c7a8efc25265e63ba681868f
    );
  }
}


