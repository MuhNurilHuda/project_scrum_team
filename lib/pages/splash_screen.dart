import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:iterasi1/resource/custom_colors.dart';

import 'itinerary_list.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate after 2 seconds
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacementNamed(context, ItineraryList.route);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8, // responsive
              child: Image.asset(
                'assets/logo/AppLogo.png',
                fit: BoxFit.contain,
                width: 170,
                height: 170,
              ),
            ),
            Text(
              'Trip Planner',
              style: TextStyle(
                fontSize: 40, // responsive
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w800,
                color: CustomColor.buttonColor,
              ),
            ),

            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Your Personal Itinerary Assistant',
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  speed: const Duration(milliseconds: 15),
                ),
              ],
              totalRepeatCount: 1, // animasi akan diulang sekali saja
            ),
          ],
        ),
      ),
    );
  }

}
