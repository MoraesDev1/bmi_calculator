import 'package:bmi_calculator/enum/bmi_category.dart';
import 'package:bmi_calculator/models/bmi_result.dart';
import 'package:flutter/material.dart';

class HomeUiState {
  final BmiResult result;
  final bool isLoading;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final bool isResultVisible;

  HomeUiState({
    required this.result,
    required this.isLoading,
    required this.heightController,
    required this.weightController,
    required this.isResultVisible,
  });

  factory HomeUiState.initial() {
    return HomeUiState(
      result: BmiResult(bmi: 0, category: BmiCategory.obesity2),
      isLoading: false,
      heightController: TextEditingController(),
      weightController: TextEditingController(),
      isResultVisible: false,
    );
  }

  HomeUiState copyWith({
    BmiResult? result,
    bool? isLoading,
    TextEditingController? heightController,
    TextEditingController? weightController,
    bool? isResultVisible,
  }) {
    return HomeUiState(
      result: result ?? this.result,
      isLoading: isLoading ?? this.isLoading,
      heightController: heightController ?? this.heightController,
      weightController: weightController ?? this.weightController,
      isResultVisible: isResultVisible ?? this.isResultVisible,
    );
  }
}