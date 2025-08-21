class BmiService {
  static double calculateBmi({required double height, required double weight}) {
    final double heightInMeters = height / 100;
    final double bmi = weight / (heightInMeters * heightInMeters);
    return double.parse(bmi.toStringAsFixed(1));
  }
}