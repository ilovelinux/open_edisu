import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  bool operator <(TimeOfDay time) =>
      hour < time.hour || (hour == time.hour && minute < time.minute);
  bool operator <=(TimeOfDay time) => this < time || this == time;
  bool operator >(TimeOfDay time) => !(this <= time);
  bool operator >=(TimeOfDay time) => !(this < time);

  String to24hours() {
    final h = hour.toString().padLeft(2, "0");
    final m = minute.toString().padLeft(2, "0");
    return "$h:$m";
  }

  TimeOfDay step({int steps = 1}) => TimeOfDay(
        hour: hour + (minute + 30 * steps) ~/ 60,
        minute: (minute + 30 * steps) % 60,
      );
}
