import 'package:bmi_calculator/core/enum/bmi_category.dart';
import 'package:bmi_calculator/core/models/bmi_result.dart';
import 'package:bmi_calculator/core/services/bmi_service.dart';
import 'package:bmi_calculator/features/home/state/home_ui_state.dart';
import 'package:flutter/cupertino.dart';

class HomeController extends ValueNotifier<HomeUiState>{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  HomeController() 
  : super(HomeUiState.initial());

  void changeLoading(bool isLoading) {
    value = value.copyWith(isLoading: isLoading);
  }

  String? validateHeight() {
    final double? height = double.tryParse(value.heightController.text);
    if (height == null || height <= 0) {
      return 'Por favor, insira uma altura válida.';
    }
    
    if (height < 50) {
      return 'Altura muito baixa. Mínimo: 50cm.';
    }
    if (height > 300) {
      return 'Altura muito alta. Máximo: 300cm.';
    }
    
    return null;
  }

  String? validateWeight() {
    final double? weight = double.tryParse(value.weightController.text.replaceAll(',', '.'));
    if (weight == null || weight <= 0) {
      return 'Por favor, insira um peso válido.';
    }
    
    if (weight < 10) {
      return 'Peso muito baixo. Mínimo: 10kg.';
    }
    if (weight > 650) {
      return 'Peso muito alto. Máximo: 650kg.';
    }
    
    return null;
  }

  void calculateBmi() async {
    changeLoading(true);
    await Future.delayed(const Duration(seconds: 1));
    
    final double bmi = BmiService.calculateBmi(
      height: double.parse(value.heightController.text),
      weight: double.parse(value.weightController.text.replaceAll(',', '.')),
    );

    final BmiCategory category = BmiCategory.fromValue(bmi);

    final BmiResult result = BmiResult(bmi: bmi, category: category);

    value = value.copyWith(
      result: result,
      isResultVisible: true,
    );
    changeLoading(false);
  }
  
  void reset() {
    value = HomeUiState.initial();
  }
}