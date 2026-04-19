import 'package:intl/intl.dart';

class FormatHelper {
  static final NumberFormat _currencyFormatter = NumberFormat('#,###');

  static String formatCurrency(num amount) {
    return _currencyFormatter.format(amount);
  }
}
