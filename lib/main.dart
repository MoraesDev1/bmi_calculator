import 'package:bmi_calculator/core/theme/app_theme.dart';
import 'package:bmi_calculator/features/home/view/home_view_module.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeViewModule(),
      theme: AppTheme.dark,
    );
  }
}
