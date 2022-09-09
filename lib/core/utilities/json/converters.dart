import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:open_edisu/core/utilities/extensions/time.dart';

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
