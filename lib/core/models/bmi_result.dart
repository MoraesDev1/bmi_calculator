import 'package:bmi_calculator/core/enum/bmi_category.dart';

class BmiResult {
  final double bmi;
  final BmiCategory category;

  BmiResult({
    required this.bmi,
    required this.category,
  });
}