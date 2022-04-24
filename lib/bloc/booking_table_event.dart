part of 'booking_table_bloc.dart';

@freezed
class BookingTableEvent with _$BookingTableEvent {
  const factory BookingTableEvent(BookedSeat seat, TimeRange slot) =
      SelectRequested;
}
