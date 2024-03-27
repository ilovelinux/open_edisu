import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:open_edisu/core/utilities/extensions/time.dart';

import 'package:open_edisu/features/booking/models/booking.dart';

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
      selected: (BookedSeat oldSeat, TimeRange oldSlot) {
        if (seat.id != oldSeat.id) {
          emit(BookingTableState.selected(seat, slot));
        } else if (slot.timeStart == oldSlot.timeStart) {
          emit(const BookingTableState.unselected());
        } else if (slot.normalizedTimeEnd > oldSlot.timeEnd) {
          final newSlot = TimeRange(
            timeStart: oldSlot.timeStart,
            timeEnd: slot.normalizedTimeEnd,
          );

          if (!seat.isBusy(newSlot)) {
            emit(BookingTableState.selected(seat, newSlot));
          } else if (!seat.isBusy(slot)) {
            emit(BookingTableState.selected(seat, slot));
          }
        } else {
          emit(BookingTableState.selected(seat, slot));
        }
      },
      unselected: () => emit(BookingTableState.selected(seat, slot)),
    );
  }
}
