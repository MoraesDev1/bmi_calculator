import 'package:bmi_calculator/core/widgets/imc_indicator_widget.dart';
import 'package:bmi_calculator/features/home/controller/home_controller.dart';
import 'package:bmi_calculator/features/home/state/home_ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MbHomeView extends StatelessWidget {
  final HomeController controller;
  
  const MbHomeView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ValueListenableBuilder<HomeUiState>(
        valueListenable: controller,
        builder: (BuildContext context, HomeUiState value, _) {
          if (value.isLoading) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              ],
            );
          }
          if (value.isResultVisible) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BmiGaugeWidget(bmi: value.result.bmi, category: value.result.category),
                SizedBox(height: 60),
                Text(
                  'Seu IMC é ${value.result.bmi > 100 ? 'acima de 100' : value.result.bmi < 0 ? 'abaixo de 0' : value.result.bmi.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Row(),
                Text(
                  'Categoria: ${value.result.category.description}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controller.reset();
                      },
                      child: Text('Calcular novamente'),
                    ),
                  ],
                ),
              ],
            );
          }
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  TextFormField(
                    controller: value.heightController,
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Altura (cm)'),
                    validator: (_) => controller.validateHeight(),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  TextFormField(
                    controller: value.weightController,
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    decoration: InputDecoration(labelText: 'Peso (kg)'),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    validator: (String? value) {
                      return controller.validateWeight();
                    },
                    inputFormatters: [
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        if (newValue.text.isEmpty) return newValue;
                        int dotCount = newValue.text.split('.').length - 1;
                        int commaCount = newValue.text.split(',').length - 1;
                        if (dotCount + commaCount > 1) {
                          return oldValue;
                        }
                        if (!RegExp(r'^[0-9.,]*$').hasMatch(newValue.text)) {
                          return oldValue;
                        }
                        if (dotCount == 1) {
                          List<String> parts = newValue.text.split('.');
                          if (parts.length > 1 && parts[1].length > 3) {
                            return oldValue;
                          }
                        }
                        if (commaCount == 1) {
                          List<String> parts = newValue.text.split(',');
                          if (parts.length > 1 && parts[1].length > 3) {
                            return oldValue;
                          }
                        }
                        return newValue;
                      }),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (controller.formKey.currentState?.validate() ?? false) {
                        FocusScope.of(context).unfocus();
                        controller.calculateBmi();
                      }
                    },
                    child: Text('Calcular IMC'),
                  ),
                ],
              ),
            ),
          ); 
        },
      ),
    );
  }
}