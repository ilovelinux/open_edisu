import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../utilities/extensions/time.dart';
import '../models/edisu.dart';

part 'booking_table_event.dart';
part 'booking_table_state.dart';
part 'booking_table_bloc.freezed.dart';

class BookingTableBloc extends Bloc<BookingTableEvent, BookingTableState> {
  BookingTableBloc() : super(const BookingTableState.unselected()) {
    on<SelectRequested>((event, emit) {
      // Check if the seat is not available in the selected slot time
      if (event.seat.isBusy(event.slot)) {
        return;
      }

      state.when(
        (BookedSeat seat, TimeRange slot) {
          if (seat.id != event.seat.id) {
            emit(BookingTableState(event.seat, event.slot));
          } else if (slot.timeStart == event.slot.timeStart) {
            emit(const BookingTableState.unselected());
          } else if (event.slot.timeEnd > slot.timeEnd) {
            final newSlot = TimeRange(
              timeStart: slot.timeStart,
              timeEnd: event.slot.timeEnd,
            );

            if (!event.seat.isBusy(newSlot)) {
              emit(BookingTableState(seat, newSlot));
            }
          } else {
            emit(BookingTableState(seat, event.slot));
          }
        },
        unselected: () => emit(BookingTableState(event.seat, event.slot)),
      );
    });
  }
}
