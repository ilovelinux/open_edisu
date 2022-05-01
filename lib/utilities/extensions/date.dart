extension DateWithoutTime on DateTime {
  DateTime withoutTime() => DateTime(year, month, day);
  bool isAtSameDayAs(DateTime date) =>
      withoutTime().isAtSameMomentAs(date.withoutTime());
}
