import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateHelper {
  static String getFormattedToday() {
    initializeDateFormatting("ja");
    var today = DateFormat.MMMMEEEEd('ja').format(DateTime.now()).toString();
    List splittedToday = today.split(RegExp(r"(?=.曜日)"));
    return "${splittedToday[0]}（${splittedToday[1].replaceAll("曜日", "")}）";
  }
}
