class DateTimeFormatter {

  static String formatDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  static String formatTime(DateTime dateTime) {
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    int second = dateTime.second;

    String amPm = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12;
    hour = hour == 0 ? 12 : hour;

    String formattedHour = hour.toString().padLeft(2, '0');
    String formattedMinute = minute.toString().padLeft(2, '0');
    String formattedSecond = second.toString().padLeft(2, '0');

    return '$formattedHour:$formattedMinute:$formattedSecond $amPm';
  }

  static String currentTime(DateTime dateTime,) {
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    int second = dateTime.second;

    String amPm = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12;
    hour = hour == 0 ? 12 : hour;

    String formattedHour = hour.toString().padLeft(2, '0');
    String formattedMinute = minute.toString().padLeft(2, '0');

    return '$formattedHour:$formattedMinute $amPm';
  }
  static String currentTimeForScreens(DateTime dateTime,) {
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    int second = dateTime.second;

    String amPm = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12;
    hour = hour == 0 ? 12 : hour;

    String formattedHour = hour.toString().padLeft(1, '0');
    String formattedMinute = minute.toString().padLeft(2, '0');

    return '$formattedHour:$formattedMinute';
  }


}