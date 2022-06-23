import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:open_edisu/utilities/json/castings.dart';
import '../utilities/json/converters.dart';

import '../utilities/extensions/time.dart';

part 'user.dart';
part 'edisu.g.dart';
part 'booking.dart';

@JsonSerializable()
class University {
  final String name;
  final String address;
  final int id;

  const University({
    required this.name,
    required this.address,
    required this.id,
  });

  factory University.fromJson(Map<String, dynamic> json) =>
      _$UniversityFromJson(json);
}

typedef Universities = List<University>;
