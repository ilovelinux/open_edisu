import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../models/edisu.dart';

part 'booking_table_alternative_event.dart';
part 'booking_table_alternative_state.dart';
part 'booking_table_alternative_bloc.freezed.dart';

class BookingTableAlternativeBloc
    extends Bloc<BookingTableAlternativeEvent, BookingTableAlternativeState> {
  BookingTableAlternativeBloc()
      : super(const BookingTableAlternativeState.unselected()) {
    on<SelectRequested>((event, emit) {
      final slotTime = event.seat.slotTime;

      // Check if the seat is not available in the selected slot time
      if (slotTime == null) {
        return;
      }

      state.when(
        (int row, TimeOfDay startTime, TimeOfDay endTime) {
          if (row != event.row) {
            emit(BookingTableAlternativeState(event.row, slotTime, slotTime));
          } else if (slotTime == startTime) {
            emit(const BookingTableAlternativeState.unselected());
          } else if (slotTime.hour > startTime.hour ||
              (slotTime.hour == startTime.hour &&
                  slotTime.minute >= startTime.minute)) {
            // TODO: Check that all the slots in the middle are available
            //       Maybe it's useless now, since the new table already
            //       do it very easily.
            emit(BookingTableAlternativeState(row, startTime, slotTime));
          } else {
            emit(BookingTableAlternativeState(row, slotTime, slotTime));
          }
        },
        unselected: () =>
            emit(BookingTableAlternativeState(event.row, slotTime, slotTime)),
      );
    });
  }
}
