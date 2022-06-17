part of 'edisu.dart';

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
    required name,
    required surname,
    required email,
    required this.creationDate,
    required newsletter,
    required notifications,
    required userType,
    required studentCode,
    required studentType,
    required this.studentDisabled,
    required uniID,
    required this.id,
  }) : super(
          name: name,
          surname: surname,
          email: email,
          newsletter: newsletter,
          notifications: notifications,
          userType: userType,
          studentCode: studentCode,
          studentType: studentType,
          uniID: uniID,
        );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
