import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import '../../../core/utilities/dio.dart';
import '../../../core/utilities/inceptor.dart';
import '../models/booking.dart';

part 'bookings_event.dart';
part 'bookings_state.dart';
part 'bookings_bloc.freezed.dart';

final log = Logger('BookingsBloc');

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  Bookings bookings = [];

  BookingsBloc() : super(const BookingsState.loading()) {
    on<_Update>((event, emit) async {
      emit(const BookingsState.loading());
      try {
        emit(BookingsState.success(bookings = await client.getBookings()));
      } catch (e, stackTrace) {
        emit(BookingsState.error(getErrorString(e)));

        log.warning("Catched exception on Update", e, stackTrace);
      }
    });
  }
}
