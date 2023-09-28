import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_collector/controller/splash_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Provider.of<SplashScreenProvider>(context, listen: false)
        .gotoHomeScreen(context);
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: size.width * 0.2,
            ),
            Image.asset(
              'assets/images/textcollector.png',
              width: size.width * 0.2,
            )
          ],
        ),
      ),
    );
  }
}
