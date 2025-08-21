import 'package:flutter/material.dart';

enum BmiCategory {
  underweight(
    limit: 18.5,
    description: "Abaixo do peso",
    color: Colors.blue,
  ),
  normal(
    limit: 25.0,
    description: "Normal",
    color: Colors.green,
  ),
  overweight(
    limit: 30.0,
    description: "Sobrepeso",
    color: Colors.orange,
  ),
  obesity1(
    limit: 40.0,
    description: "Obesidade",
    color: Colors.redAccent,
  ),
  obesity2(
    limit: 100.0,
    description: "Obesidade Grave",
    color: Colors.red,
  );

  final double limit;
  final String description;
  final Color color;

  const BmiCategory({
    required this.limit,
    required this.description,
    required this.color,
  });

  static BmiCategory fromValue(double bmi) {
    for (final category in BmiCategory.values) {
      if (bmi < category.limit) {
        return category;
      }
    }
    return BmiCategory.obesity2; // Retorna a categoria mais alta se exceder todos os limites
  }
}