part of 'booking_info_bloc.dart';

@Freezed(equal: false)
class BookingInfoEvent with _$BookingInfoEvent {
  const factory BookingInfoEvent.changeDate(final DateTime date) = _ChangeDate;
  const factory BookingInfoEvent.changeAlternativeDate(final DateTime date) =
      _ChangeAlternativeDate;
}
