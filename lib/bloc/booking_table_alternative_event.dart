part of 'booking_table_alternative_bloc.dart';

@freezed
class BookingTableAlternativeEvent with _$BookingTableAlternativeEvent {
  const factory BookingTableAlternativeEvent(Seat seat, int row) =
      SelectRequested;
}
