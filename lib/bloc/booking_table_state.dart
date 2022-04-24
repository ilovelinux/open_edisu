part of 'booking_table_bloc.dart';

@freezed
class BookingTableState with _$BookingTableState {
  const factory BookingTableState(BookedSeat seat, TimeRange slot) = Selected;
  const factory BookingTableState.unselected() = Unselected;
}
