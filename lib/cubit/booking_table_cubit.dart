import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../utilities/extensions/time.dart';
import '../models/edisu.dart';

part 'booking_table_state.dart';
part 'booking_table_cubit.freezed.dart';

class BookingTableCubit extends Cubit<BookingTableState> {
  BookingTableCubit() : super(const BookingTableState.unselected());

  void select(final BookedSeat seat, final TimeRange slot) {
    // Check if the seat is not available in the selected slot time
    if (seat.isBusy(slot)) {
      return;
    }

    state.when(
      selected: (BookedSeat seat, TimeRange slot) {
        if (seat.id != seat.id) {
          emit(BookingTableState.selected(seat, slot));
        } else if (slot.timeStart == slot.timeStart) {
          emit(const BookingTableState.unselected());
        } else if (slot.timeEnd > slot.timeEnd) {
          final newSlot = TimeRange(
            timeStart: slot.timeStart,
            timeEnd: slot.timeEnd,
          );

          if (!seat.isBusy(newSlot)) {
            emit(BookingTableState.selected(seat, newSlot));
          }
        } else {
          emit(BookingTableState.selected(seat, slot));
        }
      },
      unselected: () => emit(BookingTableState.selected(seat, slot)),
    );
  }
}
