import 'package:json_annotation/json_annotation.dart';

part 'settings.g.dart';

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
