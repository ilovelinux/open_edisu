import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import '../../features/auth/models/user.dart';
import '../../features/booking/models/booking.dart';
import '../../features/halls/models/halls.dart';
import '../../features/settings/models/settings.dart';
import '../utilities/json/converters.dart';

part 'models/bookingcancel.dart';
part 'models/bookingsperseats.dart';
part 'models/custombooking.dart';
part 'models/halllist.dart';
part 'models/halllistmobile.dart';
part 'models/master.dart';
part 'models/me.dart';
part 'models/seats.dart';
part 'models/signin.dart';
part 'models/slots.dart';
part 'models/studentbookinglist.dart';
part 'models/updatepassword.dart';
part 'models/verifycode.dart';

part 'models.freezed.dart';
part 'models.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class Result<T> {
  final Object? timestamp;
  @JsonKey(readValue: _readStatus)
  final int status;
  @JsonKey(readValue: _readMessage)
  final String message;
  final String? error;
  final T result;

  const Result({
    this.timestamp,
    required this.status,
    required this.message,
    this.error,
    required this.result,
  });

  factory Result.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$ResultFromJson<T>(json, fromJsonT);
}

int _readStatus(json, key) => json[key] ?? json["code"];
String _readMessage(json, key) => json[key] ?? json["messsage"];

@JsonSerializable(genericArgumentFactories: true)
class DataResponse<T> {
  final T data;

  const DataResponse({required this.data});

  factory DataResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$DataResponseFromJson<T>(json, fromJsonT);
}

@JsonSerializable(genericArgumentFactories: true)
class ListResponse<T> {
  final T list;

  const ListResponse({required this.list});

  factory ListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$ListResponseFromJson<T>(json, fromJsonT);
}
