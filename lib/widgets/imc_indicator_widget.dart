import 'dart:math';

import 'package:bmi_calculator/enum/bmi_category.dart';
import 'package:flutter/material.dart';

class BmiGaugeWidget extends StatelessWidget {
  final double bmi;
  final BmiCategory category;

  const BmiGaugeWidget({super.key, required this.bmi, required this.category});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(250, 125),
      painter: _BmiGaugePainter(
        bmi: bmi,
        category: category,
        categories: BmiCategory.values,
      ),
    );
  }
}

class _BmiGaugePainter extends CustomPainter {
  final double bmi;
  final BmiCategory category;
  final List<BmiCategory> categories;

  _BmiGaugePainter({required this.bmi, required this.category, required this.categories});

  double _calculatePointerPosition() {
    double categoryStartAngle = 0.0;
    double categoryEndAngle = 0.0;
    
    for (int i = 0; i < categories.length; i++) {
      final cat = categories[i];
      categoryStartAngle = i / categories.length;
      categoryEndAngle = (i + 1) / categories.length;
      
      if (cat == category) {
        double minBmi = i == 0 ? 0.0 : categories[i - 1].limit;
        double maxBmi = cat.limit;
        
        double positionInCategory = (bmi - minBmi) / (maxBmi - minBmi);
        positionInCategory = positionInCategory.clamp(0.0, 1.0);
        
        return categoryStartAngle + (positionInCategory * (categoryEndAngle - categoryStartAngle));
      }
    }
    
    return 0.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    final innerRadius = radius * 0.4;
    final sweepAngle = pi / categories.length;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius - innerRadius;

    double startAngle = pi;
    for (var cat in categories) {
      paint.color = cat.color;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: (radius + innerRadius) / 2),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      startAngle += sweepAngle;
    }

    canvas.save();
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final pointerPaint = Paint()
      ..color = Colors.grey.shade900
      ..style = PaintingStyle.fill;

    final pointerPosition = _calculatePointerPosition();
    final pointerAngle = pi + (pointerPosition * pi);

    final pointerLength = radius * 0.75;
    final pointerWidth = radius * 0.12;
    final baseOffset = radius * 0.2;
    
    final tipPoint = Offset(
      center.dx + cos(pointerAngle) * pointerLength,
      center.dy + sin(pointerAngle) * pointerLength,
    );
    
    final basePoint1 = Offset(
      center.dx + cos(pointerAngle + pi/2) * pointerWidth + cos(pointerAngle) * baseOffset,
      center.dy + sin(pointerAngle + pi/2) * pointerWidth + sin(pointerAngle) * baseOffset,
    );
    
    final basePoint2 = Offset(
      center.dx + cos(pointerAngle - pi/2) * pointerWidth + cos(pointerAngle) * baseOffset,
      center.dy + sin(pointerAngle - pi/2) * pointerWidth + sin(pointerAngle) * baseOffset,
    );

    final trianglePath = Path()
      ..moveTo(tipPoint.dx, tipPoint.dy)
      ..lineTo(basePoint1.dx, basePoint1.dy)
      ..lineTo(basePoint2.dx, basePoint2.dy)
      ..close();

    canvas.drawPath(trianglePath, pointerPaint);

    canvas.restore();

    final centerCirclePaint = Paint()
      ..color = Colors.grey.shade900
      ..style = PaintingStyle.fill;
    
    final semicircleRadius = radius * 0.45;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: semicircleRadius),
      pi,
      pi, 
      true,
      centerCirclePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
