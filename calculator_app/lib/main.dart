import 'package:flutter/material.dart';
import 'package:calculator_app/page/calculator_page.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Calculator', home: CalculatorPage());
  }
}
