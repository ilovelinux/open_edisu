import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import '../utilities/json/converters.dart';

import '../utilities/constants/api.dart';
import '../utilities/extensions/time.dart';
import '../utilities/constants/urls.dart' as urls;

part 'user.dart';
part 'edisu.g.dart';
part 'booking.dart';

extension on TimeOfDay {
  TimeOfDay step({int steps = 1}) => TimeOfDay(
        hour: hour + (minute + 30 * steps) ~/ 60,
        minute: (minute + 30 * steps) % 60,
      );
}
