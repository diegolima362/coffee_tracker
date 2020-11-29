import 'package:intl/intl.dart';

class Format {
  static String hours(DateTime date) {
    return DateFormat.Hm().format(date);
  }

  static String date(DateTime date) {
    return DateFormat.MMMEd('pt_Br').format(date);
  }

  static String simpleDate(DateTime date) {
    return DateFormat.yMd('pt_Br').format(date);
  }

  static String fullDate(DateTime date) {
    return DateFormat.yMMMMd('pt_Br').format(date);
  }

  static String dayOfWeek(DateTime date) {
    return DateFormat.E('pt_Br').format(date);
  }

  static String currency(double pay) {
    if (pay != 0.0) {
      final formatter = NumberFormat.simpleCurrency(decimalDigits: 0);
      return formatter.format(pay);
    }
    return '';
  }

  static dateFirebase(DateTime date) {
    return DateFormat('dMMMy').format(date).replaceAll('/', ' ');
  }

  static String capitalString(String str) {
    final s = StringBuffer();
    str.toLowerCase().split(' ').forEach((i) => s.write(i.length == 1
        ? i.toUpperCase() + ' '
        : i.length > 2
            ? i[0].toUpperCase() + i.substring(1) + ' '
            : i + ' '));

    return s.toString();
  }
}
