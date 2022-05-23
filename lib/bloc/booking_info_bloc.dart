import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../models/edisu.dart';
import '../utilities/api.dart';

part 'booking_info_event.dart';
part 'booking_info_state.dart';
part 'booking_info_bloc.freezed.dart';

class BookingInfoBloc extends Bloc<BookingInfoEvent, BookingInfoState> {
  final Hall hall;
  DateTime date = DateTime.now();

  BookingInfoBloc(this.hall) : super(const BookingInfoState.loading()) {
    on<DateChangeRequested>((event, emit) async {
      date = event.date;
      emit(const BookingInfoState.update());
      emit(const BookingInfoState.loading());

      try {
        final result = await getBookingsPerSeat(hall, date: date);

        // Check that date hasn't changed. If it has changed, another
        //  event has been emitted before the end of this.
        if (date == event.date) {
          emit(BookingInfoState(result));
        }
      } catch (e) {
        emit(BookingInfoState.error(e.toString()));
        rethrow;
      }
    });
    on<DateChangeRequestedAlternative>((event, emit) async {
      date = event.date;
      emit(const BookingInfoState.update());
      emit(const BookingInfoState.loading());

      try {
        final results = await Future.wait(<Future>[
          getSlots(hall, date: event.date),
          getSeats(hall, date: event.date),
        ]);

        // Check that date hasn't changed. If it has changed, another
        //  event has been emitted before the end of this.
        if (date == event.date) {
          emit(BookingInfoState.alternative(results[0], results[1]));
        }
      } catch (e) {
        emit(BookingInfoState.error(e.toString()));
      }
    });
  }
}
