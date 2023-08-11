import 'package:intl/intl.dart';

class DateUtility {
  String getDashboardDate() {
    return DateFormat("EE, dd MMM yyyy").format(DateTime.now());
  }

  String getToday() {
    return DateFormat("EE, dd MMM yyyy").format(DateTime.now());
  }

  String getTodayWeek() {
    return DateFormat("day").format(DateTime.now());
  }

  String getStartDateFormate({date}) {
    return DateFormat.yMMMMEEEEd().format(DateTime.parse(date ?? ""));
  }

  DateTime convertStringToDate({stringDate}) {
    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(stringDate);
    return parseDate;
  }

  DateTime getYyyyMmDdDate() {
    DateTime parseDate =
        DateFormat("yyyy-MM-dd").parse(DateTime.now().toString());
    return parseDate;
  }

  String taskStartsFrom({stringDate}) {
    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(stringDate);
    DateTime today = DateFormat("yyyy-MM-dd").parse(DateTime.now().toString());
    return parseDate.isAtSameMomentAs(today)
        ? 'CURRENT'
        : parseDate.isAfter(today)
            ? 'FUTURE'
            : 'PAST';
  }
}
