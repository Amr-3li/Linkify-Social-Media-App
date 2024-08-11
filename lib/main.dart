import 'package:flutter/material.dart';
import 'package:true_gym/views/pages/app_pages/calories_calculator_page.dart';
import 'package:true_gym/views/pages/register_pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'True Gym',
      debugShowCheckedModeBanner: false,
      home: CaloriesCalculatorPage(),
    );
  }
}
