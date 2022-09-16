import 'package:json_annotation/json_annotation.dart';

import '../../../core/utilities/json/castings.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class UserBase {
  String name;
  String surname;
  String email;
  @JsonKey(fromJson: intToBool)
  bool newsletter;
  @JsonKey(fromJson: intToBool)
  bool notifications;
  String userType;
  String studentCode;
  int studentType;
  int uniID;

  UserBase({
    required this.name,
    required this.surname,
    required this.email,
    required this.newsletter,
    required this.notifications,
    required this.userType,
    required this.studentCode,
    required this.studentType,
    required this.uniID,
  });

  factory UserBase.fromJson(Map<String, dynamic> json) =>
      _$UserBaseFromJson(json);

  Map<String, dynamic> toJson() => _$UserBaseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.none)
class User extends UserBase {
  final int id;
  final String creationDate;
  @JsonKey(fromJson: intToBool)
  final bool studentDisabled;

  User({
    required super.name,
    required super.surname,
    required super.email,
    required this.creationDate,
    required super.newsletter,
    required super.notifications,
    required super.userType,
    required super.studentCode,
    required super.studentType,
    required this.studentDisabled,
    required super.uniID,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
