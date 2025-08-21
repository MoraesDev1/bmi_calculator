import 'package:bmi_calculator/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class GenericAlertWidget extends StatelessWidget {
  final String message;

  const GenericAlertWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AppStrings.warning, textAlign: TextAlign.center),
      content: Column(
        spacing: 24,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error, size: 64, color: Theme.of(context).colorScheme.error),
          Text(message, textAlign: TextAlign.center),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(AppStrings.ok),
        ),
      ],
    );
  }
}