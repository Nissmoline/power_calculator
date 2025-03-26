import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const PowerConsumptionCalculatorApp());
}

class PowerConsumptionCalculatorApp extends StatelessWidget {
  const PowerConsumptionCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор энергопотребления',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}
