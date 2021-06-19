import 'package:flutter/material.dart';

class TimeOfDayHelper {
  static TimeOfDay parse(String timeText) {
    try {
      final time = timeText.split(":");
      final unit = time[1].split(" ");
      int hour = int.parse(time[0]);
      int minute = int.parse(unit[0]);

      if (unit[1] == "PM") {
        hour += 12;
      }

      return TimeOfDay(
        hour: hour,
        minute: minute,
      );
    } catch (e) {
      return const TimeOfDay(hour: 0, minute: 0);
    }
  }
}
