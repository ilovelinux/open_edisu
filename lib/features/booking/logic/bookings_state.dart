part of 'bookings_bloc.dart';

@freezed
class BookingsState with _$BookingsState {
  const factory BookingsState.loading() = Loading;
  const factory BookingsState.success(final Bookings bookings) = _Showing;
  const factory BookingsState.error(final String message) = _Error;
}
