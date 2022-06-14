part of '../models.dart';

@Freezed(toJson: true)
class BookingCancelRequest with _$BookingCancelRequest {
  const factory BookingCancelRequest({
    required final int bookingId,
  }) = _BookingCancelRequest;
}
