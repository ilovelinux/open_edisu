part of 'edisu.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class User {
  final String name;
  final String surname;
  final String email;
  final String creationDate;
  @JsonKey(fromJson: intToBool)
  final bool newsletter;
  @JsonKey(fromJson: intToBool)
  final bool notifications;
  final String userType;
  final String studentCode;
  final int studentType;
  @JsonKey(fromJson: intToBool)
  final bool studentDisabled;
  final int uniID;
  final int id;

  const User({
    required this.name,
    required this.surname,
    required this.email,
    required this.creationDate,
    required this.newsletter,
    required this.notifications,
    required this.userType,
    required this.studentCode,
    required this.studentType,
    required this.studentDisabled,
    required this.uniID,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
