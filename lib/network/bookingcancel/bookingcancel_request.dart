import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookingcancel_request.freezed.dart';
part 'bookingcancel_request.g.dart';

@Freezed(toJson: true)
class BookingCancelRequest with _$BookingCancelRequest {
  const factory BookingCancelRequest({
    required final int bookingId,
  }) = _BookingCancelRequest;
}
