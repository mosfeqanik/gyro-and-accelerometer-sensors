import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  var formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
  return formattedDate;
}
String formatDate(DateTime date) {
  return DateFormat('EEE, d MMM').format(date); // Format as 'Fri, 14 Sep'
}
String formatCurrentDateTime() {
  var now = DateTime.now();
  var formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
  return formattedDate;
}

String getTimeFromTimeStamp(String timestamp) {
  try {
    var dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);

    var day = dateTime.day;
    var month = getMonthFromMonthNumber(dateTime.month);
    var year = dateTime.year;

    return "$day $month $year";
  } catch (E) {
    return "";
  }
}

getOrderedTime(String dateTime) {
  String getTime(DateTime dateTime) {
    return "${dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour}:${dateTime.minute} ${dateTime.hour > 12 ? "PM" : "AM"}";
  }

  DateTime dateT = DateTime.parse(dateTime);
  return "${getMonthFromMonthNumber(dateT.month)} ${dateT.day} , ${dateT.year} at ${getTime(dateT)}";
}

String getMonthFromMonthNumber(int month) {
  switch (month) {
    case 1:
      return "January";
    case 2:
      return "February";

    case 3:
      return "March";

    case 4:
      return "April";

    case 5:
      return "May";

    case 6:
      return "June";

    case 7:
      return "July";

    case 8:
      return "August";

    case 9:
      return "September";

    case 10:
      return "October";

    case 11:
      return "November";

    case 12:
      return "December";

    default:
      return "January";
  }
}

String getTimeDifference() {
  var birthday = DateTime(1967, 10, 12);
  var date2 = DateTime.now();
  var difference = date2.difference(birthday).inHours;
  return difference.toString();
}
