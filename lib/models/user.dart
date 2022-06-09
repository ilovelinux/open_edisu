part of 'edisu.dart';

@JsonSerializable()
class User {
  final String name;
  final String surname;
  final String email;
  final String creationDate;
  final bool newsletter;
  final bool notification;
  final String userType;
  final String studentCode;
  final int studentType;
  final bool studentDisabled;
  final int uniID;
  final int id;

  const User({
    required this.name,
    required this.surname,
    required this.email,
    required this.creationDate,
    required this.newsletter,
    required this.notification,
    required this.userType,
    required this.studentCode,
    required this.studentType,
    required this.studentDisabled,
    required this.uniID,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
