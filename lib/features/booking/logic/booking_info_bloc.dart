import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:open_edisu/core/utilities/dio.dart';
import 'package:open_edisu/core/utilities/inceptor.dart';
import 'package:open_edisu/features/halls/models/halls.dart';
import 'package:open_edisu/features/booking/models/booking.dart';

part 'booking_info_event.dart';
part 'booking_info_state.dart';
part 'booking_info_bloc.freezed.dart';

final log = Logger('BookingInfoBloc');

class BookingInfoBloc extends Bloc<BookingInfoEvent, BookingInfoState> {
  final Hall hall;
  DateTime date = DateTime.now();

  BookingInfoBloc(this.hall) : super(const BookingInfoState.loading()) {
    on<_ChangeDate>((event, emit) async {
      date = event.date;
      emit(const BookingInfoState.update());
      emit(const BookingInfoState.loading());

      try {
        final bookingsPerSeats =
            await client.getBookingsPerSeat(hall, date: date);
        final slots = await client.getSlots(hall, date: date);

        // Check that date hasn't changed. If it has changed, another
        //  event has been emitted before the end of this.
        if (date == event.date) {
          emit(BookingInfoState.success(slots, bookingsPerSeats));
        }
      } catch (e, stackTrace) {
        emit(BookingInfoState.error(getErrorString(e)));

        log.warning("Catched exception on ChangeDate", e, stackTrace);
      }
    });
  }
}
