import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../models/edisu.dart';
import '../utilities/dio.dart';
import '../utilities/inceptor.dart';

part 'booking_info_event.dart';
part 'booking_info_state.dart';
part 'booking_info_bloc.freezed.dart';

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
          emit(BookingInfoState(slots, bookingsPerSeats));
        }
      } catch (e) {
        emit(BookingInfoState.error(getErrorString(e)));

        if (kDebugMode) {
          rethrow;
        }
      }
    });
    on<_ChangeAlternativeDate>((event, emit) async {
      date = event.date;
      emit(const BookingInfoState.update());
      emit(const BookingInfoState.loading());

      try {
        final results = await Future.wait(
          <Future>[
            client.getSlots(hall, date: event.date),
            client.getSeats(hall, date: event.date),
          ],
          eagerError: true,
        ); // TODO: Cancel this when date changes

        // Check that date hasn't changed. If it has changed, another
        //  event has been emitted before the end of this.
        if (date == event.date) {
          emit(BookingInfoState.alternativeSuccess(results[0], results[1]));
        }
      } catch (e) {
        emit(BookingInfoState.error(getErrorString(e)));

        if (kDebugMode) {
          rethrow;
        }
      }
    });
  }
}
