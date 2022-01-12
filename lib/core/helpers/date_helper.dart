import 'package:intl/intl.dart';

class DateHelper {
  static DateFormat dateFormatFull = DateFormat('dd MMMM yyyy, HH:mm', 'kk');
  static DateFormat dateFormatFullNumeric = DateFormat('dd.MM.yyyy HH:mm');
  static DateFormat dateFormatFullRest = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
  static DateFormat dateFormatFullRestNotMilSec = DateFormat('yyyy-MM-dd');
  static DateFormat dateFormatFullNotMilSec = DateFormat('dd.MM.yyyy');
  static DateFormat dateFormatShortRest = DateFormat('dd MMM yy',);
  static DateFormat dateFormatShortRest2 = DateFormat('dd.MM.yy',);
  static DateFormat dateFormatDateMonth = DateFormat('dd MMM');
  static DateFormat timeFormat = DateFormat('HH:mm');
  static final oCcy = NumberFormat('#,##0.00');
  static final numForm = NumberFormat('#,##0');

  static String formatFull(DateTime val) {
    return dateFormatFullNumeric.format(val);
  }

  static String formatDate(DateTime val) {
    return dateFormatShortRest2.format(val);
  }
}

// extension DateTimeExt on DateTime {
//   bool sameDay(DateTime other) =>
//       year == other.year && month == other.month && day == other.day;
// }
