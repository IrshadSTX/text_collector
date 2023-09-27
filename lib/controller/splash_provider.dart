import 'dart:async';

import 'package:flutter/material.dart';
import 'package:text_collector/view/home_screen.dart';

class SplashScreenProvider with ChangeNotifier {
  void gotoHomeScreen(BuildContext context) {
    Timer(
      const Duration(
          seconds:
              2), // Set the duration for which the splash screen will appear
      () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
      },
    );
  }
}
