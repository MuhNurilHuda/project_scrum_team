import 'package:flutter/material.dart';

class AppBarItineraryTitle extends StatelessWidget{
  final String title;
  AppBarItineraryTitle({
    required this.title,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,

      ),
      textAlign: TextAlign.center,
    );
  }
}