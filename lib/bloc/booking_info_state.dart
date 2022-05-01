part of 'booking_info_bloc.dart';

@freezed
class BookingInfoState with _$BookingInfoState {
  const factory BookingInfoState(BookingsPerSeats bookingsPerSeat) = Showing;
  const factory BookingInfoState.alternative(Slots slots, SeatsList seats) =
      ShowingAlternative;
  const factory BookingInfoState.update() = Update;
  const factory BookingInfoState.loading() = Loading;
  const factory BookingInfoState.error(String message) = ErrorDetails;
}
