part of 'bookings_bloc.dart';

@freezed
class BookingsState with _$BookingsState {
  const factory BookingsState(Bookings bookings) = Showing;
  const factory BookingsState.loading() = Loading;
  const factory BookingsState.error(String message) = Error;
}
