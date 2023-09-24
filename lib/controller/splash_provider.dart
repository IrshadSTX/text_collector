import 'dart:async';

import 'package:flutter/material.dart';
import 'package:text_collector/view/home_screen.dart';

class SplashScreenProvider with ChangeNotifier {
  void gotoHomeScreen(BuildContext context) {
    Timer(
      Duration(
          seconds:
              2), // Set the duration for which the splash screen will appear
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomeScreen()), // Replace with your main screen widget
        );
      },
    );
    notifyListeners();
  }
}
