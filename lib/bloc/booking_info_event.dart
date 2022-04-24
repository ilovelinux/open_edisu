part of 'booking_info_bloc.dart';

@immutable
abstract class BookingInfoEvent {
  const BookingInfoEvent();
}

class DateChangeRequested extends BookingInfoEvent {
  const DateChangeRequested(this.date);

  final DateTime date;
}

class DateChangeRequestedAlternative extends BookingInfoEvent {
  const DateChangeRequestedAlternative(this.date);

  final DateTime date;
}
