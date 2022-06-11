import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/edisu.dart';

part 'bookingsperseats_response.freezed.dart';
part 'bookingsperseats_response.g.dart';

@freezed
class BookingsPerSeatsResponse with _$BookingsPerSeatsResponse {
  const factory BookingsPerSeatsResponse({
    required final int status,
    final String? message,
    final String? messsage,
    required final BookingsPerSeats result,
    final String? error,
  }) = _BookingsPerSeatsResponse;

  factory BookingsPerSeatsResponse.fromJson(Map<String, dynamic> json) =>
      _$BookingsPerSeatsResponseFromJson(json);
}
