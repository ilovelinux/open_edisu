part of '../models.dart';

@Freezed(toJson: true)
class CustomBookingRequest with _$CustomBookingRequest {
  const factory CustomBookingRequest({
    required final int hallId,
    required final int seatId,
    @DateFormatConverter.dMy() required final DateTime date,
    @TimeOfDayConverter() required final TimeOfDay startTime,
    @TimeOfDayConverter() required final TimeOfDay endTime,
  }) = _CustomBookingRequest;
}
