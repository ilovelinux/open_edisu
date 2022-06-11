import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../models/edisu.dart';
import '../extensions/time.dart';

class TimeOfDayConverter implements JsonConverter<TimeOfDay, String> {
  const TimeOfDayConverter();

  @override
  TimeOfDay fromJson(String json) =>
      TimeOfDay.fromDateTime(DateFormat.Hm().parse(json));

  @override
  String toJson(TimeOfDay object) => object.to24hours();
}

class DateFormatConverter implements JsonConverter<DateTime, String> {
  const DateFormatConverter.dMy() : pattern = 'dd-MM-y';
  const DateFormatConverter.yMd() : pattern = 'y-MM-dd';

  final String pattern;

  @override
  DateTime fromJson(String json) => DateFormat(pattern).parse(json);

  @override
  String toJson(DateTime object) => DateFormat(pattern).format(object);
}

class SlotConverter implements JsonConverter<Slot, String> {
  const SlotConverter();

  @override
  Slot fromJson(String json) {
    final times = json.split(' ').map(
          (e) => TimeOfDay.fromDateTime(DateFormat.Hm().parse(e)),
        );
    return Slot(times.first, times.last);
  }

  @override
  String toJson(Slot object) =>
      [object.begin, object.end].map((e) => e.to24hours()).join(" ");
}
