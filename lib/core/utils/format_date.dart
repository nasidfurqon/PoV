import 'package:intl/intl.dart';

class FormatDate {
  static String formateddDate(DateTime date){
    return DateFormat('dd-MM-yyyy').format(date);
  }
  static String formatedDateTime(DateTime date){
    return DateFormat('dd-MM-yyyy HH:mm:ss').format(date);
  }
}


