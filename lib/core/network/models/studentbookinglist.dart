part of '../models.dart';

@freezed
class StudentBookingListResponse with _$StudentBookingListResponse {
  const factory StudentBookingListResponse({
    required final int status,
    final String? message,
    final String? messsage,
    final String? error,
    final StudentBookingListDataResponse? result,
  }) = _StudentBookingListResponse;

  factory StudentBookingListResponse.fromJson(Map<String, dynamic> json) =>
      _$StudentBookingListResponseFromJson(json);
}

@JsonSerializable()
class StudentBookingListDataResponse {
  @JsonKey(defaultValue: [])
  final Bookings slots;

  const StudentBookingListDataResponse({required this.slots});

  factory StudentBookingListDataResponse.fromJson(Map<String, dynamic> json) =>
      _$StudentBookingListDataResponseFromJson(json);
}
