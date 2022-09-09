part of '../models.dart';

@Freezed(toJson: true)
class BookingsPerSeatsRequest with _$BookingsPerSeatsRequest {
  const factory BookingsPerSeatsRequest({
    @DateFormatConverter.dMy() required final DateTime date,
    required final String hallId,
  }) = _BookingsPerSeatsRequest;
}

typedef BookingsPerSeatsResponse = Result<BookingsPerSeats>;
