part of 'bookings_bloc.dart';

@freezed
class BookingsEvent with _$BookingsEvent {
  const factory BookingsEvent({
    required Hall hall,
    required int seatID,
    required DateTime date,
    required TimeRange slot,
  }) = NewBookingRequested;
  const factory BookingsEvent.update() = UpdateRequested;
  const factory BookingsEvent.delete(Booking booking) = DeleteRequested;
}
