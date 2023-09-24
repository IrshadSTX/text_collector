import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_collector/controller/splash_provider.dart';
import 'package:text_collector/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => SplashScreenProvider())
      ],
      child: MaterialApp(
        title: 'Text Collector',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
