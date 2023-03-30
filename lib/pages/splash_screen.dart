import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.pushReplacementNamed(context, '/next');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C3131),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8, // responsive
              child: Image.asset(
                'assets/images/splashscreen_logo.png',
                fit: BoxFit.contain,
                width: 250,
                height: 250,
              ),
            ),
            Text(
              'Trip Planner',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04, // responsive
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Your Personal Itinerary Assistant',
                  textStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.3,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w100,
                    color: Colors.white,
                  ),
                  speed: Duration(milliseconds: 300),
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
