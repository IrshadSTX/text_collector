import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_collector/controller/splash_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<SplashScreenProvider>(context, listen: false)
        .gotoHomeScreen(context);
    return const Scaffold(
      body: Center(
        child: Text(
          'Text Collector',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
