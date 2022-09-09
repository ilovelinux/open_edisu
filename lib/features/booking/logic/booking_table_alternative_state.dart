part of 'booking_table_alternative_bloc.dart';

@freezed
class BookingTableAlternativeState with _$BookingTableAlternativeState {
  const factory BookingTableAlternativeState(
      int row, TimeOfDay startTime, TimeOfDay endTime) = Selected;
  const factory BookingTableAlternativeState.unselected() = Unselected;
}
