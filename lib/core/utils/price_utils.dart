import 'package:intl/intl.dart';

class PriceUtils {
  static String convert(double price) {
    var numberFormat = NumberFormat.simpleCurrency(
        locale: "pt_BR", name: "R\$", decimalDigits: 2);

    String strNumberFormat = numberFormat.format(price);

    if (strNumberFormat == "-R\$ 0,00") {
      strNumberFormat = "R\$ 0,00";
    }

    return strNumberFormat;
  }
}