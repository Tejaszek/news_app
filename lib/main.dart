import 'package:flutter/material.dart';
import 'package:news_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            scrolledUnderElevation: 0, backgroundColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomeScreen(),
    );
  }
}
