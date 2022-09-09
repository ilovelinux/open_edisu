import 'package:json_annotation/json_annotation.dart';

part 'halls.g.dart';

@JsonSerializable()
class Hall {
  @JsonKey(fromJson: int.parse)
  final int id;
  final String hname;
  final String hcode;
  final String hpassword;
  @JsonKey(fromJson: int.parse)
  final int hmax;
  @JsonKey(fromJson: int.parse)
  final int husable;
  final String slotTime;
  final String closedFrom;
  final String closedUntil;
  final String floor;
  final String building;
  final String hstatus;

  const Hall({
    required this.id,
    required this.hname,
    required this.hcode,
    required this.hpassword,
    required this.hmax,
    required this.husable,
    required this.slotTime,
    required this.closedFrom,
    required this.closedUntil,
    required this.floor,
    required this.building,
    required this.hstatus,
  });

  factory Hall.fromJson(Map<String, dynamic> json) => _$HallFromJson(json);
}

typedef Halls = List<Hall>;

@JsonSerializable()
class HallMobile {
  final int id;
  final String name;
  final String location;
  final String lat;
  final String long;

  const HallMobile({
    required this.id,
    required this.name,
    required this.location,
    required this.lat,
    required this.long,
  });

  factory HallMobile.fromJson(Map<String, dynamic> json) =>
      _$HallMobileFromJson(json);
}

typedef HallsMobile = List<HallMobile>;
