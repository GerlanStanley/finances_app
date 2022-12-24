class VariationPercentUtils {
  static double calculate(double value1, double value2) {
    return ((value2 - value1) / value1) * 100;
  }
}