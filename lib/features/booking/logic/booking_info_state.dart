part of 'booking_info_bloc.dart';

@freezed
class BookingInfoState with _$BookingInfoState {
  const factory BookingInfoState.update() = _Update;
  const factory BookingInfoState.loading() = _Loading;
  const factory BookingInfoState.success(
    final Slots slots,
    final BookingsPerSeats bookingsPerSeat,
  ) = _Success;
  const factory BookingInfoState.error(final String message) = _Error;
}
