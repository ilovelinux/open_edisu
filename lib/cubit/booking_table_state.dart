part of 'booking_table_bloc.dart';

@freezed
class BookingTableState with _$BookingTableState {
  const factory BookingTableState.selected(
    final BookedSeat seat,
    final TimeRange slot,
  ) = _Selected;
  const factory BookingTableState.unselected() = _Unselected;
}
