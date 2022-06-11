import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:open_edisu/utilities/json/castings.dart';
import '../utilities/json/converters.dart';

import '../utilities/extensions/time.dart';

part 'user.dart';
part 'edisu.g.dart';
part 'booking.dart';

extension on TimeOfDay {
  TimeOfDay step({int steps = 1}) => TimeOfDay(
        hour: hour + (minute + 30 * steps) ~/ 60,
        minute: (minute + 30 * steps) % 60,
      );
}
