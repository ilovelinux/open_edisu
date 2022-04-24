extension DateWithoutTime on DateTime {
  DateTime withoutTime() => DateTime(year, month, day);
}
