import 'dart:math';
import 'dart:ui';

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

String bmiCalculator(double height, double weight) {
  double bmi = weight / pow((height/100), 2);
  if (bmi < 18.5) {
    return 'Underweight';
  } else if (bmi >= 18.5 && bmi < 24.9) {
    return 'Normal';
  } else if (bmi >= 24.9 && bmi < 30) {
    return 'Overweight';
  } else if (bmi >= 30) {
    return 'Obesity';
  } else {
    return 'Error';
  }
}
